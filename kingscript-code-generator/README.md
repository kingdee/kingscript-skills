# Kingscript Code Generator

面向 **KWC 脚本控制器后端 API + 数据 CRUD** 的 AI skill。帮助 AI 助手基于本仓库内的 SDK 索引、运行时约束、安全模板生成、解释、审查 KingScript 代码，不编造不可用的 API。

> 仅覆盖后端开发场景。表单插件、列表插件、操作插件、单据转换、报表、移动、打印、工作流等老式前端耦合插件体系**不在本 skill 范围内**。

## 目录结构

```text
kingscript-code-generator/
├─ SKILL.md                      # 唯一入口（AI 读这个）
├─ README.md                     # 本文件
├─ LICENSE
├─ .gitignore
└─ references/
   ├─ backend/                   # KWC 专题：开发指南 / 安全模板 / 运行时约束 / FAQ
   ├─ sdk/
   │  ├─ strategy.md             # SDK 检索策略
   │  ├─ indexes/                # 按 关键词 / 场景 / 报错 / 模块 反查
   │  ├─ classes/                # 数据 CRUD + 元数据类知识卡（27 个）
   │  └─ manifests/              # 模块统计 JSON（modules / summary）
   └─ syntax/                    # 语法 / 关键字 / 命名规范
```

## 安装

本 skill 是 drop-in 形态，无需脚本安装。clone 后做一次软链即可。

**Qoder：**
```bash
ln -s "$(pwd)" ~/.qoder/skills/kingscript-code-generator
```

**Claude Code：**
```bash
ln -s "$(pwd)" ~/.claude/skills/kingscript-code-generator
```

**Codex（OpenAI Agents）：**
```bash
ln -s "$(pwd)" ~/.agents/skills/kingscript-code-generator
```

或者直接把目录复制到对应位置也可以。

## 使用

安装后，AI 会自动加载 [SKILL.md](./SKILL.md) 作为入口。SKILL.md 里给出了：

- 触发时机
- 任务路由速查表
- 完整资料地图（叶子文件直达）
- P0 运行时硬约束（简表，详细见 FAQ）
- 降级检索链路
- 输出规则与禁止事项

所有文档间链接使用相对路径（`./references/...`），无需运行时路径解析，也不需要任何配置文件。

## 维护约定

1. 新增 KWC 专题资料 → `references/backend/`
2. 新增 SDK 类知识卡 → `references/sdk/classes/<ClassName>.md`，同步更新 `indexes/keyword-index.md` / `scenario-index.md` 等手写索引
3. 新增运行时约束 → 先更新 `references/backend/faq-runtime-pitfalls.md` 顶部 P0 总表，再补充对应专题文档
4. **不要重新引入前端耦合内容**（表单插件、列表插件、操作插件、事件类、控件类、视图类等）
5. 用户指出生成代码有误时，不只修当前片段；还要判断是否应沉淀成可复用约束，并回写到 SKILL.md 或 FAQ

## 许可

MIT
