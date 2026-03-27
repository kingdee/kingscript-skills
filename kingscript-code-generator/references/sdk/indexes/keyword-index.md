# SDK 关键词索引

本文件先提供一版高频关键词入口，后续可继续根据常见提问和 FAQ 扩充。

| 关键词 | 推荐目标 | 场景 | 说明 |
|--------|----------|------|------|
| 过滤条件 | `QFilter` | 查询与过滤 | 常见于 in、and、or 条件构造 |
| 查询单据 | `BusinessDataServiceHelper` | 查询与过滤 | 常见于按实体加载单据或资料 |
| 查询服务 | `QueryServiceHelper` | 查询与过滤 | 常见于查询单值、单条、多条数据 |
| 当前用户 | `RequestContext` | 上下文与用户信息 | 常见于取用户、组织、租户 |
| 当前组织 | `RequestContext` | 上下文与用户信息 | 常见于按组织过滤、组织权限判断 |
| 登录组织 | `RequestContext` | 上下文与用户信息 | 常见于判断登录组织与业务组织 |
| 当前租户 | `RequestContext` | 上下文与用户信息 | 常见于租户隔离与多账套场景 |
| 序列化 | `SerializationUtils` | 类型与运行时桥接 | Java 对象序列化与反序列化 |
| 反序列化 | `SerializationUtils` | 类型与运行时桥接 | 字符串或结构化结果还原对象 |
| 长整型 | `BigInt` | 类型与运行时桥接 | 避免超过 Number 安全范围 |
| 金额 | `BigDecimal` | 类型与运行时桥接 | 金额、税额、汇率等高精度处理 |
| 高精度 | `BigDecimal` | 类型与运行时桥接 | 避免 JS number 精度问题 |
| 日期 | `Date` | 类型与运行时桥接 | 运行时日期对象比较与回写 |
| 日期比较 | `Date` | 类型与运行时桥接 | 常见于 compareTo、getTime 场景 |
| 单据插件 | `AbstractBillPlugIn` | 插件与扩展点 | 单据场景的高频基类 |
| 表单插件 | `AbstractFormPlugin` | 插件与扩展点 | 动态表单场景的高频基类 |
| 操作插件 | `AbstractOperationServicePlugIn` | 插件与扩展点 | 保存、提交、审核等操作服务插件基类 |
| 校验器 | `AbstractValidator` | 插件与扩展点 | 自定义操作校验器基类 |
| 自定义校验 | `AbstractValidator` | 插件与扩展点 | 常见于 `onAddValidators` 场景 |
| 查单据 | `BusinessDataServiceHelper` | 查询与过滤 | 按实体加载业务数据 |
| 查询一条 | `QueryServiceHelper` | 查询与过滤 | 常见于 `queryOne` 场景 |
| 比较符 | `QCP` | 查询与过滤 | 常见于 equals、in、not in |
| 查询操作符 | `QCP` | 查询与过滤 | `QFilter` 的常用搭配对象 |
| 表单视图 | `IFormView` | 视图与模型 | 页面交互能力入口 |
| 表单页面 | `FormView` | 视图与模型 | MVC 表单视图实现 |
| 数据模型 | `AbstractFormDataModel` | 视图与模型 | 表单与单据数据模型抽象层 |
| 打开页面参数 | `FormShowParameter` | 页面打开与回调 | 打开页面、传参、配置回调 |
| 弹窗参数 | `FormShowParameter` | 页面打开与回调 | 打开子页面或弹窗时使用 |
| 关闭回调 | `CloseCallBack` | 页面打开与回调 | 子页面关闭后通知父页面 |
| 关闭回调事件 | `ClosedCallBackEvent` | 页面打开与回调 | 父页面接收子页面关闭通知 |
| 展示方式 | `ShowType` | 页面打开与回调 | 决定模态、非模态、新窗口等 |
| 模态打开 | `ShowType` | 页面打开与回调 | 常见于 `ShowType.Modal` |
| F7 | `BasedataEdit` | 控件与资料选择 | 基础资料选择与过滤 |
| 基础资料控件 | `BasedataEdit` | 控件与资料选择 | 控制 F7、多选、过滤与回填 |
| F7 选择前 | `BeforeF7SelectEvent` | 控件与资料选择 | 打开 F7 前追加过滤条件或改显示参数 |
| F7 选择后 | `AfterF7SelectEvent` | 控件与资料选择 | 选择完成后读取回填结果、当前行和回调标识 |
| F7 过滤 | `BeforeFilterF7SelectEvent` | 控件与资料选择 | 过滤容器或列表过滤面板的 F7 入口过滤 |
| 过滤容器 F7 | `BeforeFilterF7SelectEvent` | 控件与资料选择 | 常见于列表过滤栏、报表过滤栏、移动端过滤容器 |
| 快捷新增 | `BeforeQuickAddNewEvent` | 控件与资料选择 | 控制基础资料快捷新增前的打开方式和拦截逻辑 |
| 字段回传 | `BeforeFieldPostBackEvent` | 页面交互与性能 | 客户端字段值变化是否回传服务器 |
| 页面释放 | `AbstractFormPlugin` | 页面交互与性能 | 常见于 `pageRelease` 资源清理场景 |
| 定时器 | `AbstractFormPlugin` | 页面交互与性能 | 常见于 `timerElapsed` 定时刷新和轮询 |
| 水印 | `AbstractFormPlugin` | 页面交互与性能 | 常见于 `setWaterMarkInfo` 动态状态标识 |
| 数据包格式化 | `BeforePackageDataEvent` | 列表与控件 | 列表显示前改写或补齐显示字段 |
| 数据包 | `BeforePackageDataEvent` | 列表与控件 | 列表页面数据格式化前事件参数 |
| 权限校验 | `BeforeDoCheckDataPermissionArgs` | 权限与数据边界 | 数据权限检查前拦截或跳过 |
| 跳过权限 | `BeforeDoCheckDataPermissionArgs` | 权限与数据边界 | 特殊角色跳过数据权限检查 |
| 关闭回调列表 | `BillClosedCallBackEvent` | 页面打开与回调 | 列表打开单据后关闭回调 |
| 列表关闭回调 | `BillClosedCallBackEvent` | 页面打开与回调 | 列表插件接收关闭子单据通知 |
| 数据变更集 | `ChangeData` | 视图与模型 | `propertyChanged` 中逐项读取字段变化 |
| 模型变更监听 | `IDataModelChangeListener` | 视图与模型 | 字段变化、分录增删改、批量值更新 |
| 模型初始化监听 | `IDataModelListener` | 视图与模型 | 新建、复制、引入、装载数据包 |
| 动态实体 | `DynamicObject` | 视图与模型 | 单据头、分录行、查询结果的高频数据载体 |
| 分录集合 | `DynamicObjectCollection` | 视图与模型 | 新增分录、删除分录、遍历分录 |
| 单据体 | `EntryGrid` | 视图与模型 | 单据体表格控件、行选择、列属性 |
| 分录表格 | `EntryGrid` | 视图与模型 | 单据体交互层入口 |
| 子分录表格 | `SubEntryGrid` | 视图与模型 | 子单据体表格控件 |
| 分录类型 | `EntryType` | 视图与模型 | 单据体实体元数据 |
| 子分录类型 | `SubEntryType` | 视图与模型 | 子单据体实体元数据 |
| 实体类型 | `EntityType` | 视图与模型 | 通用实体元数据定义 |
| 主实体类型 | `MainEntityType` | 视图与模型 | 单据头元数据入口 |
| 元数据缓存 | `EntityMetadataCache` | 视图与模型 | 按实体读取元数据定义 |
| 操作结果 | `OperationResult` | 操作与校验 | 批量结果、成功主键、错误信息 |
| 字段变化参数 | `PropertyChangedArgs` | 视图与模型 | 数据模型字段联动核心参数 |
| 校验错误 | `ValidationErrorInfo` | 操作与校验 | 单条校验失败信息 |
| 校验结果 | `ValidateResult` | 操作与校验 | 校验器整体返回结果 |
| 错误级别 | `ErrorLevel` | 操作与校验 | 校验失败分级 |
| 列表插件 | `AbstractListPlugin` | 插件与扩展点 | 列表初始化、选择联动、关闭回调 |
| 转换插件 | `AbstractConvertPlugIn` | 插件与扩展点 | 下推、字段映射、转换规则 |
| 反写插件 | `AbstractWriteBackPlugIn` | 插件与扩展点 | 回写数量、回写状态、关闭行 |
| 操作对象 | `FormOperate` | 操作与校验 | 页面操作上下文 |
| 操作选项 | `OperateOption` | 操作与校验 | 扩展参数和变量容器 |
| 基础资料字段 | `BasedataProp` | 控件与资料选择 | 基础资料字段元数据 |
| 主数据字段 | `MasterBasedataProp` | 控件与资料选择 | 主档基础资料字段元数据 |
| 多选基础资料字段 | `MulBasedataProp` | 控件与资料选择 | 多选资料字段结构 |
| 多选基础资料控件 | `MulBasedataEdit` | 控件与资料选择 | 多选 F7 控件 |
| 弹性域控件 | `FlexEdit` | 控件与资料选择 | Flex 录入与显示入口 |
| 弹性域字段 | `FlexProp` | 控件与资料选择 | Flex 字段元数据 |
| 弹性域类型 | `FlexEntityType` | 控件与资料选择 | Flex 组合实体结构 |
| 弹性域属性 | `FlexProperty` | 控件与资料选择 | Flex 维度属性定义 |
| 数据库路由 | `DBRoute` | 数据访问 | 分库或路由访问 |
| 平台异常 | `KDException` | 错误与排障 | 平台运行时异常 |
| Java 桥接 | `java-kingscript-bridge` | 类型与运行时桥接 | Java 对象在 Kingscript 中的使用规则 |
| 单据列表 | `BillList` | 列表与控件 | 列表控件层能力 |
| 列表视图 | `ListView` | 列表与控件 | 列表页面视图实现 |
| 列表绑定前 | `ListBeforeBindDataEvent` | 列表与控件 | 列表数据绑定前初始化过滤或取消绑定 |
| 列表选择 | `DataSelectEvent` | 列表与控件 | 移动端列表选择控件回调与多选控制 |
| 报表视图 | `IReportView` | 报表 | 报表页面视图接口 |
| 报表页面 | `ReportView` | 报表 | 报表 MVC 视图实现 |
| 报表表单 | `ReportForm` | 报表 | 报表页面承载对象 |
| 报表列表 | `ReportList` | 报表 | 报表结果展示层 |
| 报表模型 | `AbstractReportListModel` | 报表 | 报表列表模型抽象层 |
