@echo off
chcp 65001 >nul
:: OpenClaw Restore Script for Windows
:: Usage: restore-windows.bat <backup-file>

set "BACKUP_FILE=%~1"

if not defined BACKUP_FILE (
    echo ❌ 用法: %0 ^<备份文件路径^>
    echo    例如: %0 C:\Users\YourName\openclaw-backup-20250318.tar.gz
    exit /b 1
)

if not exist "%BACKUP_FILE%" (
    echo ❌ 错误: 找不到备份文件: %BACKUP_FILE%
    exit /b 1
)

echo 📦 OpenClaw 恢复工具
echo    备份文件: %BACKUP_FILE%
echo.

:: Check OpenClaw installation
where openclaw >nul 2>nul
if %errorlevel% neq 0 (
    echo ⚠️  未检测到 OpenClaw 安装
    echo.
    
    where npm >nul 2>nul
    if %errorlevel% neq 0 (
        echo ❌ 错误: 未检测到 npm
        echo    请先安装 Node.js: https://nodejs.org/
        exit /b 1
    )
    
    echo 正在安装 OpenClaw...
    call npm install -g openclaw@latest
    
    if %errorlevel% neq 0 (
        echo ❌ OpenClaw 安装失败
        exit /b 1
    )
    
    echo ✅ OpenClaw 安装完成
    echo.
)

:: Backup existing data
if exist "%USERPROFILE%\.openclaw" (
    echo ⚠️  检测到现有 OpenClaw 数据
    echo    位置: %USERPROFILE%\.openclaw
    echo.
    set /p "CONFIRM=是否覆盖? 现有数据将被备份 (y/N) "
    if /i not "!CONFIRM!"=="y" (
        echo ❌ 已取消
        exit /b 1
    )
    
    for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
    for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
    set "BAK_DIR=%USERPROFILE%\.openclaw.bak.%mydate%_%mytime%"
    echo    移动现有数据到: %BAK_DIR%
    move "%USERPROFILE%\.openclaw" "%BAK_DIR%"
    echo ✅ 旧数据已备份
    echo.
)

:: Restore
echo 🔄 正在恢复数据...
tar -xzf "%BACKUP_FILE%" -C %USERPROFILE%

if %errorlevel% neq 0 (
    echo ❌ 恢复失败
    exit /b 1
)

echo ✅ 数据恢复完成!
echo.

:: Start Gateway
echo 🚀 正在启动 OpenClaw Gateway...
start /b openclaw gateway start

echo.
echo 🎉 OpenClaw 恢复完成!
echo.
echo 📋 接下来:
echo    • 访问控制面板: http://localhost:18788
echo    • 检查状态: openclaw status
echo.
