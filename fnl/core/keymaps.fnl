(import-macros {: let!} :macros.variable-macros)

(local which-key (require :which-key))
(λ key [tbl prop] [(. tbl prop) prop])

;; set leader key
(let! mapleader " ")
(let! maplocalleader " m")

;; easier command line mode + 
(which-key.register {";" [":" "vim-ex"]})

;; floating menu
(λ set-cmdline-keys! []
  (which-key.register {":" ["<cmd>FineCmdline<CR>" "vim-ex"]}))

;; Visuals
(which-key.register {"<leader>t" {:name "Visuals"
                                  "h" ["<cmd>TSHighlightCapturesUnderCursor<cr>" "Capture Highlight"]
                                  "p" ["<cmd>TSPlayground<cr>" "Playground"]
                                  "w" ["<cmd>set wrap!<cr>" "linewrap"]
                                  "z" ["<cmd>TZAtaraxis<cr>" "truezen"]
                                  "f" ["<cmd>FloatToggle<cr>" "Toggle term float"]}})
;; window management
(which-key.register {"<leader>w" {:name "Windows"
                                  "<C-w>" ["<cmd>lua require('nvim-window').pick()<cr>" "nvim window"]}})
;; NvimTree
(which-key.register {"<leader>op" ["<cmd>NvimTreeToggle<CR>" "nvimtree"]})
;; (which-key.register {"<leader>on" ["<cmd>ToggleNNN<cr>" "nnn"]})
(which-key.register {"<leader>oN" ["<cmd>ToggleNBB<cr>" "Toggle nbb"]})
(which-key.register {"<leader>ob" ["<cmd>ToggleBTOP<cr>" "Toggle nbb"]})
(which-key.register {"<leader>o-" ["<cmd>NnnPicker %:p:h<cr>" "Nnn Picker"]})
(which-key.register {"<leader>ot" ["<cmd>exe v:count1 . 'ToggleTerm'<cr>" "Open term"]})
(which-key.register {"<leader>oT" ["<cmd>ToggleTerm  direction=tab<cr>" "Open term"]})

(which-key.register {"<leader>sp" ["<cmd>Telescope live_grep<cr>" "Search project"]})
(which-key.register {"<leader>sb" ["<cmd>Telescope current_buffer_fuzzy_find<cr>" "Search in open buffer"]})

(which-key.register {"<leader>gg" ["<cmd>ToggleLazygit<cr>" "Open lazygit"]})

;; Conjure
(which-key.register {"<localleader>E" "eval motion"
                     "<localleader>e" "execute"
                     "<localleader>l" "log"
                     "<localleader>r" "reset"
                     "<localleader>t" "test"})

;; Lsp
(λ set-lsp-keys! [bufnr]
  (which-key.register {"<leader>c" {:name "lsp"
                                    ; inspect
                                    "d" (key vim.lsp.buf :definition)
                                    "D" (key vim.lsp.buf :declaration)
                                    "i" (key vim.lsp.buf :implementation)
                                    "t" (key vim.lsp.buf :type_definition)
                                    "s" (key vim.lsp.buf :signature_help)
                                    "h" (key vim.lsp.buf :hover)
                                    "r" (key vim.lsp.buf :references)
                                    ; diagnstic
                                    "k" (key vim.diagnostic :goto_prev)
                                    "j" (key vim.diagnostic :goto_next)
                                    "w" (key vim.diagnostic :open_float)
                                    "q" (key vim.diagnostic :setloclist)
                                    "x" ["<cmd>TroubleToggle document_diagnostics<cr>" "Diagnostics"]
                                    ; code
                                    ;; "r" (key vim.lsp.buf :rename)
                                    ;; "a" (key vim.lsp.buf :code_action)
                                    "a" ["<cmd>Lspsaga code_action<cr>" "code action"]
                                    "f" (key vim.lsp.buf :formatting)}
                       "<leader>W" {:name "lsp workspace"
                                    "a" (key vim.lsp.buf :add_workspace_folder)
                                    "r" (key vim.lsp.buf :remove_workspace_folder)
                                    "l" [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                                         "list_workspace_folders"]}
                       ; reassgn some builtin mappings
                       ;; "K"  (key vim.lsp.buf :hover)
                       ;; "K"  ["<cmd>Lspsaga hover_doc<cr>" "Documentation"]
                       "<C-j>" ["<cmd>Lspsaga disgnostic_jump_next<cr>" "Jump to next diagnostics"]
                       "<C-k>" ["<cmd>Lspsaga signature_help<cr>" "Signature help"]
                       "gh" ["<cmd>Lspsaga lsp_finder<cr>" "LSP Finder"]
                       "gp" ["<cmd>Lspsaga preview_definition<cr>" "Preview Definition"]
                       "gr" ["<cmd>Lspsaga rename<cr>" "LSP rename"]
                       "gd" (key vim.lsp.buf :definition)
                       "gD" (key vim.lsp.buf :declaration)}
               ; only for one buffer
               {:buffer bufnr}))

;; Telescope
(which-key.register {"<leader>bb" ["<cmd>Telescope buffers<CR>" "Buffers"]})
(which-key.register {"<leader>pp" ["<cmd>lua require('telescope').extensions.project.project({ display_type = 'full' })<CR>" "Projects"]})
(which-key.register {"<leader>:" ["<cmd>Telescope commands<CR>" "M-x"]})
(which-key.register {"<leader><space>" ["<cmd>Telescope find_files<CR>" "Project Files"]})
(which-key.register {"<leader>f" {:name "Files"
                                  "f" ["<cmd>Telescope current_buffer_fuzzy_find<cr>" "Grep Buffer"]
                                  "r" ["<cmd>Telescope oldfiles<cr>" "Recent Files"]}})

{: set-lsp-keys!
 : set-cmdline-keys!}
