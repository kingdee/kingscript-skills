# Kingscript Code Generator

`kingscript-code-generator` 是一个面向 Kingscript 二开场景的 skill 包，用于帮助 AI 助手生成、解释、审查和修改 Kingscript 代码，并结合本地参考资料完成更稳妥的实现。

这个目录是 `kingscript-skills` 仓库中的一个具体 skill 子目录，不代表整个 skills 仓库本身。

## 目录结构

```text
kingscript-code-generator/
├─ references/
│  ├─ examples/      # 代码示例
│  ├─ templates/     # 插件模板
│  ├─ sdk/           # SDK 声明、索引、开放能力映射
│  └─ language/      # Kingscript 语法约束
├─ codex/            # Codex 入口内容
├─ qoder/            # Qoder 入口内容
├─ claude-code/      # Claude Code 入口内容
├─ install.sh        # Linux / macOS 安装脚本
└─ install.ps1       # Windows 安装脚本
```

## 设计原则

- `references/` 只放平台无关的共享内容。
- 平台差异只放在 `codex/`、`qoder/`、`claude-code/`。
- 所有文档链接都使用仓库内相对路径，不写死本地绝对目录。
- 当前 skill 聚焦“快速生成、解释与审查 Kingscript 代码”。

## 安装

安装后的 skill 目录统一命名为 `kingscript-code-generator`。

### Windows

```powershell
.\install.ps1 -Platform codex
.\install.ps1 -Platform qoder
.\install.ps1 -Platform claude
```

自定义目标目录：

```powershell
.\install.ps1 -Platform codex -TargetDir 'D:\skills\kingscript-code-generator'
```

### Linux / macOS

```bash
bash install.sh codex
bash install.sh qoder
bash install.sh claude
```

自定义目标目录：

```bash
bash install.sh claude /custom/path/kingscript-code-generator
```

### 默认安装位置

| 平台 | 默认安装目录 | 根入口 |
|---|---|---|
| Codex | `~/.agents/skills/kingscript-code-generator/` | `SKILL.md` |
| Qoder | `~/.qoder/skills/kingscript-code-generator/` | `SKILL.md` |
| Claude Code | `~/.claude/skills/kingscript-code-generator/` | `SKILL.md` |

## 安装后的打包结果

### Codex

```text
kingscript-code-generator/
├─ SKILL.md
├─ AGENTS.md
├─ agents/
└─ references/
```

### Qoder

```text
kingscript-code-generator/
├─ SKILL.md
└─ references/
```

### Claude Code

```text
kingscript-code-generator/
├─ SKILL.md
├─ CLAUDE.md
├─ commands/
└─ references/
```

## 共享内容说明

### `references/examples/`

放“这段代码怎么写”的内容，适合查找事件示例、场景代码、完整插件示例。

### `references/templates/`

放“一个插件怎么起”的内容，适合查找插件模板、脚手架、占位代码。

### `references/sdk/`

放 SDK 说明、类与方法索引、开放能力映射、结构化清单。

默认仓库保留可直接阅读的索引和轻量清单。体积较大的 `references/sdk/manifests/methods.json` 不建议默认提交到公共仓库。

### `references/language/`

放 Kingscript 语言层面的语法、限制、命名和关键字说明。

## 维护约定

1. 新增示例放到 `references/examples/`
2. 新增插件模板放到 `references/templates/`
3. 新增 SDK 声明或索引放到 `references/sdk/`
4. 新增语法约束放到 `references/language/`
5. 平台适配只改对应平台目录，不把平台差异写进 `references/`

## 许可

MIT
