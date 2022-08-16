;; NOTE: This isn't quite ready yet :) check back later! Or scroll down for a little story

;; As the readme mentions, nyoom was an answer to and will always be an answer 
;; to abstracted and complex codebases that take away end-user extensibility, 
;; try to be a one-size-fits-all config, and needlessly lazy load everything.
;; However, this config is still tailored to me and as it grows, that turns into
;; a bit of an issue. Theres plugins people might not like, configurations they
;; might want to change, and my answer to this has always been "fork it and
;; change it yourself." I don't think going forward, that this is the correct
;; reponse. Maybe therees dozens of people who want to configure the same
;; plugin, duplicating those efforts are a massive waste of time

;; Doom-emacs has a neat solution to this: modules. Each plugin, or set of
;; plugins is stored in its own module. Those modules can then be enabled and
;; disabled by the user, user-packages are stored seperately from "core"
;; packages, and the user can write their own configuration on top of whats
;; provided by doom. Now of course, why copy doom for neovim when such a thing 
;; exists already, doom-nvim?

;; Theres two issues there: 
;; 1. nothing should, or can be a copy of doom-emacs for neovim. Doom is
;; enhancing emacs' built in features. neovim is not emacs. neovim will never be
;; emacs. Instead of copying doom, the goal of this config is to create
;; something that mimicks the feel, speed, and modularity of doom while enhancing
;; and building on neovim. Here and there there will probably be a bit of
;; copying of emacs' features, such as org-mode, Scratch, lisp-interaction-mode,
;; parinfer, etc, but it will still feel like something different 
;; 2. doom-nvim is nothing close to doom-emacs. Apart from having something by
;; the name of modules, doom-nvim seems to miss everything that makes doom emacs
;; what it is. And thats because it ignores how neovim works. Emacs package
;; management and neovim package management are not the same and never will be,
;; and its important to recognize that

;; So, a roadmap

;; 1. Recreate the experience of doom/emacs with macros. For reference, what
;; doom adds is available to view here: 
;; https://github.com/doomemacs/doomemacs/blob/master/modules/lang/emacs-lisp/demos.org
;; This is coming along quite nicely, a lot of the features of use-package are 
;; aleady replacted with some minor wrapping of packer + defer and whatnot. Of
;; course only a subset of features are going to be replemented, as quite a few
;; emacs features (e.g. hooks) doen't exist the same in neovim (autocommands)
;; and others (e.g. map!) are slightly different as emacs and neovim (chording
;; vs native modal editing). That being said, package management and soon module
;; management are almost done, native neovim settings/autocommands/manipulation
;; is done, and now its just a matter of adding in (after!) and other niceities

;; 2. Split everything up into modules. Of course, once the module syntax is
;; done its just a matter of splitting up the current configuration into modules
;; and whatnot. Its pretty simple, a lot of the work has already been done in
;; another branch.

;; 3. Decouple "required" sets of plugins. Plugins like LuaSnip and CMP depend
;; on each other when they don't need to, hydra depends on gitsigns, etc. Its
;; nessecary to decouple these modules so users can enable/disable them
;; independantly, probably best done with a featurep macro and a little macro &
;; packer trickery

;; 3. Add missing modules. Doom has a LOT of modules by default, especially for
;; languages. Likely the few I use I'll add, as well as a few other popular
;; ones, and users of the languages mentioned in the `lang` modules can add and
;; maintain those themselves. Ideally I'd like everything to be centralized,
;; just because its eaiser to iterate on

;; 4. Implement a proper "user" configuration. This means seperate
;; ~/.config/nvim and ~/.config/nyoom, the "core" will go in the latter and the
;; users configuration in the former, complete with custom modules, their own
;; packages, exactly like doom handles it. 
