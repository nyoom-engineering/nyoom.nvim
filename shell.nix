{ pkgs ? import <nixpkgs> {
  overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
} }:
with pkgs;
mkShell {
  buildInputs = [ neovim-nightly ripgrep fennel fnlfmt ];
  shellHook = ''
    alias nvim="nvim -u $(pwd)/init.lua"
  '';
}
