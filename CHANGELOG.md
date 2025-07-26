# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## v2.0.0

### Added
- `detect_batch` method for batch detections

### Changed
- Switched to v3 API which uses an updated language detection model
- ⚠️ `detect` method result fields are `language` and `score`
- ⚠️ Proxy URL configured using `config.proxy`
- Client connection is reused. If you change configuration after the client is initialized, you need to reset client using `DetectLanguage.client = nil`.

### Deprecated
- Calling `detect` with array argument. Use `detect_batch` instead.
- `simple_detect` - Use `detect_code` instead.
- `user_status` - Use `account_status` instead.
- `configuration` - Use `config` instead.

### Removed
- Secure mode configuration. HTTPS is always used.
- Ruby 1.x support
