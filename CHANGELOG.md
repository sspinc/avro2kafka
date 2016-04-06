# Changelog

All notable changes to this project are documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 0.4.1 (2016-04-06)
Bump Logr version to 0.2.0

### Changed
* Logr version to 0.2.0

## 0.4.0 (2015-11-18)
Structured logging

### Changed
* Log in JSON format using Logr (https://github.com/sspinc/logr)

### Added
* New started_publishing and finished_publishing events
* New lines_processed metric

## 0.3.0 (2015-08-27)
Improved error reporting

### Changed
 * Return exit code 1 if there was an unexpected error
 * Return exit code 2 if there are parameters missing
 * Log error messages to STDERR

## 0.2.0 (2015-06-12)
Support for adding extra data to the message payload

### Added

  * --data option to add extra data to to the message payload

### Changed

  * --broker option renamed to --broker-list and accepts a comma-separated list of brokers

## 0.1.0 (2015-06-09)
Initial release

### Added
 * CLI (`avro2kafa`) to Avro files to Kafka (#1)
 * Gem packaging
