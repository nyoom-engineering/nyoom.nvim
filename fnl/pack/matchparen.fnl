(import-macros {: lazy-require!} :macros.package-macros)
(local {: setup} (lazy-require! :matchparen))

(setup {:on_startup true
        :hl_group :MatchParen
        :augroup_name :matchparen})                    	
