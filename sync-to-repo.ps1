<#
.SYNOPSIS
  将当前系统的最新配置和技能同步到仓库
.DESCRIPTION
  把真实位置的文件复制到仓库，然后你可以 git add → git commit → git push。
  建议在安装新技能或修改配置后运行。
#>

$REPO_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$USER_DIR = $env:USERPROFILE

Write-Host "=== 同步到仓库 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 同步配置（排除 opencode.jsonc 避免误传 API Key）
$CONFIG_SRC = Join-Path $USER_DIR ".config\opencode"
$CONFIG_DST = Join-Path $REPO_DIR "config\opencode"
if (Test-Path $CONFIG_SRC) {
    Write-Host "[1/4] 同步配置..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $CONFIG_DST -Force | Out-Null
    robocopy $CONFIG_SRC $CONFIG_DST /E /R:2 /W:2 /NFL /NDL /XF "opencode.jsonc" "opencode.jsonc.backup-*"
    Write-Host "  ✓ 配置已同步（opencode.jsonc 已跳过 - 含 API Key）"
}
else {
    Write-Host "[1/4] 跳过配置" -ForegroundColor DarkYellow
}

# 2. 同步自定义技能
$SKILLS_SRC = Join-Path $USER_DIR ".agents\skills"
$SKILLS_DST = Join-Path $REPO_DIR "agents\skills"
if (Test-Path $SKILLS_SRC) {
    Write-Host "[2/4] 同步自定义技能..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $SKILLS_DST -Force | Out-Null
    robocopy $SKILLS_SRC $SKILLS_DST /E /R:2 /W:2 /NFL /NDL
    Write-Host "  ✓ 自定义技能已同步"
}
else {
    Write-Host "[2/4] 跳过自定义技能" -ForegroundColor DarkYellow
}

# 3. 同步 Claude 技能
$CLAUDESKILLS_SRC = Join-Path $USER_DIR ".claude\skills"
$CLAUDESKILLS_DST = Join-Path $REPO_DIR "claude\skills"
if (Test-Path $CLAUDESKILLS_SRC) {
    Write-Host "[3/4] 同步 Claude 技能..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $CLAUDESKILLS_DST -Force | Out-Null
    robocopy $CLAUDESKILLS_SRC $CLAUDESKILLS_DST /E /R:2 /W:2 /NFL /NDL
    Write-Host "  ✓ Claude 技能已同步"
}
else {
    Write-Host "[3/4] 跳过 Claude 技能" -ForegroundColor DarkYellow
}

# 4. 同步 CLAUDE.md
$CLAUDE_FILE_SRC = Join-Path $USER_DIR ".claude\CLAUDE.md"
$CLAUDE_FILE_DST = Join-Path $REPO_DIR "claude\CLAUDE.md"
if (Test-Path $CLAUDE_FILE_SRC) {
    Write-Host "[4/4] 同步 CLAUDE.md..." -ForegroundColor Yellow
    Copy-Item $CLAUDE_FILE_SRC $CLAUDE_FILE_DST -Force
    Write-Host "  ✓ CLAUDE.md 已同步"
}
else {
    Write-Host "[4/4] 跳过 CLAUDE.md" -ForegroundColor DarkYellow
}

Write-Host ""
Write-Host "=== 下一步 ===" -ForegroundColor Cyan
Write-Host ('
  cd ' + $REPO_DIR + '
  git add .
  git commit -m "sync: 更新配置和技能"
  git push
')
Write-Host "=== 完成 ===" -ForegroundColor Green
