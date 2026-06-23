# OpenCode Settings

我的 OpenCode 配置、技能和全局指令的 Git 仓库。用于**备份**和**新电脑快速恢复**。

## 仓库结构

```
opencode-settings/
├── config/opencode/        ← OpenCode 配置（oh-my-openagent.jsonc、tui.json 等）
├── agents/skills/          ← 自定义安装的第三方技能（html-ppt、skill-creator 等）
├── claude/
│   ├── skills/             ← Claude / gstack 技能（brainstorming、xlsx 等）
│   └── CLAUDE.md           ← 全局指令
├── opencode.jsonc.example  ← 配置模板（API Key 已脱敏）
├── setup.ps1               ← 新电脑恢复脚本
├── sync-to-repo.ps1        ← 从系统同步到仓库
└── .gitignore              ← 排除 opencode.jsonc（含 API Key）
```

> **注意**: `opencode.jsonc`（主配置文件，含智谱 API Key）被 `.gitignore` 排除，不上传到 GitHub。
> 仓库根目录提供了 `opencode.jsonc.example` 作为模板，新电脑按需填写 API Key。

## 新电脑恢复

```powershell
# 1. 克隆仓库
git clone https://github.com/yg1987/opencode-settings.git

# 2. 运行恢复脚本（自动复制配置和技能到正确位置）
cd opencode-settings
.\setup.ps1

# 3. 安装 OpenCode
#    （如果还没装，去 https://opencode.ai 下载）

# 4. 安装插件
opencode plugin add oh-my-openagent@latest
opencode plugin add superpowers

# 5. 配置 API Key
#    复制模板并编辑：
copy opencode.jsonc.example "$env:USERPROFILE\.config\opencode\opencode.jsonc"
#    编辑 opencode.jsonc，填入智谱 GLM 的 API Key
```

## 日常同步（装了新技能或改了配置后）

```powershell
# 1. 把最新的系统配置和技能复制到仓库
cd D:\opencode_work\opencode-settings
.\sync-to-repo.ps1

# 2. 提交并推送
git add .
git commit -m "sync: 更新配置和技能"
git push
```

脚本会自动跳过含 API Key 的 `opencode.jsonc`，不用担心误传密钥。

## 为什么用 Git 而不是手动备份？

- **增量跟踪**: 每次改了什么一目了然
- **远程存储**: 电脑坏了不丢失，从 GitHub 恢复
- **零遗忘成本**: 想起来时跑一下 `sync-to-repo.ps1` → `git push` 即可
- **新电脑快速上线**: clone → setup → 装插件 → 配 Key，十分钟搞定

## 包含的插件

- [oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent) — 多模型管理、Sisyphus 子代理系统
- [superpowers](https://github.com/obra/superpowers) — 技能增强框架
