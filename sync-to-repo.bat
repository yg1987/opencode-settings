@echo off
set REPO_DIR=%~dp0
set USER_DIR=%USERPROFILE%

echo === Sync to Repo ===
echo.

rem 1. Sync config (exclude opencode.jsonc to avoid leaking API Key)
if exist "%USER_DIR%\.config\opencode" goto sync_config
echo [1/4] Skipping config
goto skill_2

:sync_config
echo [1/4] Syncing config...
if not exist "%REPO_DIR%config\opencode" mkdir "%REPO_DIR%config\opencode"
robocopy "%USER_DIR%\.config\opencode" "%REPO_DIR%config\opencode" /E /R:2 /W:2 /NFL /NDL /XF "opencode.jsonc" "opencode.jsonc.backup-*" >nul
echo   OK Config synced - opencode.jsonc excluded

:skill_2
if not exist "%USER_DIR%\.agents\skills" goto skill_3
echo [2/4] Syncing custom skills...
if not exist "%REPO_DIR%agents\skills" mkdir "%REPO_DIR%agents\skills"
xcopy "%USER_DIR%\.agents\skills" "%REPO_DIR%agents\skills" /E /I /Y >nul 2>nul
echo   OK Custom skills synced

:skill_3
if not exist "%USER_DIR%\.claude\skills" goto skill_4
echo [3/4] Syncing Claude skills...
if not exist "%REPO_DIR%claude\skills" mkdir "%REPO_DIR%claude\skills"
xcopy "%USER_DIR%\.claude\skills" "%REPO_DIR%claude\skills" /E /I /Y >nul 2>nul
echo   OK Claude skills synced

:skill_4
if not exist "%USER_DIR%\.claude\CLAUDE.md" goto end
echo [4/4] Syncing CLAUDE.md...
copy /Y "%USER_DIR%\.claude\CLAUDE.md" "%REPO_DIR%claude\CLAUDE.md" >nul
echo   OK CLAUDE.md synced

:end
echo.
echo === Next Steps ===
echo   cd /d "%REPO_DIR%"
echo   git add .
echo   git commit -m "sync: update config and skills"
echo   git push
echo.
echo === Done ===
echo.
pause
