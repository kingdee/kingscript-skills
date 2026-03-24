# Kingscript Skill

面向 `Kingscript` 二开场景的多平台 skill 源码仓库，目标是同时支持 `Codex`、`Qoder`、`Claude Code` 的安装和复用。

## 这份仓库的形态

- 当前仓库是 **统一源码结构**，不是“根目录直接可被所有平台发现”的单一安装包。
- `core/` 保存平台无关的领域知识、示例、模板和清单。
- `codex/`、`qoder/`、`claude-code/` 保存各平台入口。
- 安装脚本会按平台把对应入口文件铺到安装目录根部，再带上共享的 `core/` 内容。

## 目录结构

```text
kingscript-skill/
├─ core/                    # 核心知识库（平台无关）
│  ├─ docs/                 # 概念、边界、最佳实践、排障指南
│  ├─ examples/             # TypeScript 代码示例
│  ├─ templates/            # 生成、修改、审查模板
│  ├─ checklists/           # 安全、审查、发布检查清单
│  ├─ recipes/              # 场景化操作剧本
│  ├─ sdk/                  # SDK 声明和开放能力索引
│  ├─ plugin-templates/     # 插件模版和脚手架
│  ├─ cases/                # 完整案例和复盘
│  └─ language/kingscript/   # Kingscript 语言专项知识
├─ codex/                   # Codex 平台入口源码
├─ qoder/                   # Qoder 平台入口源码
├─ claude-code/             # Claude Code 平台入口源码
├─ install.sh               # Linux/macOS 安装脚本
└─ install.ps1              # Windows 安装脚本
```

## 平台安装

安装后的 skill 统一目录名为 `kingscript-expert`。

### Windows

```powershell
.\install.ps1 -Platform codex
.\install.ps1 -Platform qoder
.\install.ps1 -Platform claude
```

也支持覆盖目标目录：

```powershell
.\install.ps1 -Platform codex -TargetDir 'D:\skills\kingscript-expert'
```

### Linux / macOS

```bash
bash install.sh codex
bash install.sh qoder
bash install.sh claude
```

也支持覆盖目标目录：

```bash
bash install.sh claude /custom/path/kingscript-expert
```

### 默认安装位置

| 平台 | 默认安装目录 | 安装后根入口 |
|---|---|---|
| Codex | `~/.agents/skills/kingscript-expert/` | `SKILL.md` |
| Qoder | `~/.qoder/skills/kingscript-expert/` | `SKILL.md` |
| Claude Code | `~/.claude/skills/kingscript-expert/` | `SKILL.md` |

## 安装后的打包结果

### Codex

安装脚本会生成如下根目录结构：

```text
kingscript-expert/
├─ SKILL.md
├─ AGENTS.md
├─ agents/
│  └─ openai.yaml
└─ core/
```

### Qoder

安装脚本会生成如下根目录结构：

```text
kingscript-expert/
├─ SKILL.md
└─ core/
```

### Claude Code

安装脚本会生成如下根目录结构：

```text
kingscript-expert/
├─ SKILL.md
├─ CLAUDE.md
├─ commands/
└─ core/
```

## 各平台入口源码

### Codex

源码入口在 `codex/SKILL.md`，安装时会被铺到目标目录根部的 `SKILL.md`。

### Qoder

源码入口在 `qoder/SKILL.md`，安装时会被铺到目标目录根部的 `SKILL.md`。

### Claude Code

源码入口在 `claude-code/SKILL.md` 和 `claude-code/CLAUDE.md`。
安装时：

- `claude-code/SKILL.md` 会变成根部的 `SKILL.md`
- `claude-code/CLAUDE.md` 会保留为根部的 `CLAUDE.md`
- `claude-code/commands/` 会复制到根部的 `commands/`

## 核心知识库内容

### 边界约束

- `core/docs/api-boundaries.md`
- `core/docs/concepts.md`
- `core/docs/content-map.md`

### 实践指南

- `core/docs/best-practices.md`
- `core/docs/pitfalls.md`
- `core/docs/troubleshooting.md`

### 模板和清单

- `core/templates/`
- `core/checklists/`
- `core/recipes/`

### SDK 清单发布说明

- 仓库默认保留轻量 SDK 清单和可读索引，保证 clone 下来即可使用。
- 体积较大的 `core/sdk/manifests/methods.json` 不作为 GitHub 仓库默认提交内容。
- 如果需要全量方法级兜底能力，建议由维护者本地生成，或通过 GitHub Release 作为附加资产分发。

## 扩展建议

| 内容类型 | 存放位置 |
|---|---|
| Kingscript 插件模版 | `core/plugin-templates/` |
| Kingscript SDK 声明 | `core/sdk/` |
| 开发案例 | `core/cases/` |
| Kingscript 语法约束 | `core/language/kingscript/` |
| 高频示例代码 | `core/examples/` |

## 贡献约定

1. 新增示例放到 `core/examples/`
2. 新增模板放到 `core/templates/`
3. 新增案例放到 `core/cases/`
4. 平台适配只改对应平台目录，不要把平台差异写进 `core/`

## 许可证

MIT
