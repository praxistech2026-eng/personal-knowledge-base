# Changelog

All notable changes to the HermesKnowledge automation system are documented here.

## [v0.1.0] - 2026-04-28

### Added
- `hermes-push`: Manual trigger for immediate vault sync
- `hermes-release`: Release workflow with SemVer tagging
- `hermes-auto-sync.sh`: Smart sync (only commits on meaningful changes)
- `hermes-smart-sync.sh`: Improved version with file tracking
- `hermes-snapshot.sh`: Vault snapshot creation
- `archive-sessions.py`: Multi-agent session archiver (Hermes/OpenClaw/Claude Code)
- `.gitignore`: System file exclusion
- Version control policy: data (real-time) vs system (SemVer)

### Notes
- Vault data syncs to GitHub in real-time on file change
- Automation system versions are managed via SemVer tags
- Two separate sync mechanisms: manual trigger + automatic detection
