.PHONY: help aniseed hotpot compile clean sync

aniseed:
	git clone -q --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
	git clone -q --depth 1 https://github.com/lewis6991/impatient.nvim ~/.local/share/nvim/site/pack/packer/start/impatient.nvim
	git clone -q -b develop --single-branch https://github.com/Olical/aniseed ~/.local/share/nvim/site/pack/packer/start/aniseed
	nvim --headless -u NONE -c "lua require('aniseed.compile').glob('fnl/*.fnl', 'fnl', 'lua')" +q

hotpot:
	git clone -q --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
	git clone -q -b nightly --single-branch https://github.com/rktjmp/hotpot.nvim.git ~/.local/share/nvim/site/pack/packer/start/hotpot.nvim

clean:
	rm -r ~/.cache/nvim/
	sudo rm -r ~/.local/share/nvim/
	rm -r ~/.config/nvim/lua/

sync:
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'packadd packer.nvim' -c 'PackerSync'

help:
	@echo "make aniseed -- install deps for aniseed" >&2
	@echo "make hotpot -- install deps for hotpot" >&2
	@echo "make compile  -- compile config into lua" >&2
	@echo "make clean -- clean up neovim files" >&2
	@echo "make help -- print this message and exit" >&2
