# kingscript-code-generator

Kingscript 二开 AI skill，用于脚本生成/修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断和实现风险审查。

## 安装

将本目录整体复制到目标 Agent 的 skills 目录下即可。入口文件为 `SKILL.md`，兼容 Claude Code、Codex 和 Qoder。

也可以使用安装脚本（默认安装到 `~/.qoder/skills/`，支持 `-TargetDir` 指定路径）：

```powershell
# Windows
./install.ps1
```

```bash
# macOS / Linux
bash install.sh
```

## 知识库结构

```
references/
├── language/                    ← 语法规范与关键字
├── sdk/                         ← SDK 索引、声明、类/包/插件文档
├── gotchas/                     ← 公共注意事项与经验（运行时约束、常见问题）
├── docs/                        ← 各开发类型专属指南
├── templates/                   ← 各开发类型起手模板
└── examples/                    ← 示例
    ├── plugins/                 ← 插件示例
    └── community/               ← 社区综合示例
```

详细检索顺序和约束见 `SKILL.md`。

## 外部资源（可选）

- `bos-plugin-sample-7.0.jar` — Java 样例 jar，放在 skill 安装目录同级，用于反编译查找 Java 源码
- `bos-docs/` — 外部知识盘，放在 skill 安装目录同级，仅在 `references/` 不足时使用
- `sdks.zip` — 仓库内附带的 SDK 扩展包，解压后可作为外部知识盘使用
