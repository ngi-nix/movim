{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    c4.url = "github:fossar/composition-c4";
<<<<<<< HEAD
=======

    # NOTE: change this to self if flake gets merged upstream
    movim-src.url = "github:movim/movim";
    movim-src.flake = false;
>>>>>>> flake_only
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , c4
<<<<<<< HEAD
=======
    , movim-src
>>>>>>> flake_only
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
<<<<<<< HEAD
                    with all; enabled ++ [ curl mbstring imagick gd pgsql xml ]
                )
              );
            in
              rec {
                #defaultPackage = packages.${system}.movim;
                packages = {
                  movim = pkgs.stdenv.mkDerivation {
                    pname = "movim";
                    version = "0.1.1";
                    src = ./.;

                    composerDeps = pkgs.c4.fetchComposerDeps {
                      #inherit src;
                      src = ./.;
=======
                    with all; [ xml curl mbstring imagick gd pgsql ]
                )
              );
              defaultConfigFile = "";
            in
              rec {
                defaultPackage = packages.movim;

                packages.movim =
                  #packages.movim = pkgs.callPackage (
                  #{ configFile ? defaultConfigFile }:
                  #let
                  #  configFile' = pkgs.writeText "db.inc.php" "${configFile}";
                  #in
                  pkgs.stdenv.mkDerivation rec {
                    pname = "movim";
                    # Generate a user-friendly version numer
                    version = "${builtins.substring 0 8 self.lastModifiedDate}-${self.shortRev or "dirty"}";
                    src = movim-src;

                    composerDeps = pkgs.c4.fetchComposerDeps {
                      #inherit src;
                      src = movim-src;
>>>>>>> flake_only
                    };

                    nativeBuildInputs = [
                      php.packages.composer
                      pkgs.c4.composerSetupHook
                    ];

                    installPhase = ''
                      runHook preInstall

                      composer install
                      cp -r . $out

                      runHook postInstall
                    '';
                  };
<<<<<<< HEAD
                };

                devShell = pkgs.mkShell {
                  nativeBuildInputs = [
                    pkgs.php74.composer
                    (
                      pkgs.php74.withExtensions (
                        { enabled, all }:
                          with all; enabled ++ [ curl mbstring imagick gd pgsql xml ]
                      )
                    )
                  ];
                };

=======
                #) {};

                devShell = pkgs.mkShell {
                  nativeBuildInputs = [
                    php
                    pkgs.php74Packages.composer
                  ];
                };

                #nixosModules.movim = { config, pkgs, lib, ... }: let
                #  inherit (lib) mkOption mkEnableOption mkIf mkDefault types;
                #  inherit (pkgs) writeShellScript writeText rsync postgresql;
                #  cfg = config.services.movim;
                #  package = packages.movim.override {
                #    configFile = "";
                #  };
                #in
                #  {};
>>>>>>> flake_only

              }
        );
}
