echo "Cloning Required Plugins"

git clone -q --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone -q --depth 1 https://github.com/lewis6991/impatient.nvim\
  ~/.local/share/nvim/site/pack/packer/start/impatient.nvim
git clone -q -b develop --single-branch https://github.com/Olical/aniseed\
  ~/.local/share/nvim/site/pack/packer/start/aniseed
