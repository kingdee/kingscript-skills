# SDK 场景索引

本文件提供第一版按任务场景组织的 SDK 入口。

| 场景 | 推荐先看 | 说明 |
|------|----------|------|
| 查询与过滤 | BusinessDataServiceHelper、QueryServiceHelper、QFilter | 从查询数据和构造过滤条件开始 |
| 表单与单据交互 | AbstractBillPlugIn、AbstractFormPlugin | 先确定插件基类和事件生命周期 |
| 上下文与用户信息 | RequestContext | 先确认用户、组织、租户、账套 |
| 类型与运行时桥接 | BigDecimal、BigInt、Date、SerializationUtils | 关注 Java 对象和 JS 原生对象差异 |
| 插件与扩展点 | AbstractBillPlugIn、AbstractFormPlugin、扩展点接口 | 与 plugin-development 文档联动使用 |
