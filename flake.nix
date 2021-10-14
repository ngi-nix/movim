{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    c4.url = "github:fossar/composition-c4";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , c4
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
                    src = ./.;

                    composerDeps = pkgs.c4.fetchComposerDeps {
                      #inherit src;
                      src = ./.;
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
                    pkgs.php74.composer
                    (
                      pkgs.php74.withExtensions (
                        { enabled, all }:
                          with all; enabled ++ [ curl mbstring imagick gd pgsql xml ]
                      )
                    )
                  ];
                };


              }
        );
}
