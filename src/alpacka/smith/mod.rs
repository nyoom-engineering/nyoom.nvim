pub mod enums;
mod git;
pub use git::Git;
use std::{
    fmt::{Debug as FmtDebug, Display},
    path::Path,
};

use crate::package::Package;
use error_stack::{Context, Result as ErrorStackResult};

#[derive(Debug)]
/// An error that can occur when resolving a package
pub struct ResolveError;

impl Display for ResolveError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str("Failed to resolve package")
    }
}

impl Context for ResolveError {}

#[derive(Debug)]
/// An error that can occur when loading a package
pub struct LoadError;

impl Display for LoadError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str("Failed to load package")
    }
}

impl Context for LoadError {}

/// A marker trait for loader inputs.
/// This trait is used to allow the loader input to be serialized and deserialized.
pub trait LoaderInput: FmtDebug + Send + Sync {}

/// A smith that can be used to resolve and load a package.
///
/// There are 2 main parts to a smith:
/// 1. A resolver that can resolve a config package to a loader package, which has all the necessary information to load the package. This is cached inside of the generation file.
/// 2. A loader that can download and install the package, and run the build script.
pub trait Smith: FmtDebug + Send + Sync {
    type Input: LoaderInput;

    /// Gets the name of the smith
    fn name(&self) -> String;

    /// Check if this smith can load the given package. If it can, it will return the name of the package.
    /// This is used to find the correct smith for a package
    fn get_package_name(&self, name: &str) -> Option<String>;

    /// Resolve a package to a loader package, which has all the necessary information to load the package.
    /// This is cached inside of the generation file.
    ///
    /// # Errors
    /// This function will return an error if the package cannot be resolved.
    fn resolve(&self, package: &Package) -> ErrorStackResult<Self::Input, ResolveError>;

    /// Get latest commits for a git repo.
    ///
    /// # Errors
    /// This function will return an error if it cannot find the changes.
    fn get_change_log(
        &self,
        old_sha: Option<git2::Oid>,
        path: &Path,
    ) -> ErrorStackResult<Vec<String>, LoadError>;

    /// Loads a package.
    /// This downloads and installs the package to the given directory.
    ///
    /// # Errors
    /// This function will return an error if the package cannot be loaded.
    fn load(&self, input: &Self::Input, package_path: &Path) -> ErrorStackResult<(), LoadError>;
}
