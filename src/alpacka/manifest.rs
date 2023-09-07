use bytecheck::CheckBytes;
use rkyv::{to_bytes, Archive, Deserialize as RkyvDeserialize, Infallible};
use serde::{Deserialize, Serialize};
use std::{
    collections::BTreeMap,
    fs::File,
    io::{self, BufWriter, Write},
    path::PathBuf,
};

use crate::smith::enums::Inputs;

#[derive(
    Archive,
    rkyv::Serialize,
    rkyv::Deserialize,
    Debug,
    PartialEq,
    Eq,
    PartialOrd,
    Ord,
    Clone,
    Copy,
    Serialize,
    Deserialize,
)]
#[archive_attr(derive(CheckBytes, Eq, PartialEq, PartialOrd, Ord))]
/// A hash of the config file
///
/// The first value is the hash of the config file
/// The second value is the generation number
pub struct GenerationHash(pub u64, pub u64);

/// A file which contains a list of all the generations
/// The key is the config hash and the generation number
/// The value is the path to the generation
#[derive(Archive, rkyv::Serialize, rkyv::Deserialize, Debug)]
#[archive_attr(derive(CheckBytes))]
pub struct GenerationsFile(pub BTreeMap<GenerationHash, Manifest>);

#[derive(serde::Serialize, serde::Deserialize)]
pub struct JsonGenerationsFile(pub BTreeMap<String, Json>);

impl GenerationsFile {
    /// Create a new generations file
    #[must_use]
    pub const fn new() -> Self {
        Self(BTreeMap::new())
    }

    /// Save the generations file to a file
    ///
    /// # Errors
    /// This function will return an error if the file can't be created, or if the generations can't be serialized
    pub fn save_to_file(&self, generation_path: &PathBuf) -> Result<(), std::io::Error> {
        let file = File::create(generation_path)?;

        let bytes =
            to_bytes::<_, 1024>(self).map_err(|e| io::Error::new(std::io::ErrorKind::Other, e))?;

        let mut writer = BufWriter::new(file);

        writer
            .write_all(&bytes)
            .map_err(|e| io::Error::new(io::ErrorKind::Other, e))?;
        Ok(())
    }

    /// Add a new generation to the generations file
    ///
    /// returns the [`GenerationHash`] of the new generation
    pub fn add_to_generations(&mut self, config_hash: u64, manifest: Manifest) -> GenerationHash {
        let generation_number = self.get_next_generation_number(config_hash);
        let hash = GenerationHash(config_hash, generation_number);

        self.0.insert(hash, manifest);

        hash
    }

    /// Get the latest manifest for a config hash
    /// returns [`Option::None`] if there is no generation associated with that config hash
    ///
    /// Else returns the latest [Manifest] for that config hash
    #[must_use]
    pub fn get_latest_manifest(&self, config_hash: u64) -> Option<&Manifest> {
        self.0
            .iter()
            .find_map(|(GenerationHash(hash, _), manifest)| {
                if *hash == config_hash {
                    Some(manifest)
                } else {
                    None
                }
            })
    }

    /// Get the latest generation number for a config hash
    ///
    /// returns [`Option::None`] if there is no generation associated with that config hash
    /// else returns the latest generation number for that config hash
    #[must_use]
    pub fn get_latest_generation_number(&self, config_hash: u64) -> Option<u64> {
        self.0
            .keys()
            .filter(|GenerationHash(hash, _)| *hash == config_hash)
            .max_by_key(|GenerationHash(_, generation)| generation)
            .map(|GenerationHash(_, generation)| generation)
            .copied()
    }

    /// Get the next generation number for a config hash
    /// returns 1 if there is no manifest for that config hash
    #[must_use]
    pub fn get_next_generation_number(&self, config_hash: u64) -> u64 {
        self.get_latest_generation_number(config_hash).unwrap_or(0) + 1
    }
}

impl Default for GenerationsFile {
    fn default() -> Self {
        Self::new()
    }
}

/// Get the latest manifest for a config hash
/// returns [`Option::None`] if the config doesn't have any associated generations
/// else, returns the latest [`Manifest`] as a an [`ArchivedManifest`] for that config hash
#[must_use]
pub fn get_latest(
    generation_file: &ArchivedGenerationsFile,
    config_hash: u64,
) -> Option<&ArchivedManifest> {
    generation_file
        .0
        .iter()
        .find_map(|(ArchivedGenerationHash(hash, _), manifest)| {
            if *hash == config_hash {
                Some(manifest)
            } else {
                None
            }
        })
}

/// Get the latest generation number for a config hash
/// returns [`Option::None`] if the config doesn't have any associated generations
///
/// else, returns the latest generation number for that config hash
#[must_use]
pub fn get_latest_generation_number(
    generation_file: &ArchivedGenerationsFile,
    config_hash: u64,
) -> Option<u64> {
    generation_file
        .0
        .keys()
        .filter(|ArchivedGenerationHash(hash, _)| *hash == config_hash)
        .max_by_key(|ArchivedGenerationHash(_, generation)| generation)
        .map(|ArchivedGenerationHash(_, generation)| generation)
        .copied()
}

/// Get the next generation number for a config hash
/// returns 1 if the config hash doesn't have any associated generations
#[must_use]
pub fn get_next_generation_number(
    generation_file: &ArchivedGenerationsFile,
    config_hash: u64,
) -> u64 {
    get_latest_generation_number(generation_file, config_hash).unwrap_or(0) + 1
}

/// Add a new generation to the generations file
///
/// returns a deserialized [`GenerationFile`] with the new generation added
///
/// # Panics
/// Cannot panic, as the only error that can occur is [`Infallible`]
pub fn add_to_generations(
    generation_file: &ArchivedGenerationsFile,
    config_hash: u64,
    manifest: Manifest,
) -> GenerationsFile {
    let mut generations: GenerationsFile = generation_file.deserialize(&mut Infallible).unwrap();

    generations.add_to_generations(config_hash, manifest);

    generations
}

/// An alpacka manifest
///
/// This is the file that is generated by alpacka and is used to install plugins
/// Contains a list of plugins and the neovim version it was built for
#[derive(Debug, rkyv::Archive, rkyv::Serialize, rkyv::Deserialize)]
#[archive_attr(derive(CheckBytes))]
pub struct Manifest {
    /// The neovim version this manifest was built for
    pub neovim_version: String,
    pub plugins: Vec<Plugin>,
}

#[derive(Debug, serde::Serialize, serde::Deserialize)]
pub struct Json {
    /// The neovim version this manifest was built for
    pub neovim_version: String,
    pub plugins: Vec<Plugin>,
    // These need to be strings because u64 cannot fit into JSON
    pub hash: String,
    pub generation: String,
}

impl Manifest {
    #[must_use]
    pub fn new(neovim_version: String, plugins: Vec<Plugin>) -> Self {
        Self {
            neovim_version,
            plugins,
        }
    }

    /// Save the manifest to a file
    ///
    /// # Errors
    /// This function will return an error if the file can't be created, or if the manifest can't be serialized
    #[tracing::instrument]
    pub fn save_to_file(&self, path: &PathBuf) -> Result<(), std::io::Error> {
        let file = std::fs::File::create(path)?;
        let bytes = to_bytes::<_, 1024>(self)
            .map_err(|e| std::io::Error::new(std::io::ErrorKind::Other, e))?;
        let mut writer = std::io::BufWriter::new(file);

        writer
            .write_all(&bytes)
            .map_err(|e| std::io::Error::new(std::io::ErrorKind::Other, e))?;

        Ok(())
    }
}

/// A plugin, as defined in the manifest
#[derive(Debug, rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Serialize, Deserialize)]
#[archive_attr(derive(CheckBytes))]
pub struct Plugin {
    /// The plugin's name
    pub name: String,
    /// The plugin's unresolved name
    /// This is the name that is used in the config file
    /// This is used to resolve dependencies
    pub unresolved_name: String,
    /// Rename the plugin to this name when loading
    pub rename: Option<String>,
    /// If the plugin is optional
    pub optional: bool,
    /// The plugin's dependencies, as a list of plugin names. These are the non-resolved names
    pub dependencies: Vec<String>,
    /// the name of the loader this plugin is loaded by
    pub smith: String,
    /// A command which is run in the plugin's directory after loading
    pub build: String,
    /// The data which is used for the loader
    pub loader_data: Inputs,
}

#[cfg(test)]
mod tests {
    use super::*;
    use rkyv::to_bytes;

    #[test]
    fn test_generation_hash_serialize_deserialize() {
        let generation = GenerationHash(123_125_124, 32);

        let bytes = to_bytes::<_, 1024>(&generation).unwrap();
        let deserialized = rkyv::from_bytes::<GenerationHash>(&bytes).unwrap();
        assert_eq!(generation, deserialized);
    }

    #[test]
    fn test_generations_file_serialize_deserialize() {
        let mut generations_file = GenerationsFile::new();
        let manifest = Manifest {
            neovim_version: "0.5.0".to_string(),
            plugins: vec![],
        };

        let hash = generations_file.add_to_generations(1, manifest);

        let bytes = to_bytes::<_, 1024>(&generations_file).unwrap();
        let deserialized = rkyv::from_bytes::<GenerationsFile>(&bytes).unwrap();

        let generations_file_manifest = generations_file.0.get(&hash).unwrap();
        let deserialized_manifest = deserialized.0.get(&hash).unwrap();

        assert_eq!(
            generations_file_manifest.neovim_version,
            deserialized_manifest.neovim_version
        );
    }

    #[test]
    fn test_get_next_generation_number() {
        let mut generations_file = GenerationsFile::new();
        let manifest = Manifest {
            neovim_version: "0.5.0".to_string(),
            plugins: vec![],
        };

        assert_eq!(generations_file.get_next_generation_number(0), 1);

        generations_file.add_to_generations(0, manifest);

        assert_eq!(generations_file.get_next_generation_number(0), 2);
    }
}
