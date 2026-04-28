# Changelog

All notable changes to the HermesKnowledge automation system.

## [v0.1.1] - 2026-04-28

### Changed
- 切换为每分钟静默同步（无 git 噪音）

### Added
- `hermes-push-auto`: Silent auto-sync for cron (no output unless changes exist)
- `hermes-poll`: Installs auto-sync to crontab

## [v0.1.0] - 2026-04-28

### Added
- `hermes-push`: Manual immediate vault sync
- `hermes-watch`: Real-time file monitoring (requires inotify-tools)
- `hermes-release`: SemVer release workflow
- `CHANGELOG.md`: Version tracking
- `.system/README.md`: System documentation
- `.gitignore`: System files ignored
