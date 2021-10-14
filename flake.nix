{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    c4.url = "github:fossar/composition-c4";
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
                    src = movim-src;

                    composerDeps = pkgs.c4.fetchComposerDeps {
                      #inherit src;
                      src = movim-src;
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
                };

                devShell = pkgs.mkShell {
                  nativeBuildInputs = [
                    php
                    php.packages.composer
                  ];
                };


              }
        );
}
