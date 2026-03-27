# SDK 检索策略

本文件用于定义 Kingscript skill 的全量 SDK 检索降级链路。

## 大文件警告

- `references/sdk/manifests/` 下的结构化清单文件体积可能较大，只适合按需查询，不适合整体加载。
- `references/sdk/manifests/methods.json` 为全量方法级兜底清单，优先用于“已通过索引缩小范围后的精确定位”。
- 处理 SDK 问题时，先走 `classes/`、`indexes/`，只有在索引不足时再按需读取清单文件。
- 为了适合 GitHub 仓库发布，`methods.json` 不作为仓库默认提交内容；仓库版优先依赖可读索引和轻量清单。

## 目标

- 高频类优先命中知识卡
- 长尾类依然能通过本地声明和在线文档兜底
- 在缺少知识卡时，模型仍然能稳定定位模块、包、类、方法和来源
- 明确“何时继续降级，何时停止并声明假设”

## 标准降级链路

### 第 1 层：知识卡层

优先读取：

- `references/sdk/classes/`
- `references/sdk/packages/`
- `references/sdk/plugins/`
- `references/sdk/microservices/`

适用场景：

- 已知类名且已有知识卡
- 高频类、高风险类、常见扩展点
- 需要快速获得“用途 + 场景 + 风险 + FAQ + 示例”

### 第 2 层：索引层

如果没有命中知识卡，按问题类型进入索引：

- 类名问题 -> `references/sdk/indexes/class-index.md`
- 包或模块问题 -> `references/sdk/indexes/package-index.md`、`references/sdk/indexes/module-index.md`
- 场景问题 -> `references/sdk/indexes/scenario-index.md`
- 关键词问题 -> `references/sdk/indexes/keyword-index.md`
- 报错问题 -> `references/sdk/indexes/error-index.md`
- 插件或扩展点问题 -> `references/sdk/indexes/plugin-index.md`
- 微服务问题 -> `references/sdk/indexes/microservice-index.md`
- 方法问题 -> `references/sdk/indexes/method-index.md`

适用场景：

- 需要先定位类、包、模块
- 用户说法与 SDK 正式名称不一致
- 还没有对应知识卡

### 第 3 层：清单层

如果索引不足以回答细节，再读取结构化清单：

- `references/sdk/manifests/summary.json`
- `references/sdk/manifests/modules.json`
- `references/sdk/manifests/packages.json`
- `references/sdk/manifests/types.json`
- `references/sdk/manifests/const-exports.json`
- `references/sdk/manifests/namespaces.json`
- `references/sdk/manifests/methods.json`（如本地或发布资产中存在）

适用场景：

- 需要全量定位
- 需要确认导出名、namespace、模块归属
- 需要确认方法名、签名、参数和返回值结构
- 需要做长尾 SDK 兜底检索

补充说明：

- GitHub 仓库版默认不依赖 `methods.json` 才能工作。
- 如果 `methods.json` 缺失，则方法级问题优先使用：
  - `references/sdk/indexes/method-index.md`
  - `references/sdk/indexes/methods-by-name.md`
  - `references/sdk/indexes/methods-hot.md`
  - `references/sdk/indexes/methods-lifecycle.md`
  然后再继续降级到本地声明层。

### 第 4 层：外部挂载知识盘（可选扩展层）

如果仓库内知识卡、索引和清单仍不足以回答问题，而维护者本地额外挂载了 SDK 文档包或反编译知识库，可以按需进入外部知识盘。

推荐入口：

- 环境变量 `BOS_DOCS_PATH`
- 当前工作区中由维护者自行挂载、但不提交到仓库的文档目录

读取原则：

- 优先模糊定位最相关的 `*-description.md`
- 先读 `*-description.md` 了解 API、用途、参数和方法结构
- 只有当问题需要真实写法、运行时边界、联动代码或常见坑时，再继续读取配套的 `*-example.md`
- 不整盘通读，不把外部知识盘当成默认入口

适用场景：

- 长尾 SDK 类型在仓库内尚未沉淀知识卡
- 需要反编译级方法清单或真实业务示例
- 需要比 `.d.ts` 更接近运行时的经验性资料

### 第 5 层：本地声明层

如果清单无法解释语义或需要更细的签名信息，读取本地声明文件。

当前本地兜底路径：

- `<YOUR_LOCAL_NODE_MODULES>`（本地 Kingscript 项目的 node_modules 目录）

读取原则：

- 优先打开命中的单个 `.d.ts` 文件
- 不整目录扫描，不整模块通读
- 只读取与目标类、包、方法直接相关的文件

### 第 6 层：在线 Javadoc 层

如果本地声明只能提供结构，无法解释语义、参数含义、返回值说明、废弃信息，再读取在线 Javadoc。

当前在线兜底入口：

- [Cosmic V8.0.1 Javadoc](https://dev.kingdee.com/sdk/Cosmic%20V8.0.1/index.html?nav=class)

适用场景：

- 需要参数语义、返回值语义、版本信息、废弃说明
- 本地 `.d.ts` 中没有足够注释

### 第 7 层：有界回答层

如果以上各层仍不能确认答案：

- 明确说明查到了什么
- 明确说明缺什么
- 明确说明哪些是推断
- 提供有界方案，不编造 SDK 内容

## 检索停止条件

满足以下任意条件即可停止继续降级：

- 已经能确认类、场景、边界、风险
- 已经能给出足够可信的结构化回答
- 再继续读取只会增加噪音，不会显著提高确定性

## 不允许的行为

- 不允许直接跳过索引层去整目录扫 `node_modules`
- 不允许把外部知识盘整目录扫读并替代仓库内索引层
- 不允许只看 TypeScript 声明就默认运行时一定可用
- 不允许本地和在线来源冲突时擅自选一个而不说明

## 输出要求

涉及 SDK 解释时，回答至少应说明：

- 当前命中的类或方法
- 来源层级
  - 知识卡
  - 索引
  - 清单
  - 本地声明
  - 在线 Javadoc
- 已确认事实
- 运行时边界
- 待确认项
