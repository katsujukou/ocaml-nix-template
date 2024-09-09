{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, ocaml-overlay }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            ocaml-overlay.overlays.default
          ];
        };
      in
        {
          devShells.default = pkgs.mkShellNoCC {
            buildInputs = with pkgs.ocamlPackages; [
              ### ocaml dependencies ###
              alcotest
              
              ### ocaml compiler and toolchain ###
              ocaml
              ocaml-lsp
              ocamlformat
              odoc
              dune 
              findlib
            ];
          };
        }
    );
}
