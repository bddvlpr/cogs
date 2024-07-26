{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    schemat.url = "github:bddvlpr/schemat";
    schemat.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        lib,
        inputs',
        ...
      }: {
        formatter = pkgs.alejandra;

        checks = {
          format = let
            inherit (inputs'.schemat.packages) schemat;
          in
            pkgs.stdenvNoCC.mkDerivation {
              name = "format-check";
              src = ./.;

              buildInputs = [schemat];

              buildPhase = ''
                schemat -c "**/*.scm" > $out
              '';
            };
        };
      };
    };
}
