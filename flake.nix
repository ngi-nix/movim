{
  description = "A free and open-source podcast hosting solution made for podcasters who want engage and interact with their audience";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # NOTE: change to self if flake is adopted upstream
    movim-src = {
      url = "git+https://github.com/movim/movim";
      flake = false;
    };
    # NOTE: Using Charlie Shanley's flakified fork of composer2nix
    # until the changes are upstreamed
    composer2nix.url = "github:charlieshanley/composer2nix";
  };

  outputs = { self, nixpkgs, movim-src, composer2nix }:
    let

      # Generate a user-friendly version numer
      version = "${builtins.substring 0 8 self.lastModifiedDate}-${self.shortRev or "dirty"}";

      supportedSystems = [ "x86_64-linux" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

      # Nixpkgs instantiated for supported system types with package overlaid
      nixpkgsBySystem = forAllSystems (
        system: import nixpkgs {
          inherit system;
          overlays = [
            self.overlay
            (final: prev: { update-nixified-deps = final.callPackage update-nixified-deps {}; })
          ];
        }
      );


      # It's a shame this is necessary. Alas. Run this after updating the
      # movim-src input: `nix run .#update-nixified-deps`
      update-nixified-deps = { system, nix-prefetch-scripts, writeShellScriptBin }:
        let
          c2n = "${composer2nix.defaultPackage.${system}}/bin";
          nps = "${nix-prefetch-scripts}/bin";
        in
          writeShellScriptBin "update-nixified-dependencies" ''
            export PATH=${c2n}:${nps}:$PATH
            pushd deps
            cp ${movim-src}/package.json \
               ${movim-src}/package-lock.json \
               ${movim-src}/composer.json \
               ${movim-src}/composer.lock \
               ./
            composer2nix --config-file composer.json \
                         --lock-file composer.lock \
                         --no-dev \
                         --output php-packages.nix \
                         --composition php-composition.nix \
                         --composer-env composer-env.nix
            popd
          '';

      defaultConfigFile = ''
        <?php
        $conf = [
          # The type can be 'pgsql', 'mysql' or 'sqlite'
          'type'        => 'pgsql',
          'username'    => 'username',
          'password'    => 'password',
          'host'        => 'localhost',
          'port'        => 5432,
          # The database name, or for SQLite the absolute file path
          'database'    => 'movim'
        ];
      '';

      #devShell =
      #  { pkgs }:
      #    let
      #      php = php.withExtensions (
      #        { enabled, all }:
      #          with all; enabled ++ [ curl mbstring imagick gd pgsql xml ]
      #      );
      #    in
      #      pkgs.mkShell {
      #        nativeBuildInputs = [ php ];
      #      };

      package =
        { inShell ? false
        , configFile ? defaultConfigFile
        , pkgs
        }:
          let
            #inherit (pkgs) php mkShell callPackage substituteAll applyPatches writeText lib
            #  fetchFromGitHub buildGoModule git stdenv rsync runCommand
            #  ;
            inherit pkgs;
            inherit (builtins) toPath;

            configFile' = pkgs.writeText "config/db.inc.php" "${configFile}";
            phpPackage = (
              pkgs.callPackage ./deps/php-composition.nix
                {
                  noDev = false;
                }
            ).overrideAttrs (
              initial: {
                nativeBuildInputs = initial.nativeBuildInputs or [] ++ [ pkgs.php74Extensions.imagick pkgs.git ];
              }
            );
          in
            # Compose the npm and php packages together
            pkgs.runCommand "movim-${version}" {} ''
              mkdir $out
              ${pkgs.rsync}/bin/rsync -a ${phpPackage}/ $out
              chmod -R +w $out

              ln -s ${configFile'} $out/config/db.inc.php
            '';

      forAttrs = attrs: f: nixpkgs.lib.mapAttrs f attrs;

    in
      {

        # A Nixpkgs overlay that adds the package
        overlay = final: prev: { movim = final.callPackage package {}; };

        # The package built against the specified Nixpkgs version
        packages = forAttrs nixpkgsBySystem (
          _: pkgs: {
            inherit (pkgs) movim update-nixified-deps;
          }
        );

        # The default package for 'nix build'
        defaultPackage = forAttrs self.packages (_: pkgs: pkgs.movim);

        # A 'nix develop' environment for interactive hacking
        #devShell = forAttrs self.packages (_: pkgs: pkgs.movim.override { inShell = true; });
        # devShell = { pkgs, }: pkgs.mkShell {};

        devShell = { pkgs, }:
          let
            php = php.withExtensions (
              { enabled, all }:
                with all; enabled ++ [ curl mbstring imagick gd pgsql xml ]
            );
          in
            forAttrs self.packages (
              _: pkgs: pkgs.mkShell {
                nativeBuildInputs = [ php ];
              }
            );


        # A NixOS module
        nixosModules.movim = { config, pkgs, lib, ... }:
          let
            inherit (lib) mkOption mkEnableOption mkIf mkDefault types;
            inherit (pkgs) writeShellScript writeText rsync postgresql;
            cfg = config.services.movim;
            fpm = config.services.phpfpm.pools.movim;
            package = pkgs.movim.override {
              configFile = ''
                <?php
                $conf = [
                  'type'        => 'pgsql',
                  'username'    => '${cfg.user}',
                  'password'    => '${cfg.db_password}',
                  'host'        => 'localhost',
                  'port'        => 5432,
                  # The database name, or for SQLite the absolute file path
                  'database'    => '${cfg.db_name}'
                ];
              '';
            };
            php = pkgs.php.withExtensions (
              { enabled, all }:
                with all; enabled ++ [ curl mbstring imagick gd pgsql xml ]
            );
          in
            {
              options.services.movim = {
                enable = mkEnableOption "movim";
                database = mkOption {
                  type = types.str;
                  default = "movim";
                  description = "Database name";
                };
                user = mkOption {
                  type = types.str;
                  default = "movim";
                  description = "Unix user corresponding to database user";
                };
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
                nixpkgs.overlays = [ self.overlay ];
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
                  user = cfg.user; # TODO is this a bad idea?
                  extraModules = [ "rewrite" "proxy_fcgi" "proxy_wstunnel" ];
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
                    adminAddr = cfg.adminAddr;
                  };
                };
                services.postgresql = {
                  enable = true;
                  ensureDatabases = [ cfg.database ];
                  ensureUsers = [
                    {
                      name = cfg.user;
                      ensurePermissions = { "${cfg.database}.*" = "ALL PRIVILEGES"; };
                    }
                  ];
                };
                systemd =
                  let
                    prep = "movim-prep";
                    periodic = "movim-scheduled-activities";
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
                              composer movim:migrate
                            '';
                          };
                        };
                        movim = {
                          description = "Movim daemon";
                          after = [ "apache2.service" "network.target" "local-fs.target" ];
                          wanterdBy = [ "multi-user.target" ];

                          serviceConfig = {
                            User = "${cfg.user}";
                            Type = "simple";
                            Environment = [];
                            EnvironmentFile = "";
                            ExecStart = "";
                            WorkingDirectory = "";
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

        # configuration for container that runs the module
        nixosConfigurations.container = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            self.nixosModules.movim
            (
              { pkgs, ... }: {
                boot.isContainer = true;

                # Let 'nixos-version --json' know about the Git revision
                # of this flake.
                system.configurationRevision = pkgs.lib.mkIf (self ? rev) self.rev;

                # Network configuration.
                networking.useDHCP = false;
                networking.firewall.allowedTCPPorts = [ 80 443 ];

                # Enable the movim service
                services.movim = {
                  enable = true;
                  baseUrl = "http://movim/";
                  phpOptions = ''
                    post_max_size = 50M
                    upload_max_filesize = 40M
                  '';
                  superadmin = {
                    username = "superadmin";
                    email = "superadmin@example.com";
                  };
                };

                environment.systemPackages = with pkgs; [
                  tmux
                  vim
                  htop
                  tree
                  php80
                ];
              }
            )
          ];
        };


        # TODO Tests run by 'nix flake check' and by Hydra
      };
}
