(require-macros :macros.keybind-macros)
(import-macros {: let!} :macros.option-macros)

;; set leader key
(let! :g.mapleader " ")
(let! :g.localleader ",")

;; Document leader keys with which-key
(doc-map! :n :<leader>f :silent :Files)
(doc-map! :n :<leader>t :silent :Visuals)
(doc-map! :n :<leader>b :silent :Buffers)
(doc-map! :n :<leader>p :silent :Project)
(doc-map! :n :<leader>o :silent :NvimTree)

;; Document top level keys with which-key
(doc-map! :n "<leader>:" :silent :M-x)
(doc-map! :n :<leader><space> :silent "Project Fuzzy Search")

;; who actually uses C-z or ex mode?
(map! [n] :<C-z> :<Nop>)
(map! [n] :Q :<Nop>)

;;jk/jj for escape. Some people like this, others don't
(map! [i] :jk :<esc>)

;; easier command line mode
(map! [n] ";" ":")
(map! [v] ";" ":")

;; move between windows
(map! [n] :<C-h> :<C-w>h)
(map! [n] :<C-j> :<C-w>j)
(map! [n] :<C-k> :<C-w>k)
(map! [n] :<C-l> :<C-w>l)

;; Resize splits
(map! [n] :<C-Up> "<cmd>resize +2<cr>")
(map! [n] :<C-Down> "<cmd>resize -2<cr>")
(map! [n] :<C-Left> "<cmd>vertical resize +2<cr>")
(map! [n] :<C-Right> "<cmd>vertical resize -2<cr>")

;; wrap/unwrap
(map! [n] :<leader>tw "<cmd>set wrap!<CR>")

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; telescope
(map! [n] :<leader>bb "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>ff "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader>pp "<cmd>lua require('telescope').extensions.project.project({ display_type = 'full' })<CR>")
(map! [n] :<leader>fr "<cmd>Telescope oldfiles<CR>")
(map! [n] :<leader>fr "<cmd>Telescope oldfiles<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")

;; nvimtree
(map! [n] :<leader>op :<cmd>NvimTreeToggle<CR>)

;; truezen
(map! [n] :<leader>tz :<cmd>TZAtaraxis<CR>)
