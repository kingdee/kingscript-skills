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
| 单据列表 | `BillList` | 列表与控件 | 列表控件层能力 |
| 列表视图 | `ListView` | 列表与控件 | 列表页面视图实现 |
| 报表视图 | `IReportView` | 报表 | 报表页面视图接口 |
| 报表页面 | `ReportView` | 报表 | 报表 MVC 视图实现 |
| 报表表单 | `ReportForm` | 报表 | 报表页面承载对象 |
| 报表列表 | `ReportList` | 报表 | 报表结果展示层 |
| 报表模型 | `AbstractReportListModel` | 报表 | 报表列表模型抽象层 |
