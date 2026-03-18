# OpenClaw Backup

A cross-platform backup and restore tool for OpenClaw data.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🔒 **Complete Backup**: Backs up workspace, agents, memory, credentials, and configuration
- 🖥️ **Cross-Platform**: Supports macOS, Linux, and Windows
- 📦 **Portable**: Single compressed archive for easy migration
- 🚀 **One-Click Restore**: Double-click recovery scripts for macOS and Windows
- ⚡ **Flexible**: Choose between quick backup (excludes skills) or full backup

## Quick Start

### macOS / Linux

```bash
# Quick backup (~100MB)
./scripts/backup.sh /path/to/backup.tar.gz

# Full backup with skills (~500MB+)
INCLUDE_SKILLS=1 ./scripts/backup.sh /path/to/backup.tar.gz

# Restore
./scripts/restore.sh /path/to/backup.tar.gz
```

### Windows

```cmd
# Quick backup
scripts\backup-windows.bat D:\backup.tar.gz

# Full backup
set INCLUDE_SKILLS=1
scripts\backup-windows.bat D:\backup.tar.gz

# Restore
scripts\restore-windows.bat D:\backup.tar.gz
```

## What Gets Backed Up

| Content | Description | Optional |
|---------|-------------|----------|
| `workspace/` | Project files, memory, configurations | No |
| `agents/` | Conversation history and sessions | No |
| `memory/` | Long-term memory embeddings | No |
| `credentials/` | Encrypted credentials | No |
| `openclaw.json` | Main configuration | No |
| `skills/` | Installed skills (~1.5GB) | Yes |

## Migration Workflow

### 1. Backup on Old Machine

```bash
./scripts/backup.sh /Volumes/SSD/openclaw-backup.tar.gz
```

### 2. Restore on New Machine

**macOS:** Double-click `恢复OpenClaw.command`

**Windows:** Double-click `恢复OpenClaw-Windows.bat`

Or use command line:

```bash
./scripts/restore.sh /Volumes/SSD/openclaw-backup.tar.gz
```

## Requirements

- **macOS/Linux**: Bash, tar
- **Windows**: Windows 10 build 17063+ (for tar support), Node.js/npm

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
