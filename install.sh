echo "Cloning Required Plugins"

git clone -q --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone -q -b nightly --single-branch https://github.com/rktjmp/hotpot.nvim\
  ~/.local/share/nvim/site/pack/packer/start/hotpot.nvim

echo "Building Colorscheme"

cargo build --release --manifest-path=fnl/oxocarbon/Cargo.toml

echo "Creating Directories"

mkdir lua

echo "Copying Libraries"

if [ "$(uname)" == "Darwin" ]; then
    mv ~/.config/nvim/fnl/oxocarbon/target/release/liboxocarbon.dylib ~/.config/nvim/lua/oxocarbon.so
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    mv ~/.config/nvim/fnl/oxocarbon/target/release/liboxocarbon.so ~/.config/nvim/lua/oxocarbon.so
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    mv ~/.config/nvim/fnl/oxocarbon/target/release/oxocarbon.dll ~/.config/nvim/lua/oxocarbon.dll
fi

nvim -c 'PackerSync'
