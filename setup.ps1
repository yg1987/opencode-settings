<#
.SYNOPSIS
  在新电脑上恢复 OpenCode 配置和技能
.DESCRIPTION
  将本仓库中的配置和技能文件复制到系统的正确位置。
  执行前请确保已运行: git clone https://github.com/yg1987/opencode-settings.git
#>

$REPO_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$USER_DIR = $env:USERPROFILE

Write-Host "=== OpenCode 环境恢复 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 恢复 OpenCode 配置
$CONFIG_SRC = Join-Path $REPO_DIR "config\opencode"
$CONFIG_DST = Join-Path $USER_DIR ".config\opencode"
if (Test-Path $CONFIG_SRC) {
    Write-Host "[1/4] 恢复配置到 $CONFIG_DST" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $CONFIG_DST -Force | Out-Null
    robocopy $CONFIG_SRC $CONFIG_DST /E /R:2 /W:2 /NFL /NDL
    Write-Host "  ✓ 配置已恢复"
}
else {
    Write-Host "[1/4] 跳过配置（未找到 config\opencode）" -ForegroundColor DarkYellow
}

# 2. 恢复自定义技能
$SKILLS_SRC = Join-Path $REPO_DIR "agents\skills"
$SKILLS_DST = Join-Path $USER_DIR ".agents\skills"
if (Test-Path $SKILLS_SRC) {
    Write-Host "[2/4] 恢复自定义技能到 $SKILLS_DST" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $SKILLS_DST -Force | Out-Null
    robocopy $SKILLS_SRC $SKILLS_DST /E /R:2 /W:2 /NFL /NDL
    Write-Host "  ✓ 自定义技能已恢复"
}
else {
    Write-Host "[2/4] 跳过自定义技能（未找到 agents\skills）" -ForegroundColor DarkYellow
}

# 3. 恢复 Claude/gstack 技能
$CLAUDESKILLS_SRC = Join-Path $REPO_DIR "claude\skills"
$CLAUDESKILLS_DST = Join-Path $USER_DIR ".claude\skills"
if (Test-Path $CLAUDESKILLS_SRC) {
    Write-Host "[3/4] 恢复 Claude 技能到 $CLAUDESKILLS_DST" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $CLAUDESKILLS_DST -Force | Out-Null
    robocopy $CLAUDESKILLS_SRC $CLAUDESKILLS_DST /E /R:2 /W:2 /NFL /NDL
    Write-Host "  ✓ Claude 技能已恢复"
}
else {
    Write-Host "[3/4] 跳过 Claude 技能（未找到 claude\skills）" -ForegroundColor DarkYellow
}

# 4. 恢复 CLAUDE.md
$CLAUDE_FILE_SRC = Join-Path $REPO_DIR "claude\CLAUDE.md"
$CLAUDE_FILE_DST = Join-Path $USER_DIR ".claude\CLAUDE.md"
if (Test-Path $CLAUDE_FILE_SRC) {
    Write-Host "[4/4] 恢复全局指令到 $CLAUDE_FILE_DST" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path (Split-Path $CLAUDE_FILE_DST -Parent) -Force | Out-Null
    Copy-Item $CLAUDE_FILE_SRC $CLAUDE_FILE_DST -Force
    Write-Host "  ✓ CLAUDE.md 已恢复"
}
else {
    Write-Host "[4/4] 跳过 CLAUDE.md（未找到）" -ForegroundColor DarkYellow
}

# 5. 提示设置 API Key
$EXAMPLE = Join-Path $REPO_DIR "opencode.jsonc.example"
$CONFIG_FILE = Join-Path $USER_DIR ".config\opencode\opencode.jsonc"
if (-not (Test-Path $CONFIG_FILE)) {
    Write-Host ""
    Write-Host "注意: opencode.jsonc（含 API Key）未随仓库上传。" -ForegroundColor Magenta
    Write-Host "已将模板文件放在仓库根目录 opencode.jsonc.example。" -ForegroundColor Magenta
    Write-Host "请手动复制并填入 API Key:" -ForegroundColor Magenta
    Write-Host "  copy '$EXAMPLE' '$CONFIG_FILE'" -ForegroundColor White
    Write-Host "  (然后编辑 $CONFIG_FILE，替换 API Key)" -ForegroundColor White
}

# 6. 提示安装插件
Write-Host ""
Write-Host "=== 需要手动执行的后续步骤 ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 安装 OpenCode 主程序（如果还没装）"
Write-Host "2. 安装插件：" -ForegroundColor Yellow
Write-Host "   opencode plugin add oh-my-openagent@latest"
Write-Host "   opencode plugin add superpowers"
Write-Host "3. 配置 API Key（如智谱 GLM 等）"
Write-Host ""
Write-Host "=== 全部完成 ===" -ForegroundColor Green
