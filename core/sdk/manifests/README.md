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

## Release 附件下载说明

推荐把全量方法清单以 Release 附件形式分发，而不是直接放入仓库主分支。

推荐附件名：

- `methods.json.zip`

使用方式：

1. 从仓库 Release 页面下载附件
2. 解压得到 `methods.json`
3. 放入当前目录，即 `core/sdk/manifests/`
4. 再结合：
   - `core/sdk/indexes/method-index.md`
   - `core/sdk/indexes/methods-by-name.md`
   - `core/sdk/indexes/methods-hot.md`
   - `core/sdk/indexes/methods-lifecycle.md`
   使用

这样做的目的是：

- 保持 GitHub 仓库轻量
- 让普通使用者 clone 即可用
- 让需要全量方法级兜底的人按需增强

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
