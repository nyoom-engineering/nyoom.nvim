//! Alpacka: the next-generation package manager for neovim.
//!
//! The library version of alpacka is designed to be used by other programs to interact and run the alpacka package manager.
//! It exports library functions to load configurations, manifests, and packages.
//! It also exports functions to run the package manager, such as resolving and loading plugins.
//!
//! This is NOT meant to be used by end-users, but rather by other programs that want to use alpacka as a library, such as a user-facing GUI/neovim plugin.
pub mod config;
pub mod manifest;
pub mod package;
pub mod smith;
