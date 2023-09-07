use std::path::Path;

use bytecheck::CheckBytes;
use error_stack::Result;
use rkyv::{Archive, Deserialize, Serialize};

use super::{git::Input, Git, LoadError, ResolveError, Smith};

#[derive(Debug)]
pub enum Loaders {
    Git(Git),
}

impl Loaders {
    #[must_use]
    pub fn name(&self) -> String {
        match self {
            Self::Git(git) => git.name(),
        }
    }

    #[must_use]
    pub fn get_package_name(&self, name: &str) -> Option<String> {
        match self {
            Self::Git(git) => git.get_package_name(name),
        }
    }

    /// Resolve the input for a package
    ///
    /// # Errors
    /// This function will return an error if the package cannot be resolved.
    pub fn resolve(&self, package: &super::Package) -> Result<Inputs, ResolveError> {
        Ok(match self {
            Self::Git(git) => Inputs::Git(git.resolve(package)?),
        })
    }

    /// Load a package
    ///
    /// # Errors
    /// This function will return an error if the package cannot be loaded.
    pub fn load(&self, input: &Inputs, path: &Path) -> Result<(), LoadError> {
        match input {
            Inputs::Git(input) => match self {
                Self::Git(git) => git.load(input, path),
            },
        }
    }
}

#[derive(Debug, Archive, Serialize, Deserialize, serde::Serialize, serde::Deserialize, Clone)]
#[archive_attr(derive(CheckBytes, Debug))]
pub enum Inputs {
    Git(Input),
}
