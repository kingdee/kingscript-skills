# SDK 高频方法检索

本索引不是按全量出现次数机械排序，而是按 Kingscript 二开常见任务挑出更值得优先看的方法。

## 使用建议

- 先从最接近当前任务的分组进入。
- 找到方法名后，再回到类知识卡或 `methods.json` 看具体签名。
- 如果同名方法分布在多个类里，优先看 Kingscript 二开高相关类。

## 数据查询与过滤

- `load` | 按条件加载结构化业务对象，优先关注 `BusinessDataServiceHelper`。 | 13 次 | 代表类：BusinessDataServiceHelper, HSPMBusinessDataServiceHelper, IFilterModel, MappedByteBuffer, ORMUtil, Properties
- `loadSingle` | 读取单条数据，常用于单据联动和校验前查询。 | 11 次 | 代表类：BusinessDataServiceHelper, HRBaseServiceHelper, ServiceLoader
- `query` | 查询列表或扁平结果，注意与 `load` 的返回结构区别。 | 25 次 | 代表类：AbstractBillWebApiPlugin, AbstractReportTreeDataPlugin, HRBaseServiceHelper, IAccBalReportQuery, IReportListDataPlugin, ListSelectedListener
- `queryOne` | 只读查询一条，优先关注 `QueryServiceHelper`。 | 13 次 | 代表类：HRBaseServiceHelper, QueryServiceHelper
- `exists` | 做存在性判断或 `QFilter.exists/notExists` 过滤。 | 10 次 | 代表类：EarlyWarnMetaServicHelper, File, FileService, FileStorageService, QFilter, QueryServiceHelper
- `join` | 常见于 `QFilter` 关联过滤构造。 | 32 次 | 代表类：DataSet, DataSetX, JoinFunction, QFilter, StringUtils
- `of` | 构造条件表达式或工厂型对象时常见。 | 55 次 | 代表类：Chronology, Collector, DecimalStyle, DoubleStream, Duration, EnumSet

## 页面视图与模型

- `getView` | 获取页面视图上下文，常用于表单插件。 | 38 次 | 代表类：AbstractFormPlugin, AbstractOperate, AbstractOperateWebApi, AbstractReportModel, ActiveViewEvent, AdminGroupPermSubBO
- `getModel` | 获取数据模型上下文。 | 17 次 | 代表类：AbstractFormPlugin, AdminGroupPermSubBO, CardBindDataDTO, Control, CubeUtils, IFormView
- `updateView` | 刷新界面或局部控件。 | 4 次 | 代表类：IFormView
- `setEnable` | 控制页面或控件启用状态。 | 27 次 | 代表类：AddUsrGrpReq, ArchiveDatabase, ArchiveRule, ArchiveSchedule, ComplexSettingItem, DataRuleInfo
- `showMessage` | 页面消息提示。 | 8 次 | 代表类：AbstractFormView, FieldPermHelper, IBaseMessageService, IFormView

## 插件与生命周期

- `propertyChanged` | 字段变更事件入口。 | 1 次 | 代表类：IDataModelChangeListener
- `beforePropertyChanged` | 字段变更前拦截入口。 | 1 次 | 代表类：IDataModelChangeListener
- `afterLoadData` | 数据加载后处理。 | 3 次 | 代表类：IBillPlugin, IPrintPlugin, WorkflowDesigner
- `beforeDoOperation` | 表单操作前拦截。 | 3 次 | 代表类：IFormPlugin, IMobOperationDataTransferPlugin
- `afterDoOperation` | 表单操作后处理。 | 2 次 | 代表类：IFormPlugin
- `beforeExecuteOperationTransaction` | 操作服务插件事务前入口。 | 1 次 | 代表类：IOperationServicePlugIn
- `preOpenForm` | 页面打开前预处理。 | 3 次 | 代表类：ApprovalPageTpl, IFormPlugin
- `beforeBindData` | 绑定数据前处理。 | 3 次 | 代表类：BeforeBindDataListener, IFormPlugin
- `afterBindData` | 绑定数据后处理。 | 3 次 | 代表类：AfterBindDataListener, IFormPlugin
- `beforeClosed` | 页面关闭前处理。 | 3 次 | 代表类：DataSet$Listener, IFormPlugin
- `createNewData` | 新建数据时的模型入口。 | 3 次 | 代表类：IDataModel, IDataModelListener
- `afterCreateNewData` | 新建数据后扩展入口。 | 1 次 | 代表类：IDataModelListener
- `registerListener` | 统一注册按钮、F7、上传与控件监听。 | 未检出 | 代表类：IFormPlugin
- `beforeFieldPostBack` | 字段回传前拦截，常用于性能优化。 | 未检出 | 代表类：IFormPlugin
- `closedCallBack` | 子页面关闭后回传父页面。 | 未检出 | 代表类：IFormPlugin
- `timerElapsed` | 定时刷新、轮询与自动保存入口。 | 未检出 | 代表类：AbstractFormPlugin
- `pageRelease` | 页面资源、缓存与定时器清理入口。 | 未检出 | 代表类：AbstractFormPlugin
- `setWaterMarkInfo` | 按状态动态设置页面水印。 | 未检出 | 代表类：AbstractFormPlugin
- `beforePackageData` | 列表数据显示前格式化或补字段。 | 2 次 | 代表类：BeforePackageDataListener, IListPlugin
- `beforeF7Select` | F7 打开前改过滤条件和显示参数。 | 2 次 | 代表类：BeforeF7SelectListener, BeforeFilterF7SelectListener
- `afterF7Select` | F7 选择完成后读取选中结果与回填信息。 | 未检出 | 代表类：AfterF7SelectListener
- `billClosedCallBack` | 列表打开单据后的关闭回调入口。 | 未检出 | 代表类：IListPlugin
