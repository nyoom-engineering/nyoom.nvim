(import-macros {: use-package!} :conf.macros)

(use-package! :RRethy/nvim-base16 {:config (fn []
                                            (local {: setup} (require :base16-colorscheme))
                                            ;; colors from https://www.ibm.com/brand/experience-guides/developer/brand/color/
                                            (setup {:base00 "#161616"
                                                    :base01 "#262626"
                                                    :base02 "#393939"
                                                    :base03 "#525252"
                                                    :base04 "#FDFDFD"
                                                    :base05 "#FAFAFA"
                                                    :base06 "#FFFFFF"
                                                    :base07 "#c1c7cd"
                                                    :base08 "#dde1e6"
                                                    :base09 "#f2f4f8"
                                                    :base0A "#42be65"
                                                    :base0B "#3ddbd9"
                                                    :base0C "#33b1ff"
                                                    :base0D "#ff7eb6"
                                                    :base0E "#be95ff"
                                                    :base0F "#3ddbd9"}))})
