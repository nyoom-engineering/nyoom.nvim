use crate::{
    package::{Config as ConfigPackage, Package, WithSmith},
    smith::enums::Loaders,
};
use error_stack::{Context, Result};
use serde::{Deserialize, Serialize};
use std::{collections::BTreeMap, fmt::Display};

#[derive(Debug, Deserialize, Serialize, Hash, PartialEq, Eq, PartialOrd, Ord)]
/// The alpacka config format
pub struct Config {
    /// All the packages
    pub packages: BTreeMap<String, ConfigPackage>,
}

#[derive(Debug)]
/// An error that can occur when creating a list of packages
pub enum CreatePackageListError {
    /// No loader found for a package
    NoLoaderFound(String),
}

impl Display for CreatePackageListError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::NoLoaderFound(name) => {
                write!(f, "No loader found for package {name}")
            }
        }
    }
}

impl Context for CreatePackageListError {}

impl Config {
    /// Create a list of packages with their corresponding smith
    ///
    /// # Errors
    /// This function will return an error if no loader can be found for a package
    #[tracing::instrument]
    pub fn create_package_list(
        &self,
        smiths: &[Loaders],
    ) -> Result<Vec<WithSmith>, CreatePackageListError> {
        let mut packages = Vec::with_capacity(self.packages.len());

        for (name, config_package) in &self.packages {
            let package = Package {
                name,
                config_package,
            };

            let smith_idx = smiths
                .iter()
                .position(|smith| smith.get_package_name(package.name).is_some())
                .ok_or_else(|| CreatePackageListError::NoLoaderFound(name.clone()))?;

            packages.push(WithSmith {
                smith: smiths[smith_idx].name().to_string(),
                package,
            });
        }

        Ok(packages)
    }
}
