---
name: openclaw-backup
description: Cross-platform backup and restore tool for OpenClaw data. Supports macOS, Linux, and Windows with one-click restore scripts.
---

# OpenClaw Backup Skill

Backup and restore all OpenClaw data for migration or safekeeping.

## What Gets Backed Up

| Content | Description |
|---------|-------------|
| `workspace/` | Project files, memory files, configurations |
| `agents/` | Conversation history and session data |
| `memory/` | Long-term memory embeddings |
| `credentials/` | Encrypted credentials |
| `openclaw.json` | Main configuration file |
| `skills/` | Installed skills (optional, large) |

## Quick Start

### macOS / Linux

**Backup:**
```bash
# Quick backup (excludes skills, ~100MB)
./scripts/backup.sh /Volumes/YourSSD/backup.tar.gz

# Full backup (includes skills, ~500MB+)
INCLUDE_SKILLS=1 ./scripts/backup.sh /Volumes/YourSSD/backup.tar.gz
```

**Restore:**
```bash
./scripts/restore.sh /Volumes/YourSSD/backup.tar.gz
```

### Windows

**Backup:**
```cmd
# Quick backup
scripts\backup-windows.bat D:\backup.tar.gz

# Full backup with skills
set INCLUDE_SKILLS=1
scripts\backup-windows.bat D:\backup.tar.gz
```

**Restore:**
```cmd
scripts\restore-windows.bat D:\backup.tar.gz
```

## Scripts

### backup.sh

Creates a compressed archive of OpenClaw data.

**Environment Variables:**
- `INCLUDE_SKILLS=1` - Include skills directory (adds ~1.5GB)

**Usage:**
```bash
./scripts/backup.sh [output-path]
```

**Examples:**
```bash
# Backup to default location (Desktop with timestamp)
./scripts/backup.sh

# Backup to specific location
./scripts/backup.sh /Volumes/SSD/openclaw-backup.tar.gz

# Full backup with skills
INCLUDE_SKILLS=1 ./scripts/backup.sh /Volumes/SSD/openclaw-full.tar.gz
```

### restore.sh (macOS/Linux)

Restores OpenClaw data from a backup archive.

**Features:**
- Automatically backs up existing data before overwriting
- Installs OpenClaw if not present
- Optionally syncs skills after restore

**Usage:**
```bash
./scripts/restore.sh <backup-file>
```

**Examples:**
```bash
./scripts/restore.sh /Volumes/SSD/openclaw-backup-20250318.tar.gz
```

### backup-windows.bat / restore-windows.bat (Windows)

Windows batch scripts for backup and restore.

**Requirements:**
- Windows 10 version 17063 or later (for built-in tar support)
- Node.js and npm installed

**Usage:**
```cmd
# Backup
scripts\backup-windows.bat D:\openclaw-backup.tar.gz

# Restore
scripts\restore-windows.bat D:\openclaw-backup.tar.gz
```

## Migration Workflow

### Old Machine

```bash
# 1. Run backup
./scripts/backup.sh /Volumes/SSD/openclaw-backup.tar.gz

# 2. Eject drive
diskutil eject /Volumes/SSD
```

### New Machine

```bash
# 1. Install OpenClaw (if needed)
npm install -g openclaw@latest

# 2. Restore data
./scripts/restore.sh /Volumes/SSD/openclaw-backup.tar.gz

# 3. Start Gateway
openclaw gateway start
```

## Notes

- Backup files are gzip-compressed tar archives
- Existing data is preserved with `.bak.<timestamp>` suffix before restore
- Skills can be re-downloaded via `clawhub sync` if excluded from backup
- Configuration files may need adjustment if paths differ between machines
