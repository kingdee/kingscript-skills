# Kingscript Skill Content Map

这个文件专门回答一个问题：`优秀的 skill 需要包含哪些信息，分别放在哪里。`

## 核心原则

- `core/docs/` 只放稳定的领域知识、规则、边界和说明。
- `core/examples/` 只放可参考的代码范式，不放长篇解释。
- `core/templates/` 只放回答模板和输出骨架。
- `core/checklists/` 只放执行前后的检查项。
- `core/recipes/` 只放任务驱动的操作剧本。
- `core/docs/getting-started/` 只放入门、快速上手、开发工具说明。
- `core/docs/plugin-development/` 只放各类插件开发指南和事件说明。
- `core/docs/debugging/` 只放调试流程、断点调试、调试限制和工具说明。
- `core/docs/deployment/` 只放导出、打包、部署和发布流程说明。
- `core/docs/common-issues/` 只放按单个问题拆分的 FAQ、已知问题和定位手册。
- `core/docs/runtime-boundaries/` 只放运行时限制、限流、性能和调用边界。
- `core/docs/custom-development/` 只放定制开发流程、规范和实施说明。
- `core/sdk/` 只放 SDK 声明、开放能力索引、映射说明。
- `core/plugin-templates/` 只放插件模版和脚手架。
- `core/cases/` 只放完整案例和拆解复盘。
- `core/examples/language/` 只放语法级示例和基础代码片段。
- `core/examples/plugins/` 只放按插件类型组织的完整示例。
- `core/language/kingscript/` 只放 Kingscript 语法、模块、异常、命名等语言层知识。

## 推荐信息地图

### 1. 定位与边界

- 放置位置：`core/docs/concepts.md`
- 应包含：
  - Kingscript 是什么
  - 与苍穹平台、元数据模型、Java 后端的关系
  - 适用对象和不适用场景
  - 二开能力边界

### 2. API 和运行时约束

- 放置位置：`core/docs/api-boundaries.md`
- 应包含：
  - 不允许编造 API
  - 声明存在不代表运行时可调用
  - 权限、租户、账套、上下文、生命周期约束
  - Java 开放能力和 TS 声明的映射规则

### 3. 最佳实践与常见坑

- 放置位置：`core/docs/best-practices.md`、`core/docs/pitfalls.md`
- 应包含：
  - 先补上下文再给方案
  - 先复用示例再写新代码
  - 优先做结构化输出
  - 常见误用方式和反例

### 4. 报错排查手册

- 放置位置：`core/docs/troubleshooting.md`
- 应包含：
  - 现象
  - 可能根因
  - 排查顺序
  - 修复建议
  - 回归验证点

补充说明：
- 总览型的排障原则和通用排查流程放 `core/docs/troubleshooting.md`
- 单个问题拆分的 FAQ 和已知问题放 `core/docs/common-issues/`

### 5. 插件模版

- 放置位置：`core/plugin-templates/`
- 应包含：
  - 事件模版
  - 表单模版
  - 校验模版
  - 调服务模版
  - 异常处理模版

### 6. SDK 与开放能力

- 放置位置：`core/sdk/`
- 应包含：
  - SDK 模块、包、类、场景、关键词、报错索引
  - 常见开放类和扩展点知识卡
  - Java 能力到 Kingscript 用法示例
  - 类型声明和运行时差异说明
  - 清单与映射文件

补充说明：
- `core/sdk/indexes/` 只放检索入口，不放大段细节
- `core/sdk/classes/` 只放类、接口、枚举、扩展点知识卡
- `core/sdk/packages/` 只放包级总览
- `core/sdk/plugins/` 只放插件与扩展点入口
- `core/sdk/microservices/` 只放微服务入口
- `core/sdk/manifests/` 只放结构化清单和映射文件
- `core/sdk/manifests/methods.json` 只作为全量方法级兜底清单，不作为默认整体阅读入口
- `core/sdk/templates/` 只放 SDK 文档生成模板
- `core/sdk/strategy.md` 只放 SDK 标准检索降级链路
- `core/sdk/indexes/method-index.md` 放方法级索引设计和方法清单使用说明
- `core/sdk/indexes/methods-by-name.md` 只放按方法名缩小范围的可读索引
- `core/sdk/indexes/methods-hot.md` 只放按高频任务组织的方法入口
- `core/sdk/indexes/methods-lifecycle.md` 只放生命周期方法入口

### 7. 插件开发指南

- 放置位置：`core/docs/plugin-development/`
- 应包含：
  - 插件类型总览
  - 表单、单据、列表、操作、报表、调度等插件说明
  - 事件清单
  - 注册和上传路径
  - 与模板和示例的对应关系

### 8. 运行时边界与限流

- 放置位置：`core/docs/runtime-boundaries/`
- 应包含：
  - SDK 限流规则
  - 查询、保存、删除、缓存等上限
  - 运行时性能边界
  - 关键开关和读取方式

### 9. 高频示例

- 放置位置：`core/examples/`
- 应包含：
  - 场景说明
  - 假设条件
  - 完整代码
  - 风险提醒

补充说明：
- 语法级示例优先放 `core/examples/language/`
- 插件级完整示例优先放 `core/examples/plugins/`
- 超大插件示例优先继续按“插件类型 -> 事件名”拆分，避免单文件过大导致检索失控

### 10. 真实案例

- 放置位置：`core/cases/`
- 应包含：
  - 业务目标
  - 设计思路
  - 关键代码
  - 踩坑记录
  - 可复用结论

### 11. Kingscript 语言层知识

- 放置位置：`core/language/kingscript/`
- 应包含：
  - 变量、条件、循环、方法、类、接口
  - 异常处理
  - 模块与引用
  - 命名规范
  - 保留关键字
  - Kingscript 相比通用 TypeScript 的注意事项

### 12. 定制开发方法与规范

- 放置位置：`core/docs/custom-development/`
- 应包含：
  - 开发流程
  - 开发规范
  - 业务扩展点
  - 构建、部署、调试约束
  - 安全与性能要求

### 13. 调试与排障操作说明

- 放置位置：`core/docs/debugging/`
- 应包含：
  - 调试环境准备
  - VSCode 或在线编辑器调试流程
  - 断点、变量、表达式、调用栈查看方式
  - 登录态、心跳页、同步调试等限制说明

### 14. 打包与部署说明

- 放置位置：`core/docs/deployment/`
- 应包含：
  - KSC 导出流程
  - DCS 打包说明
  - 手工打包与元数据嵌入方式
  - 天梯部署和发布前确认项

### 15. 输出模板和清单

- 放置位置：`core/templates/`、`core/checklists/`
- 应包含：
  - 代码生成模板
  - 代码修改模板
  - 报错分析模板
  - 代码审查模板
  - 方案设计模板
  - 风险检查清单
