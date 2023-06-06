(import-macros {: use-package! : pack} :macros)

(use-package! :nvim-lua/telescope.nvim
              {:nyoom-module completion.telescope
               :module [:telescope]
               :cmd :Telescope
               :requires [(pack :nvim-telescope/telescope-ui-select.nvim
                                {:opt true})
                          (pack :nvim-telescope/telescope-file-browser.nvim
                                {:opt true})
                          (pack :nvim-telescope/telescope-media-files.nvim
                                {:opt true})
                          (pack :nvim-telescope/telescope-project.nvim
                                {:opt true})
                          (pack :LukasPietzschmann/telescope-tabs 
                                {:opt true})
                          (pack :jvgrootveld/telescope-zoxide {:opt true})]})
