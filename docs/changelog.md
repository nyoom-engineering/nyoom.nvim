v0.4.1
- Colorscheme: Move colorscheme into its own plugin, simplify colorscheme macros
- Macros: Add aniseed support, fixes left and right, move packer macros into the main pack! statement as additional keys. Initial support for modules/after macros
- Bindings: Add autopairs support, fix tabs, add more mappings and hydras
- Loading: remove lazy-loading utils in favor of new keys and defer support.  
- Lsp: Add support for off-spec lsp servers (java/rust). Improve loading and updates 
- Packer: Added :defer key ala use-package, as a result of macro improvements, improve startuptime by an additional 5-10ms or so. Not much but still nice 
- Other notes: lots of misc improvements here and there, especially to grep and spell. Check out the diff!

v0.4.0
Sorry, haven't done one of these in a while! Lots of fixes
- Colorscheme: Rewrite in rust and general improvements to plugin support and to the light theme
- Macros: Remove Md5 dependency. General improvements to package, keybinding, event, and other macros.
- Bindings: Added support for hydra and deprecated which-key.nvim
- Loading: Improve lazy loading, clean up config, remove bootstrap lua filetype by default
- Lsp: cmp improvements, replace nvim-lsp-installer with mason.nvim, and general bugfixes. Added support for off-spec lsp servers (jdtls & rust-analyzer)

v0.3.4
- Colorscheme: Automatically changes based on `vim.opt.background`. Light palette added
- Macros: Added event/command macros. Minor adjustments to packer macros
- Bindings: Small fix for normal-mode bindings
- Loading: Fixes to bootstrapping and loading order. Defer lsp/lspinstaller. Add option to use tangerine.nvim
- Lsp: Add nvim-lsp-installer. Cleanups
- Packer: Automatically compile & require compiled file from within pack.fnl. 

v0.3.3
- Colorscheme: Rewrite in fennel + macros using nvim api
- Macros: Rewrite of options macros. Replace keymap macros with which-key
- Bindings: Conjure/hotpot/fennel compilation and evalulation. Use Which-Key
- Treesitter/Loading: Fixes for ts-rainbow, telescope.nvim
- Lsp: Add lsp-signature, improve loading and fix fidget
- Packer: Cleaned up implementation

v0.3.2
- removed nvim-parinfer and wrote fennel version based on ffi + parinfer-rust. (sidenote: I love how easy neovim makes this, back when I started vim learning enough vimscript to do this was a pipe dream. Long live lua! (and fennel))
- WIP Treesitter + matchparen speed improvements
- Properly configured nvimtree
- Nvim-bufferline integrations 
- Minor defs/fillchars/lsp/cmp updates
- Macro updates and optimizations

v0.3.1
- More fennel! ~~Init is rewritten in fennel~~ (update: This caused the config to load after runtime files, which meant that `filetype.lua` stopped working. I've sinced reverted back to `init.lua` for now), and lua dependencies (md5 lib) were removed.
- Refactored the entire config. New directory structure, parted out macros, and cleaned up code. 
- Statusline has been added! Thin and light global statusline to align with nyoom's philosphies.
- Lsp/Cmp configs have been re-done. Lsp is now much quicker to load and is a much cleaner implementation. Cmp is much quicker, integrates properly with copilot, and everything was reworked from the ground up.
- Improved highlighting macros: Highlights are now applied via `nvim_set_hl`.
- Improved startuptime by 20-30ms: decreased lazy loading and optimized code. 
- Improved keybinding support: macros for buffer-local mappings and which-key documentation have been added. Nyoom default bindings are now documented within which-key
- Improved treesitter integration. Textobjects and support for conjure evaluation using treesitter have been added. 

v0.3.0 and earlier
- Nyoom existed. I guess


