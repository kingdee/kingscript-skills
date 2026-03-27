# SDK 生命周期方法检索

本索引面向“这个事件/钩子应该写在哪、什么时候触发”的问题。

## 说明

- 优先列出在当前 `methods.json` 中真实检出的生命周期方法。
- 对于二开非常关注但本地清单未检出的名字，会明确标注“未检出”，不做编造。

## 核心生命周期方法

- `preOpenForm` | 3 次 | 方法分类：生命周期方法 | 代表类：ApprovalPageTpl, IFormPlugin
- `beforeBindData` | 3 次 | 方法分类：生命周期方法 | 代表类：BeforeBindDataListener, IFormPlugin
- `afterBindData` | 3 次 | 方法分类：生命周期方法 | 代表类：AfterBindDataListener, IFormPlugin
- `afterLoadData` | 3 次 | 方法分类：生命周期方法 | 代表类：IBillPlugin, IPrintPlugin, WorkflowDesigner
- `beforeClosed` | 3 次 | 方法分类：生命周期方法 | 代表类：DataSet$Listener, IFormPlugin
- `beforeDoOperation` | 3 次 | 方法分类：生命周期方法 | 代表类：IFormPlugin, IMobOperationDataTransferPlugin
- `afterDoOperation` | 2 次 | 方法分类：生命周期方法 | 代表类：IFormPlugin
- `beforeExecuteOperationTransaction` | 1 次 | 方法分类：生命周期方法 | 代表类：IOperationServicePlugIn
- `beforeSaveAuditLog` | 2 次 | 方法分类：生命周期方法 | 代表类：IAuditLogBizExtPlugin, IOperationServicePlugIn
- `beforeLoadData` | 2 次 | 方法分类：生命周期方法 | 代表类：IPrintPlugin, IPrintServicePlugin
- `propertyChanged` | 1 次 | 方法分类：生命周期方法 | 代表类：IDataModelChangeListener
- `beforePropertyChanged` | 1 次 | 方法分类：生命周期方法 | 代表类：IDataModelChangeListener
- `beforeFieldPostBack` | 未检出为统一生命周期方法 | 方法分类：高频页面事件 | 代表类：IFormPlugin
- `closedCallBack` | 未检出为统一生命周期方法 | 方法分类：高频回调事件 | 代表类：IFormPlugin
- `registerListener` | 未检出为统一生命周期方法 | 方法分类：高频初始化事件 | 代表类：IFormPlugin
- `timerElapsed` | 未检出为统一生命周期方法 | 方法分类：高频页面事件 | 代表类：AbstractFormPlugin
- `pageRelease` | 未检出为统一生命周期方法 | 方法分类：高频页面事件 | 代表类：AbstractFormPlugin
- `setWaterMarkInfo` | 未检出为统一生命周期方法 | 方法分类：高频页面事件 | 代表类：AbstractFormPlugin
- `billClosedCallBack` | 未检出为统一生命周期方法 | 方法分类：列表回调事件 | 代表类：IListPlugin
- `beforeF7Select` | 2 次 | 方法分类：高频控件事件 | 代表类：BeforeF7SelectListener, BeforeFilterF7SelectListener
- `createNewData` | 3 次 | 方法分类：实例方法 | 代表类：IDataModel, IDataModelListener
- `afterCreateNewData` | 1 次 | 方法分类：生命周期方法 | 代表类：IDataModelListener

## 从清单中统计出的高频生命周期方法

- `afterClone` | 9 次 | 9 个类 | BasedataEntityType, CtLinkEntryType, DynamicObjectType, DynamicProperty, EntityType, LinkEntryType
- `beforeUpload` | 5 次 | 5 个类 | Button, ImageList, PictureEdit, Toolbar, UploadListener
- `afterProcess` | 4 次 | 4 个类 | IAfterSettleProcess, IAfterWoffProcess, ICasPayBillPayCallback, IInvIssueCallback
- `beforeSave` | 4 次 | 4 个类 | BatchImportPlugin, IAdminGroupPermSubPlugin, ICtSavePlugIn, IFormDesignService
- `afterSave` | 3 次 | 3 个类 | IAdminGroupPermSubPlugin, IFormDesignService, IWorkflowModelPlugin
- `beforeDoOperation` | 3 次 | 2 个类 | IFormPlugin, IMobOperationDataTransferPlugin
- `beforeClosed` | 3 次 | 2 个类 | DataSet$Listener, IFormPlugin
- `afterLoadData` | 3 次 | 3 个类 | IBillPlugin, IPrintPlugin, WorkflowDesigner
- `beforeShowPropertyEdit` | 3 次 | 3 个类 | AbstractFormDesignerPlugin, BillListCDWDesignerPlugin, MobBillDesignerPlugin
- `afterQuery` | 3 次 | 3 个类 | IReportFormPlugin, IReportListDataServiceExt, IReportQueryExtPlugin
- `afterBindData` | 3 次 | 2 个类 | AfterBindDataListener, IFormPlugin
- `beforeBindData` | 3 次 | 2 个类 | BeforeBindDataListener, IFormPlugin
- `preOpenForm` | 3 次 | 2 个类 | ApprovalPageTpl, IFormPlugin
- `afterImportData` | 2 次 | 2 个类 | IAfterImportDataExt, IDataModelListener
- `beforeQuery` | 2 次 | 2 个类 | IDataCtrlCasePlugin, IReportFormPlugin
- `afterAllParamInit` | 2 次 | 2 个类 | QteParamInitExtPlugin, TieParamInitExtPlugin
- `afterBuildSourceBillIds` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `afterCalcWriteValue` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `afterCloseRow` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `afterCommitAmount` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `afterExcessCheck` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `afterReadSourceBill` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `afterSaveSourceBill` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeCloseRow` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeCreateArticulationRow` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeExcessCheck` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeExecWriteBackRule` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeReadSourceBill` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeSaveSourceBill` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeSaveTrans` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforeTrack` | 2 次 | 2 个类 | ICtWriteBackPlugIn, IWriteBackPlugIn
- `beforePackageData` | 2 次 | 2 个类 | BeforePackageDataListener, IListPlugin
- `afterOperationClose` | 2 次 | 2 个类 | DefaultEntityOperate, FormOperate
- `beforeInvokeOperation` | 2 次 | 2 个类 | DefaultEntityOperate, FormOperate
- `beforeSaveAuditLog` | 2 次 | 2 个类 | IAuditLogBizExtPlugin, IOperationServicePlugIn
- `beforeDesensitive` | 2 次 | 2 个类 | IListPlugin, IPrintServicePlugin
- `beforeLoadData` | 2 次 | 2 个类 | IPrintPlugin, IPrintServicePlugin
- `afterReceiveResponse` | 2 次 | 2 个类 | ClientAjax, ResponseListener
- `beforeF7Select` | 2 次 | 2 个类 | BeforeF7SelectListener, BeforeFilterF7SelectListener
- `afterDoOperation` | 2 次 | 1 个类 | IFormPlugin

## Kingscript 二开高频补充入口

- `registerListener`
  - 典型用途：注册按钮、分录行、F7、上传或自定义控件监听器
  - 推荐先看：`AbstractFormPlugin`、`BeforeF7SelectEvent`、`AfterF7SelectEvent`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/registerListener.md`
- `beforeFieldPostBack`
  - 典型用途：减少无意义字段回传，提升页面录入性能
  - 推荐先看：`BeforeFieldPostBackEvent`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/beforeFieldPostBack.md`
- `closedCallBack`
  - 典型用途：父页面接收子页面关闭通知，刷新局部数据
  - 推荐先看：`CloseCallBack`、`ClosedCallBackEvent`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/closedCallBack.md`
- `beforePackageData`
  - 典型用途：列表数据绑定前补齐显示字段、格式化展示结果
  - 推荐先看：`BeforePackageDataEvent`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/beforePackageData.md`
- `timerElapsed`
  - 典型用途：定时刷新看板、轮询任务状态、自动保存
  - 推荐先看：`AbstractFormPlugin`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/timerElapsed.md`
- `pageRelease`
  - 典型用途：页面关闭后清理缓存、临时文件和定时器
  - 推荐先看：`AbstractFormPlugin`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/pageRelease.md`
- `setWaterMarkInfo`
  - 典型用途：按状态动态设置水印文本、颜色和透明度
  - 推荐先看：`AbstractFormPlugin`
  - 相关示例：`references/examples/plugins/插件示例/表单插件-事件拆分/setWaterMarkInfo.md`
- `billClosedCallBack`
  - 典型用途：列表打开单据后，根据关闭回调刷新列表或补选中状态
  - 推荐先看：`BillClosedCallBackEvent`
  - 相关示例：`references/examples/plugins/插件示例/列表插件-事件拆分/billClosedCallBack.md`
