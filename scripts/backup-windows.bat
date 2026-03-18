@echo off
chcp 65001 >nul
:: OpenClaw Backup Script for Windows
:: Usage: backup-windows.bat [output-path]

setlocal enabledelayedexpansion

set "BACKUP_FILE=%~1"
if not defined BACKUP_FILE (
    set "BACKUP_FILE=%USERPROFILE%\Desktop\openclaw-backup-%date:~0,4%%date:~5,2%%date:~8,2%-%time:~0,2%%time:~3,2%%time:~6,2%.tar.gz"
)

set "OPENCLAW_DIR=%USERPROFILE%\.openclaw"

if not exist "%OPENCLAW_DIR%" (
    echo ❌ 错误: 找不到 OpenClaw 数据目录: %OPENCLAW_DIR%
    exit /b 1
)

echo 📦 正在备份 OpenClaw 数据...
echo    源目录: %OPENCLAW_DIR%
echo    目标: %BACKUP_FILE%
echo.

:: Create temp list of files to backup
cd /d "%USERPROFILE%"
(
    echo .openclaw\workspace
    echo .openclaw\agents
    echo .openclaw\memory
    echo .openclaw\credentials
    echo .openclaw\cron
    echo .openclaw\identity
    echo .openclaw\extensions
    echo .openclaw\devices
    echo .openclaw\openclaw.json
    echo .openclaw\openclaw.json.bak
    echo .openclaw\openclaw.json.bak.1
    echo .openclaw\openclaw.json.bak.2
    echo .openclaw\openclaw.json.bak.3
    echo .openclaw\exec-approvals.json
    echo .openclaw\feishu
    echo .openclaw\canvas
    echo .openclaw\media
    echo .openclaw\completions
    echo .openclaw\delivery-queue
    echo .openclaw\subagents
    echo .openclaw\update-check.json
) > %TEMP%\openclaw-backup-list.txt

:: Include skills if requested
if "%INCLUDE_SKILLS%"=="1" (
    echo .openclaw\skills >> %TEMP%\openclaw-backup-list.txt
    echo 📦 包含 skills 目录（完整备份模式）
)

echo 🔄 开始压缩备份...
tar -czf "%BACKUP_FILE%" -T %TEMP%\openclaw-backup-list.txt

del %TEMP%\openclaw-backup-list.txt

echo.
echo ✅ 备份完成!
echo    文件: %BACKUP_FILE%
for %%I in ("%BACKUP_FILE%") do echo    大小: %%~zI bytes
echo.
echo 💡 恢复命令 (在新机器上运行):
echo    restore-windows.bat "%BACKUP_FILE%"
