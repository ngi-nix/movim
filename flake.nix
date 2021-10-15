{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    c4.url = "github:fossar/composition-c4";

    # NOTE: change this to self if flake gets merged upstream
    movim-src.url = "github:movim/movim";
    movim-src.flake = false;
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , c4
    , movim-src
    }:
      let
        overlays = [ c4.overlay ];
      in
        flake-utils.lib.eachDefaultSystem (
          system:
            let
              pkgs = import nixpkgs { inherit system overlays; };
              php = (
                pkgs.php74.withExtensions (
                  { enabled, all }:
                    with all; enabled ++ [ curl mbstring imagick gd pgsql ]
                )
              );
              composer = php.packages.composer;
              defaultConfigFile = ''
                <?php
                $conf = [
                  # The type can be 'pgsql', 'mysql' or 'sqlite'
                  'type'        => 'pgsql',
                  'username'    => 'movim',
                  'password'    => 'movim',
                  'host'        => 'localhost',
                  'port'        => 5432,
                  # The database name, or for SQLite the absolute file path
                  'database'    => 'movim'
                ];
              '';
            in
              rec {
                defaultPackage = packages.movim;
                packages.movim = pkgs.callPackage (
                  { configFile ? defaultConfigFile }:
                    let
                      configFile' = pkgs.writeText "db.inc.php" "${configFile}";
                    in
                      pkgs.stdenv.mkDerivation rec {
                        pname = "movim";
                        version = "0.0.1";
                        #version =
                        #  "${builtins.substring 0 8 self.lastModifiedDate}-${self.shortRev or "dirty"}";
                        src = movim-src;

                        nativeBuildInputs = [
                          #php.packages.composer
                          pkgs.c4.composerSetupHook
                        ];
                        propagatedBuildInputs = [ composer ];

                        composerDeps = pkgs.c4.fetchComposerDeps { inherit src; };

                        installPhase = ''
                          runHook preInstall

                          ${composer}/bin/composer install

                          mkdir cache
                          mkdir public/cache
                          mkdir log
                          cp -r . $out
                          ln -s ${configFile'} $out/config/db.inc.php

                          runHook postInstall
                        '';
                      }
                ) {};

                devShell = pkgs.mkShell {
                  nativeBuildInputs = [
                    php
                    composer
                  ];
                };

                nixosModules.movim = { config, pkgs, lib, ... }: let
                  inherit (lib) mkOption mkEnableOption mkIf mkDefault types;
                  inherit (pkgs) writeShellScript writeText rsync postgresql;
                  cfg = config.services.movim;
                  package = packages.movim.override {
                    configFile = ''
                      <?php
                      $conf = [
                        # The type can be 'pgsql', 'mysql' or 'sqlite'
                        'type'        => 'pgsql',
                        'username'    => '${cfg.user}',
                        'password'    => '${cfg.db_password}',
                        'host'        => '${cfg.db_host}',
                        'port'        => 5432,
                        # The database name, or for SQLite the absolute file path
                        'database'    => '${cfg.db_name}'
                      ];
                    '';
                  };
                in
                  {
                    options.services.movim = {
                      enable = mkEnableOption "movim";
                      db_name = mkOption {
                        type = types.str;
                        default = "movim";
                        description = "Database name";
                      };
                      db_host = mkOption {
                        type = types.str;
                        default = "localhost";
                        description = "Database host";
                      };
                      user = mkOption {
                        type = types.str;
                        default = "movim";
                        description = "Unix user corresponding to database user";
                      };
                      db_password = mkOption {
                        type = types.str;
                        default = "movim";
                        description = "Database password";
                      };
                      # TODO add to cfg too
                      forceHttps = mkOption {
                        type = types.bool;
                        default = false;
                        description = "If true, redirects all http requests to use https";
                      };
                      baseUrl = mkOption {
                        type = types.str;
                        default = "http://localhost/";
                        description = "Base URL";
                      };
                      poolConfig = mkOption {
                        type = with types; attrsOf (oneOf [ str int bool ]);
                        default = {
                          "pm" = "dynamic";
                          "pm.max_children" = 32;
                          "pm.start_servers" = 2;
                          "pm.min_spare_servers" = 2;
                          "pm.max_spare_servers" = 4;
                          "pm.max_requests" = 500;
                        };
                        description = ''
                          Options for the PHP pool. See the documentation on <literal>php-fpm.conf</literal>
                          for details on configuration directives.
                        '';
                      };
                      phpOptions = mkOption {
                        type = types.lines;
                        default = "";
                        description = "Lines to be added to php.ini for the pool serving the app";
                      };

                      adminAddr = mkOption {
                        type = types.str;
                        default = "admin@localhost";
                        description = "Email address of the httpd server administrator";
                      };
                    };

                    config = mkIf cfg.enable {
                      #nixpkgs.overlays = [ self.overlay ];
                      users = {
                        users.${cfg.user} = {
                          group = cfg.user;
                          isSystemUser = true;
                          createHome = false;
                        };
                        groups.${cfg.user} = {};
                      };

                      services.phpfpm = {
                        phpPackage = php;
                        pools.movim = {
                          inherit (cfg) user phpOptions;
                          settings = {
                            "listen.owner" = config.services.httpd.user;
                          } // cfg.poolConfig;
                        };
                      };

                      services.httpd = {
                        enable = true;
                        #user = cfg.user;
                        extraModules = [ "rewrite" "proxy_fcgi" "proxy_wstunnel" ];
                        adminAddr = cfg.adminAddr;

                        virtualHosts.movim = {
                          documentRoot = "${package}/public";
                          extraConfig = ''
                            ProxyPass /movim/ws/ ws://127.0.0.1:8080/
                            Alias /movim/ ${package}/public/

                            <Directory ${package}/public/>
                                DirectoryIndex index.php
                                Options +FollowSymLinks -Indexes
                                AllowOverride FileInfo Options
                            </Directory>

                            <Location /movim/>
                                Header set Access-Control-Allow-Origin "*"
                            </Location>
                          '';
                        };
                      };
                      services.postgresql = {
                        enable = true;
                        ensureDatabases = [ cfg.db_name ];
                        ensureUsers = [
                          {

                            name = cfg.user;
                            ensurePermissions = { "DATABASE ${cfg.db_name}" = "ALL PRIVILEGES"; };
                          }
                        ];
                        authentication = lib.mkForce ''
                          local all all trust
                          host all ${cfg.user} localhost trust
                        '';

                      };
                      systemd = let
                        prep = "movim-prep";
                        daemon = "movim-daemon";
                      in
                        {
                          services = {
                            ${prep} = {
                              description = "Movim preparation";
                              wantedBy = [ "multi-user.target" ];
                              requires = [ "postgresql.service" ];
                              after = [ "postgresql.service" ];
                              path = [ php postgresql ];
                              serviceConfig = {
                                Type = "oneshot";
                                User = cfg.user;
                                PermissionsStartOnly = true;
                                WorkingDirectory = package;
                                ExecStart = writeShellScript "movim-init-db" ''
                                  ${composer}/bin/composer movim:migrate
                                '';
                              };
                            };
                            ${daemon} = {
                              description = "Movim daemon";
                              after = [ "apache2.service" "network.target" "local-fs.target" ];
                              wantedBy = [ "multi-user.target" ];

                              serviceConfig = {
                                User = "${cfg.user}";
                                Type = "simple";
                                # TODO check movim docs for env vars
                                #Environment = [];
                                #EnvironmentFile = "";
                                WorkingDirectory = package;
                                ExecStart = writeShellScript "movim-start" ''
                                  ${php}/bin/php daemon.php start --url=${cfg.baseUrl}
                                '';
                                StandardOutput = "syslog";
                                SyslogIdentifier = "movim";
                                PIDFile = "/run/movim.pid";
                                Restart = "on-failure";
                                RestartSec = 10;
                              };
                            };
                          };
                        };
                    };
                  };

              }
        );
}
