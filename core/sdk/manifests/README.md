# SDK 清单与映射文件

这个目录只放机器生成或半机器生成的清单文件，不放面向终端用户阅读的大段解释。

## GitHub 发布策略

- GitHub 仓库默认保留轻量、可直接阅读或可直接被索引使用的清单，例如：
  - `summary.json`
  - `modules.json`
  - `packages.json`
  - `types.json`
  - `const-exports.json`
  - `namespaces.json`
- 全量方法清单 `methods.json` 体积较大，不作为仓库默认提交内容。
- 仓库使用者即使没有 `methods.json`，仍可通过：
  - `core/sdk/indexes/method-index.md`
  - `core/sdk/indexes/methods-by-name.md`
  - `core/sdk/indexes/methods-hot.md`
  - `core/sdk/indexes/methods-lifecycle.md`
  - 本地 `.d.ts`
  - 在线 Javadoc
  来完成大多数方法级检索。
- 如果维护者需要完整方法级兜底能力，可以在本地重新生成 `methods.json`，或在 GitHub Release 中附带该文件。

## 适合放什么

- 全量类清单
- 全量方法清单
- 模块、包、类映射
- 关键词映射
- Javadoc 链接映射
- TS 导出名到 Java 类名的映射

## 不适合放什么

- 详细用法说明
- 业务案例
- 大段 FAQ
- 手工维护的教程

## 建设建议

- 清单文件尽量保持结构化，例如 `json`、`yaml`、`csv`
- 清单内容优先由扫描脚本生成，不建议纯手工维护
- 清单是检索辅助层，不是最终阅读层
- 发布到 GitHub 时，优先保证“仓库版可直接使用”，再考虑附带更大的增强型清单
