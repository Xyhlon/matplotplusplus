{
  description = "A C++ Graphics Library for Data Visualization";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = pkgs.stdenv.mkDerivation (finalAttrs: {
            name = "matplotplusplus";

            version = "v1.2.1";

            propagatedBuildInputs = with pkgs; [
              gnuplot
            ];

            src = pkgs.fetchFromGitHub {
              owner = "alandefreitas";
              repo = "matplotplusplus";
              rev = finalAttrs.version;
              hash = "sha256-ZEVQA+GcwCGvThHtdP5DuLb5MujwmxdCdnY7rc/Lrl4=";
            };

            nativeBuildInputs = with pkgs; [cmake libgcc];

            meta = with pkgs.lib; {
              description = "A C++ Graphics Library for Data Visualization";
              homepage = "https://github.com/alandefreitas/matplotplusplus";
              license = licenses.mit;
              # maintainers = with maintainers; [ cpcloud ];
              platforms = platforms.all;
            };
          });
        };
        formatter = nixpkgs.legacyPackages.${system}.alejandra;
      }
    );
}
