echo "Cloning Required Plugins"

git clone -q --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone -q -b nightly --single-branch https://github.com/rktjmp/hotpot.nvim\
  ~/.local/share/nvim/site/pack/packer/start/hotpot.nvim
