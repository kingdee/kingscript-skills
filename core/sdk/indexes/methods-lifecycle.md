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
