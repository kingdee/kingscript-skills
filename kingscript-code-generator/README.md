# Kingscript Code Generator

`kingscript-code-generator` 是一个面向 Kingscript 二开场景的 skill 包，用于帮助 AI 助手生成、解释、审查和修改 Kingscript 代码，并结合本地参考资料完成更稳妥的实现。

这个目录是 `kingscript-skills` 仓库中的一个具体 skill 子目录，不代表整个 skills 仓库本身。

## 目录结构

```text
kingscript-code-generator/
├─ references/
│  ├─ docs/          # 专题开发指南与规则说明
│  ├─ examples/      # 代码示例
│  ├─ templates/     # 插件模板
│  ├─ sdk/           # SDK 声明、索引、开放能力映射
│  └─ language/      # Kingscript 语法约束
├─ codex/            # Codex 入口内容
├─ qoder/            # Qoder 入口内容
├─ claude-code/      # Claude Code 入口内容
├─ sdks.zip          # 可选离线 SDK / 文档资料包
├─ install.sh        # Linux / macOS 安装脚本
└─ install.ps1       # Windows 安装脚本
```

## 设计原则

- `references/` 只放平台无关的共享内容。
- 平台差异只放在 `codex/`、`qoder/`、`claude-code/`。
- 所有文档链接都使用仓库内相对路径，不写死本地绝对目录。
- 当前 skill 聚焦“快速生成、解释与审查 Kingscript 代码”。
- 新增 KWC 脚本控制器这类专题资料时，优先沉淀到 `references/docs/`。

## 安装

安装后的 skill 目录统一命名为 `kingscript-code-generator`。

### Windows

```powershell
.\install.ps1 -Platform codex
.\install.ps1 -Platform qoder
.\install.ps1 -Platform claude
```

安装脚本会在复制完成后自动校验关键入口文件和 `references/` 是否存在。

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

Shell 脚本同样会在安装结束后做一次关键文件校验。

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
├─ README.md
├─ local-paths.example.json
├─ agents/
└─ references/
```

Codex 安装后，建议先复制 `local-paths.example.json` 为 `local-paths.json`，再把本机资源路径填进去。安装脚本在覆盖安装时会保留已有的 `local-paths.json`。
如果本地还挂了最全的外部知识盘，也建议一并配置 `bos_docs_path`。

### Qoder

```text
kingscript-code-generator/
├─ SKILL.md
├─ README.md
├─ local-paths.example.json
└─ references/
```

Qoder 安装后，建议先复制 `local-paths.example.json` 为 `local-paths.json`，再把本机资源路径填进去。安装脚本在覆盖安装时会保留已有的 `local-paths.json`。
如果本地还挂了最全的外部知识盘，也建议一并配置 `bos_docs_path`。

### Claude Code

```text
kingscript-code-generator/
├─ SKILL.md
├─ CLAUDE.md
├─ README.md
├─ local-paths.example.json
├─ commands/
└─ references/
```

Claude Code 安装后，建议先复制 `local-paths.example.json` 为 `local-paths.json`，再把本机资源路径填进去。安装脚本在覆盖安装时会保留已有的 `local-paths.json`。
如果本地还挂了最全的外部知识盘，也建议一并配置 `bos_docs_path`。

## 共享内容说明

### `references/examples/`

放“这段代码怎么写”的内容，适合查找事件示例、场景代码、完整插件示例。

### `references/docs/`

放“这个能力怎么开发、有哪些规则和边界”的内容，适合查找 KWC 脚本控制器、定制开发专题说明和实现约束。

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

### 外部知识盘（可选增强）

这个 skill 默认依赖仓库内的 `references/` 完成检索，不要求额外挂载任何私有资料。

如果维护者本地还有更完整的 SDK 文档包、反编译知识库或历史沉淀资料，可以把它们作为“外部知识盘”挂载使用，例如：

- 通过环境变量 `BOS_DOCS_PATH` 指向外部资料目录
- 或在当前工作区放置一个不提交到仓库的本地文档目录
- 或在安装目录的 `local-paths.json` 中显式配置 `bos_docs_path`

推荐的外部知识盘组织方式：

- 每个对象尽量采用成对文件
  - `*-description.md`：API、用途、方法列表、参数语义
  - `*-example.md`：真实业务示例、坑点、防误用写法

使用原则：

- 外部知识盘是可选增强层，不是默认依赖。
- 不把外部资料整包直接搬进 skill 仓库。
- 优先把高频、高风险内容提炼成 `references/sdk/indexes/`、`references/sdk/classes/`、`references/sdk/packages/` 和 `references/examples/`。
- 只有仓库内知识层不足时，才按 `references/sdk/strategy.md` 的规则降级到外部知识盘。

### 仓库内附带的离线资料包

如果你需要一份可直接下载的离线 SDK / 文档资料包，可以使用当前目录下的 `sdks.zip`。

推荐用法：

1. 下载并解压 `sdks.zip`
2. 把解压后的目录配置到 `bos_docs_path` 或环境变量 `BOS_DOCS_PATH`
3. 仍然先走仓库内 `references/`，只有不足时再进入这份离线资料包

这份压缩包的定位是“最全的可选扩展层”，不是默认入口，也不替代仓库内已经结构化整理好的 `references/`。

## 许可

MIT
