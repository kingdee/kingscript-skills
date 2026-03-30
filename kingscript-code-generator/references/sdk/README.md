# Kingscript SDK 知识层

这个目录不是原始 `node_modules` 的镜像，而是面向大模型检索和二开使用的 SDK 知识层。

## 建设目标

- 让模型先找到正确的模块、包、类或场景，再读取细节
- 把 TypeScript 声明和 Javadoc 说明融合成可检索文档
- 避免把全量 `.d.ts` 直接塞进 skill 导致检索失控
- 支持后续持续增量生成，而不是一次性手工维护全部内容

## 两类来源

### 1. 事实来源

- 本地通过 Java 注解生成的 TypeScript 声明
- 在线 Javadoc 文档

事实来源用于确定：

- 类名、接口名、方法名
- 参数与返回值类型
- 模块、包、命名空间、导入路径
- Javadoc 中的用途说明、参数语义、返回值解释、废弃说明

### 2. 知识来源

- 平台已有示例
- 插件案例
- 常见问题与排障手册
- Java 桥接说明

知识来源用于补充：

- 典型场景
- 常见搭配
- 运行时边界
- 常见报错
- 推荐写法与风险点

## 推荐检索路线

### 已知类名

先读 `indexes/class-index.md`，再打开对应类文档。

### 已知业务场景

先读 `indexes/scenario-index.md`，再跳到目标类文档或示例。

### 已知关键词或用户口语

先读 `indexes/keyword-index.md`。

### 已知报错

先读 `indexes/error-index.md`。

### 已知方法名或生命周期名

先读 `indexes/method-index.md`。

### 已知模块、包、插件或微服务

按顺序读取：

1. `indexes/module-index.md`
2. `indexes/package-index.md`
3. `indexes/plugin-index.md`
4. `indexes/microservice-index.md`

## 全量 SDK 检索降级链路

当知识卡不足以回答问题时，必须按下面的顺序继续查找：

1. `classes/`、`packages/`、`plugins/`、`microservices/`
2. `indexes/`
3. `manifests/`
4. 本地 `.d.ts` 源文件
5. 在线 Javadoc
6. 如果仍不确定，明确说明假设和缺口

当前外部兜底来源：

- 本地声明目录：`<YOUR_LOCAL_NODE_MODULES>`
- 在线 Javadoc：[Cosmic V8.0.1](https://dev.kingdee.com/sdk/Cosmic%20V8.0.1/index.html?nav=class)

## 仓库版与增强版

为了适合直接发布到 GitHub，这个 skill 的 SDK 清单分为两种形态：

### 1. 仓库版

- 默认随仓库提交轻量清单和可读索引
- 保证 clone 下来后就能完成模块、包、类、关键词和大部分方法入口检索
- 不默认提交全量方法清单 `manifests/methods.json`

### 2. 增强版

- 在本地工作区或发布资产中额外提供 `manifests/methods.json`
- 适合做全量方法级精确定位
- 不作为 GitHub 仓库的默认体积负担

## 目录说明

```text
sdk/
├─ README.md
├─ strategy.md
├─ docs/
├─ indexes/
├─ classes/
├─ packages/
├─ plugins/
├─ microservices/
├─ manifests/
└─ templates/
```

当前 `manifests/` 已接入：

- 模块清单
- 包清单
- 类型清单
- 常量导出清单
- 命名空间清单
- 可选的全量方法清单 `methods.json`（增强版）

## 建设原则

- 不把原始 SDK 全量声明直接作为默认阅读入口
- 不让模型整目录扫全量 `.d.ts`
- 一个类一个知识卡，一个包一个总览
- 方法级问题先走 `indexes/method-index.md`，不直接整类通读
- 所有高频问题都应能从 `keyword-index` 或 `error-index` 反查到类或示例
- 生成类文档时，必须同时保留“TS 可调用面”和“运行时边界”
- 生成代码时，必须校验“方法属于当前变量类型或其声明继承链”，不能只因为别处有同名方法就直接挪用
- 生成代码时，事件参数不得默认写成 `any`；有明确类型就用明确类型，只剩声明层类型时按声明原样写

## 当前建议的首批沉淀对象

- `@cosmic/bos-core`
- `@cosmic/bos-script`
- 高频服务助手、查询过滤、上下文、插件基类、序列化、数值与日期相关类型
- 常见扩展点接口和高频插件类

## 外部扩展知识盘（可选）

这个 skill 默认只依赖仓库内的 `references/`，不要求维护者必须额外挂载私有资料。

如果维护者本地还有更完整的 SDK 文档包、反编译知识库或历史沉淀资料，可以把它们作为“外部扩展知识盘”接入，建议：

- 通过环境变量 `BOS_DOCS_PATH` 指向外部资料目录
- 或在工作区中放一个不提交到仓库的本地文档目录

推荐的外部资料组织方式：

- `*-description.md`
  - 负责 API、方法列表、参数语义、适用场景
- `*-example.md`
  - 负责真实业务代码、常见坑、联动写法

使用原则：

- 外部知识盘只作为长尾扩展层，不替代仓库内的 `indexes/`、`classes/`、`packages/`
- 命中 `*-description.md` 后，先理解结构和语义
- 只有在需要真实写法、运行时边界或防坑代码时，再补读配套 `*-example.md`
- 不整包搬运外部资料进仓库，优先把高频内容沉淀回 `references/`

## 注意事项

- 原始 SDK 清单、扫描结果、映射文件统一放在 `manifests/`
- 方法级结构化清单统一放在 `manifests/methods.json`
- GitHub 仓库默认不提交 `manifests/methods.json`，需要时由维护者本地生成或作为发布资产提供
- 面向模型阅读的知识卡统一放在 `classes/`、`packages/`、`plugins/`、`microservices/`
- 文档模板统一放在 `templates/`
- 全量检索规则统一写在 `strategy.md`
- 没有真实来源时，不要伪造任何 SDK 类、方法、参数或返回值

## 本轮新增的高频入口

- Java 与 Kingscript 类型桥接: `docs/java-kingscript-bridge.md`
- 数据操作: `classes/DynamicObject.md`、`classes/DynamicObjectCollection.md`
- 操作结果与校验: `classes/OperationResult.md`、`classes/ValidationErrorInfo.md`、`classes/ValidateResult.md`、`classes/ErrorLevel.md`
- 模型联动: `classes/PropertyChangedArgs.md`
- 高价值插件基类: `classes/AbstractListPlugin.md`、`classes/AbstractConvertPlugIn.md`、`classes/AbstractWriteBackPlugIn.md`
- 操作上下文与扩展参数: `classes/FormOperate.md`、`classes/OperateOption.md`
- 数据访问与异常: `classes/DBRoute.md`、`classes/KDException.md`
- 单据体与元数据: `classes/EntryGrid.md`、`classes/SubEntryGrid.md`、`classes/EntityType.md`、`classes/MainEntityType.md`、`classes/EntryType.md`、`classes/SubEntryType.md`、`classes/EntityMetadataCache.md`
- 基础资料与多选资料: `classes/BasedataEdit.md`、`classes/MulBasedataEdit.md`、`classes/BasedataProp.md`、`classes/MasterBasedataProp.md`、`classes/MulBasedataProp.md`
- 弹性域入口: `classes/FlexEdit.md`、`classes/FlexEntityType.md`、`classes/FlexProperty.md`、`classes/FlexProp.md`
