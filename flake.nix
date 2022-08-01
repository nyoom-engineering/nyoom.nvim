{
  description =
    ":rocket: Blazing Fast Neovim Configuration Written in fennel :rocket::rocket::stars:";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.neovim-nightly-overlay.url =
    "github:nix-community/neovim-nightly-overlay";

  outputs =
    { self, nixpkgs, flake-utils, neovim-nightly-overlay }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "nyoom.nvim";
      preOverlays =
        [ neovim-nightly-overlay.overlay ];
      shell = { pkgs }:
        pkgs.mkShell {
          # https://nix.dev/anti-patterns/language#with-attrset-expression
          packages =
            builtins.attrValues { inherit (pkgs) neovim-nightly ripgrep cargo; };
          shellHook = ''
            echo "Cloning Required Plugins"
            
            git clone -q --depth 1 https://github.com/wbthomason/packer.nvim\
              ~/.local/share/nvim/site/pack/packer/start/packer.nvim
            git clone -q -b nightly --single-branch https://github.com/rktjmp/hotpot.nvim\
              ~/.local/share/nvim/site/pack/packer/start/hotpot.nvim
            
            echo "Building Configuration"
            
            cargo build --release --manifest-path=fnl/oxocarbon/Cargo.toml
            cargo build --release --manifest-path=fnl/oxidized-core/Cargo.toml
            
            echo "Creating Directories"
            
            mkdir lua
            
            echo "Copying Libraries"
            
            if [ "$(uname)" == "Darwin" ]; then
                mv ~/.config/nvim/fnl/oxocarbon/target/release/liboxocarbon.dylib ~/.config/nvim/lua/oxocarbon.so
                mv ~/.config/nvim/fnl/oxidized-core/target/release/liboxidized_core.dylib ~/.config/nvim/lua/oxidized_core.so
            elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
                mv ~/.config/nvim/fnl/oxocarbon/target/release/liboxocarbon.so ~/.config/nvim/lua/oxocarbon.so
                mv ~/.config/nvim/fnl/oxidized-core/target/release/liboxidized_core.so ~/.config/nvim/lua/oxidized_core.so
            elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
                mv ~/.config/nvim/fnl/oxocarbon/target/release/oxocarbon.dll ~/.config/nvim/lua/oxocarbon.dll
                mv ~/.config/nvim/fnl/oxidized-core/target/release/oxidized_core.dll ~/.config/nvim/lua/oxidized_core.dll
            fi
            
            nvim -u $(pwd)/init.lua --cmd 'set rtp+=$(pwd)' -c 'PackerSync'
          '';
        };
    };
}
