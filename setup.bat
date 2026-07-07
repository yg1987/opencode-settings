@echo off
set REPO_DIR=%~dp0
set USER_DIR=%USERPROFILE%

echo === OpenCode Setup ===
echo.

rem 1. Restore config
if not exist "%REPO_DIR%config\opencode" goto cfg_skip
echo [1/4] Restoring config to %USER_DIR%\.config\opencode
if not exist "%USER_DIR%\.config\opencode" mkdir "%USER_DIR%\.config\opencode"
xcopy "%REPO_DIR%config\opencode" "%USER_DIR%\.config\opencode" /E /I /Y >nul 2>nul
echo   OK Config restored
goto sk_1

:cfg_skip
echo [1/4] Skipping config - config\opencode not found

:sk_1
if not exist "%REPO_DIR%agents\skills" goto sk_2
echo [2/4] Restoring custom skills to %USER_DIR%\.agents\skills
if not exist "%USER_DIR%\.agents\skills" mkdir "%USER_DIR%\.agents\skills"
xcopy "%REPO_DIR%agents\skills" "%USER_DIR%\.agents\skills" /E /I /Y >nul 2>nul
echo   OK Custom skills restored
goto sk_3

:sk_2
echo [2/4] Skipping custom skills - agents\skills not found

:sk_3
if not exist "%REPO_DIR%claude\skills" goto sk_4
echo [3/4] Restoring Claude skills to %USER_DIR%\.claude\skills
if not exist "%USER_DIR%\.claude\skills" mkdir "%USER_DIR%\.claude\skills"
xcopy "%REPO_DIR%claude\skills" "%USER_DIR%\.claude\skills" /E /I /Y >nul 2>nul
echo   OK Claude skills restored
goto sk_5

:sk_4
echo [3/4] Skipping Claude skills - claude\skills not found

:sk_5
if not exist "%REPO_DIR%claude\CLAUDE.md" goto api_key
echo [4/4] Restoring CLAUDE.md to %USER_DIR%\.claude\CLAUDE.md
if not exist "%USER_DIR%\.claude" mkdir "%USER_DIR%\.claude"
copy /Y "%REPO_DIR%claude\CLAUDE.md" "%USER_DIR%\.claude\CLAUDE.md" >nul
echo   OK CLAUDE.md restored
goto api_key

:api_key
if exist "%USER_DIR%\.config\opencode\opencode.jsonc" goto steps
echo.
echo NOTE: opencode.jsonc (with API Key) is not in the repo.
echo Template is at %REPO_DIR%opencode.jsonc.example
echo To set it up:
echo   copy "%REPO_DIR%opencode.jsonc.example" "%USER_DIR%\.config\opencode\opencode.jsonc"
echo   Then edit %USER_DIR%\.config\opencode\opencode.jsonc and fill in your API Key

:steps
echo.
echo === Manual Steps ===
echo.
echo 1. Install OpenCode if not already installed
echo 2. Install plugins:
echo    opencode plugin add oh-my-openagent@latest
echo    opencode plugin add superpowers
echo 3. Configure API Key (e.g. ZhiPu GLM)
echo.
echo === Done ===
echo.
pause
