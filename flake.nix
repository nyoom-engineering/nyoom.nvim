{
  description = ":rocket: Blazing Fast Neovim Configuration Written in fennel :rocket::rocket::stars:";

  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, neovim-nightly-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) (import neovim-nightly-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShell = mkShell {
          buildInputs = [
            neovim-nightly
            ripgrep
            fennel
            fnlfmt
            rust-bin.nightly.latest.default
          ];

          shellHook = ''
            alias nvim="nvim -u $(pwd)/init.lua"
          '';
        };
      }
    );
}

