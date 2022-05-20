(import-macros {: let!} :macros.option-macros)

(local which-key (require :which-key))
(λ key [tbl prop] [(. tbl prop) prop])

;; set leader key
(let! mapleader " ")
(let! maplocalleader " m")

;; easier command line mode
(which-key.register {";" [":" "vim-ex"]})

;; Visuals
(which-key.register {"<leader>t" {:name "Visuals"
                                  "h" ["<cmd>TSHighlightCapturesUnderCursor<cr>" "Capture Highlight"]
                                  "p" ["<cmd>TSPlayground<cr>" "Playground"]
                                  "w" ["<cmd>set wrap!<cr>" "linewrap"]
                                  "z" ["<cmd>TZAtaraxis<cr>" "truezen"]}})

;; NvimTree
(which-key.register {"<leader>op" ["<cmd>NvimTreeToggle<CR>" "nvimtree"]})

;; Conjure
(which-key.register {"<localleader>E" "eval motion"
                     "<localleader>e" "execute"
                     "<localleader>l" "log"
                     "<localleader>r" "reset"
                     "<localleader>t" "test"})

;; Lsp
(λ set-lsp-keys! [bufnr]
  (which-key.register {"<leader>d" {:name "lsp"
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
                                    ; code
                                    "r" (key vim.lsp.buf :rename)
                                    "a" (key vim.lsp.buf :code_action)
                                    "f" (key vim.lsp.buf :formatting)}
                       "<leader>W" {:name "lsp workspace"
                                    "a" (key vim.lsp.buf :add_workspace_folder)
                                    "r" (key vim.lsp.buf :remove_workspace_folder)
                                    "l" [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                                         "list_workspace_folders"]}
                       ; reassgn some builtin mappings
                       "K"  (key vim.lsp.buf :hover)
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
                                  "r" ["<cmd>Telescope old_files<cr>" "Recent Files"]}})

{: set-lsp-keys!}


























