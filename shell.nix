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
  buildInputs = [ neovim-nightly luajit ripgrep nodejs-16_x ];
  shellHook = ''
    alias nvim="nvim -u $(pwd)/init.lua"
  '';
}
