(import-macros {: use-package!} :macros)

(use-package! "https://codeberg.org/esensar/nvim-dev-container"
              {:nyoom-module tools.docker
               :cmd [:DevcontainerBuild
                     :DevcontainerImageRun
                     :DevcontainerBuildAndRun
                     :DevcontainerBuildRunAndAttach
                     :DevcontainerComposeUp
                     :DevcontainerComposeDown
                     :DevcontainerComposeRm
                     :DevcontainerStartAuto
                     :DevcontainerStartAutoAndAttach
                     :DevcontainerAttachAuto
                     :DevcontainerStopAuto
                     :DevcontainerStopAll
                     :DevcontainerRemoveAll
                     :DevcontainerLogs
                     :DevcontainerOpenNearestConfig
                     :DevcontainerEditNearestConfig]})
