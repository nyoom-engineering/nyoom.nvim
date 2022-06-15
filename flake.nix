{
  description = ":rocket: Blazing Fast Neovim Configuration Written in fennel :rocket::rocket::stars:";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , neovim-nightly-overlay
    }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "nyoom.nvim";
      preOverlays = [ neovim-nightly-overlay.overlay ];
      shell = { pkgs }:
        pkgs.mkShell {
          # https://nix.dev/anti-patterns/language#with-attrset-expression
          packages = builtins.attrValues {
            inherit
              (pkgs)
              neovim-nightly
              ripgrep
              fennel
              fnlfmt
              ;
          };

          shellHook = ''
            alias nvim="nvim -u $(pwd)/init.lua" --cmd "set rtp+=$(pwd)"
          '';
        };
    };
}
