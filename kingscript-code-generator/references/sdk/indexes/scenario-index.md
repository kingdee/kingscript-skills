# SDK 场景索引

本文件提供一版按任务场景组织的 SDK 入口。

| 场景 | 推荐先看 | 说明 |
|------|----------|------|
| 查询与过滤 | `BusinessDataServiceHelper`、`QueryServiceHelper`、`QFilter` | 从查询数据和构造过滤条件开始 |
| 表单与单据交互 | `AbstractBillPlugIn`、`AbstractFormPlugin` | 先确定插件基类和事件生命周期 |
| 表单生命周期 | `AbstractFormPlugin`、`BeforeFieldPostBackEvent`、`BeforeDoCheckDataPermissionArgs` | 先确认事件写在表单插件还是单据插件，再看事件参数对象 |
| 单据分录增删改 | `IDataModelChangeListener`、`ChangeData` | 先确认字段值变化、分录移动或批量赋值入口 |
| 单据体控件交互 | `EntryGrid`、`SubEntryGrid`、`DynamicObjectCollection` | 先区分是在控件层处理行选择和列属性，还是在模型层读写分录数据 |
| 分录实体与元数据 | `EntryType`、`SubEntryType`、`EntityType`、`EntityMetadataCache` | 先确认要解决的是分录结构问题还是分录取值问题 |
| F7 与基础资料选择 | `BasedataEdit`、`BeforeF7SelectEvent`、`AfterF7SelectEvent`、`BeforeFilterF7SelectEvent` | 先区分字段 F7、过滤容器 F7、快捷新增 |
| 基础资料单选与多选 | `BasedataEdit`、`MulBasedataEdit`、`BasedataProp`、`MulBasedataProp` | 先区分单选控件、多选控件，以及字段底层结构 |
| 弹性域显示与取值 | `FlexEdit`、`FlexProp`、`FlexEntityType`、`FlexProperty` | 先分清显示文本、值对象、维度结构三个层面 |
| 页面打开与关闭回调 | `FormShowParameter`、`CloseCallBack`、`ClosedCallBackEvent`、`BillClosedCallBackEvent` | 先确认回调发生在表单插件还是列表插件 |
| 页面关闭与资源释放 | `AbstractFormPlugin`、`pageRelease`、`timerElapsed` | 关注定时器、缓存和页面资源成对清理 |
| 上下文与用户信息 | `RequestContext` | 先确认用户、组织、租户、账套 |
| 数据操作与分录遍历 | `DynamicObject`、`DynamicObjectCollection` | 先确认拿到的是实体对象还是实体集合，再决定是按字段读写还是按行遍历 |
| 操作插件事务链路 | `AbstractOperationServicePlugIn`、`PreparePropertysEventArgs`、`BeginOperationTransactionArgs`、`BeforeOperationArgs`、`AfterOperationArgs` | 先区分补字段、事务内处理、事务前拦截和结果收口 |
| 校验器与操作结果 | `ValidateResult`、`ValidationErrorInfo`、`OperationResult` | 先区分单条错误、整体校验结果和最终操作结果 |
| 下推与反写 | `AbstractConvertPlugIn`、`AbstractWriteBackPlugIn`、`OperateOption` | 先确认问题发生在转换阶段还是回写阶段 |
| 类型与运行时桥接 | `BigDecimal`、`BigInt`、`Date`、`SerializationUtils` | 关注 Java 对象和 JS 原生对象差异 |
| 列表交互与格式化 | `BillList`、`ListView`、`BeforePackageDataEvent`、`ListBeforeBindDataEvent`、`DataSelectEvent` | 先区分列表显示前格式化、列表选择、移动端选择控件 |
| 打印与列表数据包扩展 | `BeforePackageDataEvent` | 列表显示前补充格式化字段、头像、统计信息等 |
| 权限跳过与权限前置校验 | `BeforeDoCheckDataPermissionArgs`、`RequestContext` | 先确认是否允许跳过数据权限，再考虑提示和取消原因 |
| 插件与扩展点 | `AbstractBillPlugIn`、`AbstractFormPlugin`、扩展点接口 | 与 plugin-development 文档联动使用 |
