(import-macros {: use-package!} :macros)

(use-package! :akinsho/bufferline.nvim {:opt true
                                        :defer bufferline.nvim
                                        :call-setup bufferline})
