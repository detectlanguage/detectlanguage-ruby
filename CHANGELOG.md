# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [2.0.0]

### Added
- `detect_batch` method for batch detections

### Changed
- Switched to v3 API which uses updated language detection model
- ⚠️ `simple_detect` method renamed to `detect_code`
- ⚠️ `detect` method result fields are `language` and `score`
- ⚠️ `detect` method no longer accept arrays - use `detect_batch` instead
- ⚠️ `user_status` method renamed to `account_status`
- ⚠️ Proxy URL configured using `config.proxy`
- HTTPS is used by default. Removed secure_mode configuration
- Client connection is reused. If you change configuration after client is initialized, you need to reset client using `DetectLanguage.client = nil`.

### Removed
- Ruby 1.x support