# SDK 按方法名字母序检索

本索引面向“我知道方法名，但不知道它属于哪个类”的场景。

## 使用范围

- 这一版优先收录在全量清单里出现 10 次及以上的方法名。
- 对于出现次数较少但二开价值高的方法，单独放在“高价值补充方法”里。
- 如果这里没找到，继续查 `core/sdk/manifests/methods.json`。

## 高价值补充方法

- `load` | 13 次 | 8 个类 | BusinessDataServiceHelper, HSPMBusinessDataServiceHelper, IFilterModel, MappedByteBuffer, ORMUtil, Properties
- `loadSingle` | 11 次 | 3 个类 | BusinessDataServiceHelper, HRBaseServiceHelper, ServiceLoader
- `query` | 25 次 | 12 个类 | AbstractBillWebApiPlugin, AbstractReportTreeDataPlugin, HRBaseServiceHelper, IAccBalReportQuery, IReportListDataPlugin, ListSelectedListener
- `queryOne` | 13 次 | 2 个类 | HRBaseServiceHelper, QueryServiceHelper
- `exists` | 10 次 | 8 个类 | EarlyWarnMetaServicHelper, File, FileService, FileStorageService, QFilter, QueryServiceHelper
- `join` | 32 次 | 5 个类 | DataSet, DataSetX, JoinFunction, QFilter, StringUtils
- `of` | 55 次 | 27 个类 | Chronology, Collector, DecimalStyle, DoubleStream, Duration, EnumSet
- `getView` | 38 次 | 36 个类 | AbstractFormPlugin, AbstractOperate, AbstractOperateWebApi, AbstractReportModel, ActiveViewEvent, AdminGroupPermSubBO
- `getModel` | 17 次 | 14 个类 | AbstractFormPlugin, AdminGroupPermSubBO, CardBindDataDTO, Control, CubeUtils, IFormView
- `updateView` | 4 次 | 1 个类 | IFormView
- `setEnable` | 27 次 | 26 个类 | AddUsrGrpReq, ArchiveDatabase, ArchiveRule, ArchiveSchedule, ComplexSettingItem, DataRuleInfo
- `showMessage` | 8 次 | 4 个类 | AbstractFormView, FieldPermHelper, IBaseMessageService, IFormView
- `propertyChanged` | 1 次 | 1 个类 | IDataModelChangeListener
- `beforePropertyChanged` | 1 次 | 1 个类 | IDataModelChangeListener
- `afterLoadData` | 3 次 | 3 个类 | IBillPlugin, IPrintPlugin, WorkflowDesigner
- `beforeDoOperation` | 3 次 | 2 个类 | IFormPlugin, IMobOperationDataTransferPlugin
- `afterDoOperation` | 2 次 | 1 个类 | IFormPlugin
- `beforeExecuteOperationTransaction` | 1 次 | 1 个类 | IOperationServicePlugIn
- `createNewData` | 3 次 | 2 个类 | IDataModel, IDataModelListener
- `afterCreateNewData` | 1 次 | 1 个类 | IDataModelListener
- `preOpenForm` | 3 次 | 2 个类 | ApprovalPageTpl, IFormPlugin
- `beforeBindData` | 3 次 | 2 个类 | BeforeBindDataListener, IFormPlugin
- `afterBindData` | 3 次 | 2 个类 | AfterBindDataListener, IFormPlugin
- `beforeClosed` | 3 次 | 2 个类 | DataSet$Listener, IFormPlugin

## 字母序索引

### A

- `accept` | 13 次 | 12 个类 | BiConsumer, Consumer, DirectoryStream$Filter, DoubleConsumer
- `add` | 71 次 | 39 个类 | AccessibleRelationSet, AccessibleStateSet, ArrayUtils, BigDecimal
- `addAll` | 19 次 | 9 个类 | AccessibleRelationSet, AccessibleStateSet, ArrayUtils, Collection
- `addField` | 10 次 | 5 个类 | DataSet, FieldDTO, PrtDataSource, SensitiveArgs
- `addFilter` | 14 次 | 11 个类 | AddStepCustomFilterEvent, AdjDetailQueryParamEvent, AndDimensionFilterItemCollection, BasedataEdit
- `addResultValue` | 14 次 | 1 个类 | FormulaParse
- `and` | 19 次 | 10 个类 | BigInteger, BitSet, DoublePredicate, EasyMock
- `andThen` | 10 次 | 10 个类 | BiConsumer, BiFunction, Consumer, DoubleConsumer
- `append` | 17 次 | 5 个类 | Appendable, CachedDataSet$Builder, CompoundId, DataSetBuilder
- `assertArrayEquals` | 18 次 | 1 个类 | Assert

### B

- `build` | 21 次 | 19 个类 | ActionBuilder, ActionListBuilder, AttSettleTaskResp$Builder, BeforeBatchFillEntryArgs
- `buildRuntimeChildControls` | 11 次 | 11 个类 | CardEntryAp, CardRowPanelAp, ContainerAp, FilterContainerAp

### C

- `check` | 33 次 | 33 个类 | AbstractDefValueParamPlugIn, AbstractOpParameterPlugin, AttachmentPanelMapPolicy, BillTypeMapPolicy
- `checkPermission` | 20 次 | 6 个类 | AccessControlContext, IBgmdFormPlugin, MetadataService, PermissionService
- `clear` | 21 次 | 18 个类 | AbstractOperateWebApi, AccessibleRelationSet, AccessibleStateSet, BitSet
- `click` | 17 次 | 17 个类 | AfterSearchClickListener, BasedataEdit, Button, CarouselFigure
- `clone` | 64 次 | 53 个类 | AffineTransform, ArrayList, ArrayUtils, BeforeSubmitCustomEventArgs
- `close` | 16 次 | 16 个类 | AbstractReportModel, AutoCloseable, CachedDataSet, EmbeddedControlService
- `compareTo` | 38 次 | 38 个类 | BigDecimal, BigInteger, BigIntegerField, ByteBuffer
- `completeTask` | 10 次 | 3 个类 | ApprovalPageTpl, IWorkflowService, WorkflowServiceHelper
- `contains` | 39 次 | 21 个类 | AccessibleComponent, AccessibleRelationSet, AccessibleStateSet, ArrayUtils
- `copy` | 18 次 | 13 个类 | BillModel, DataSet, DynamicObjectUtils, ErrorInfo
- `count` | 15 次 | 11 个类 | Calls, DataSet, DataSetX, DoubleStream
- `create` | 58 次 | 40 个类 | AbstractFormDataModel, Algo, AlgoException, AndDimensionFilterItemCollection
- `createChildControls` | 14 次 | 14 个类 | CardEntryAp, ContainerAp, DataGridAp, EntryAp
- `createColumnDesc` | 12 次 | 12 个类 | AmountProp, BooleanProp, DateProp, DateTimeProp
- `createDataEntityType` | 12 次 | 12 个类 | BaseEntity, BillEntity, Entity, EntryEntity
- `createDynamicProperty` | 58 次 | 57 个类 | AddressField, AdminDivisionField, AmountField, AssistantField
- `createEditor` | 24 次 | 23 个类 | AmountDataGridColumn, AmountMobTableColumn, AttachmentMobTableColumn, CardFlexListColumnAp
- `createMock` | 17 次 | 4 个类 | EasyMock, EasyMockSupport, IMockBuilder, IMocksControl
- `createRuntimeControl` | 135 次 | 135 个类 | AdvConAp, AdvFilterGridAp, AmountDataGridColumnAp, AmountMobTableColumnAp
- `createServerEditor` | 54 次 | 53 个类 | AddressField, AdminDivisionField, AmountField, AssistantField
- `createShowListForm` | 14 次 | 13 个类 | AssistantEdit, BasedataEdit, BillTypeEdit, BizBasedataEdit

### D

- `decode` | 12 次 | 10 个类 | Base64, Charset, CharsetDecoder, CodeEdit
- `delete` | 21 次 | 18 个类 | AccessibleEditableText, CtConvertMetaServiceHelper, DeleteServiceHelper, EarlyWarnMetaServicHelper
- `download` | 10 次 | 6 个类 | AttachmentAction, FileService, FileStorageService, IFormView

### E

- `eq` | 11 次 | 1 个类 | EasyMock
- `equals` | 27 次 | 23 个类 | Annotation, CadEmptyUtils, ChronoLocalDate, ChronoLocalDateTime
- `error` | 17 次 | 6 个类 | EntityTraceSpan, EntityTracer, EpmResult, ErrorHandler
- `execute` | 23 次 | 18 个类 | AbstractOperateWebApi, BalanceComputeHelper, EmbeddedCustomEventExecutor, Env
- `exists` | 10 次 | 8 个类 | EarlyWarnMetaServicHelper, File, FileService, FileStorageService

### F

- `fail` | 23 次 | 12 个类 | ApiResult, Assert, CustomApiResult, HRMServiceResult
- `filter` | 17 次 | 12 个类 | BufferedImageOp, DataSet, DataSetX, DoubleStream
- `forEach` | 10 次 | 8 个类 | ConcurrentHashMap, DoubleStream, IntStream, Iterable
- `forEachRemaining` | 10 次 | 10 个类 | Iterator, PrimitiveIterator, PrimitiveIterator$OfDouble, PrimitiveIterator$OfInt
- `format` | 32 次 | 16 个类 | ChronoLocalDate, ChronoLocalDateTime, ChronoZonedDateTime, DateFormat
- `forValue` | 10 次 | 10 个类 | BillOperationStatus, DataEntityCacheType, DataEntityTypeFlag, FlexProperty$DisplayProperty
- `from` | 22 次 | 20 个类 | ArchiveConfigConnectionTypeEnum, ArchiveConfigFilterTypeEnum, ArchiveConfigMovingTypeEnum, ChronoLocalDate

### G

- `get` | 132 次 | 98 个类 | AbstractGrid$GridState, AbstractOpParameterPlugin, AbstractRow, AccessibleRelationSet
- `getAppId` | 44 次 | 44 个类 | AICommand, AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, App
- `getAttFileBoId` | 26 次 | 26 个类 | AdPlanRuleQuery, AfterQteNoGenDateEvent, AfterQteResolveRefDateEvent, AfterQteResolveVarConditionEvent
- `getAttFileBoIds` | 11 次 | 11 个类 | AfterTieTaskEndEvent, AttDataWithDrawReq, AttSumTaskReq, CardMatchTaskParam
- `getAttPersonId` | 22 次 | 22 个类 | AfterQteGenQTEvent, AfterQteNoGenDateEvent, AfterQteResolveRefDateEvent, AfterQteResolveVarConditionEvent
- `getAttribute` | 13 次 | 12 个类 | AttributeSet, AttributedCharacterIterator, Element, FileStore
- `getBaseEntityId` | 15 次 | 12 个类 | BasedataEdit, CommonBaseDataFilterColumnAp, CustomBaseDataFilterColumn, CustomBaseDataSchemeFilterColumn
- `getBigDecimal` | 15 次 | 8 个类 | CallableStatement, DynamicObject, FilterInfo, FilterItemInfo
- `getBillFormId` | 14 次 | 14 个类 | BeforeFilterF7SelectEvent, BillList, BillTypeInfo, BizAppHomeAbstract
- `getBillId` | 20 次 | 20 个类 | AbstractMobBillInfoPlugin, AbstractPricingBillEntryInfo, AttBillTimeBucketExt, BFRowId
- `getBillNo` | 30 次 | 30 个类 | AgentTask, BillEntity, CreditPointDTO, CtExtendedDataEntity
- `getBillType` | 11 次 | 11 个类 | AttBillTimeBucketExt, BeforeChooseApplyTypeEvent, BeforeShowApplyPageEvent, BillEntity
- `getBizAppId` | 10 次 | 10 个类 | CheckContext, ConvertPath, GitPermissionUtil, IBgmdFormPlugin
- `getBoolean` | 15 次 | 9 个类 | CallableStatement, DynamicObject, Field, FilterInfo
- `getBusinessKey` | 15 次 | 15 个类 | AgentExecution, AgentTask, CompleteTaskParam, IApprovalRecord
- `getCaption` | 22 次 | 17 个类 | AnchorItems, ComboItem, DataGridColumn, FilterColumn
- `getCategory` | 10 次 | 10 个类 | AfterQteParamInitEvent, AfterSubTaskEndEvent, AfterTaskEndEvent, BeforeSubTaskStartEvent
- `getClassName` | 10 次 | 9 个类 | CloseCallBack, CompareType, CompareTypeField, ElementType
- `getCloudId` | 11 次 | 11 个类 | AppInfo, AppParam, BeforeSaveAuditLogBizEvent, BeforeSaveAuditLogEvent
- `getCode` | 23 次 | 22 个类 | AdminGroupPermTypeEnum, AssignModEnum, BizResult, ControlResult
- `getColor` | 12 次 | 10 个类 | BadgeInfo, Color, GradientItem, Graphics
- `getColumns` | 11 次 | 11 个类 | CreateColumnEvent, CreateListOperationColumnEvent, CreateListTemplateTextColumnEvent, DatabaseMetaData
- `getComboItems` | 11 次 | 10 个类 | AnalysisField, ComboProp, ComboReportColumn, CommonFilterColumn
- `getContent` | 31 次 | 27 个类 | AbstractMessageInfo, Chunk, ContentHandler, DingdingTodoInfo
- `getContext` | 14 次 | 14 个类 | AbstractFilterGridView, BillListCDWDesignerPlugin, FilterColumn, FlatMapFunctionProxy
- `getCount` | 14 次 | 14 个类 | AbstractInitDomainDataService, BadgeInfo, CellSet, CircleConfig
- `getCreateTime` | 12 次 | 11 个类 | AttDto, AttachmentDto, DLockInfo, DataChangeType
- `getCtlTips` | 16 次 | 16 个类 | AbstractReportColumn, AdvConAp, BillListAp, ButtonAp
- `getCustomParam` | 18 次 | 17 个类 | AfterSaveAsDocumentEvent, BeforeCreateMobTableColumnsEvent, BeforeOpenDocumentListEvent, BeforeOpenSaveAsFormEvent
- `getCustomParams` | 16 次 | 16 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, AfterAddFieldContainerEvent, AfterEmbedChildPageEvent
- `getData` | 73 次 | 69 个类 | ApiResult, AppInfo, AppMenuInfo, AppStarted
- `getDataEntities` | 10 次 | 10 个类 | AbstractValidator, AddValidatorsEventArgs, AfterOperationArgs, BeforeOperationArgs
- `getDataEntity` | 17 次 | 16 个类 | AfterBindingDataEvent, AfterSaveAsDocumentEvent, BeforeOpenDocumentListEvent, BeforeOpenSaveAsFormEvent
- `getDataEntityType` | 16 次 | 15 个类 | AbstractOpParameterPlugin, ControlTypes, CustOpParameterPlugin, DataEntityType
- `getDataMap` | 10 次 | 10 个类 | AfterCreatVo, BeforeCreatVo, ContentApVo, HisDataTaskCheckEvent
- `getDataSource` | 12 次 | 11 个类 | AbstractReportModel, AfterLoadDataEvent, BaseControl, BeforeLoadDataEvent
- `getDataType` | 15 次 | 15 个类 | CalItem, ClientAjaxOption, DataBuffer, Field
- `getDate` | 23 次 | 13 个类 | CallableStatement, CircleConfig, DataPoint, DateUtils
- `getDateFormat` | 13 次 | 11 个类 | ConditionDtoExt, DateDataGridColumn, DateDataGridColumnAp, DateMobTableColumn
- `getDefValue` | 19 次 | 18 个类 | AbstractBasedataField, AdminDivisionField, BillTypeControlInfo, CheckBoxField
- `getDesc` | 23 次 | 20 个类 | AdminGroupPermTypeEnum, ArchiveInfo, AssignModEnum, DLockInfo
- `getDescription` | 35 次 | 31 个类 | AddUsrGrpReq, AdmGroup, AdminGroupReq, AgentTask
- `getDimId` | 12 次 | 12 个类 | Dim, DimFieldPerm, DimFuncPermReq, DimRoleReq
- `getDimType` | 14 次 | 14 个类 | BizRoleInfo$BizRoleOrg, Dim, DimFieldPerm, FieldControlRuleDto
- `getDirection` | 14 次 | 14 个类 | AutoMatchInfoParam, CardEntryFixRowAp, CardEntryRowAp, CardEntryViewAp
- `getDisplayFormatString` | 12 次 | 12 个类 | ColumnDesc, DateListColumn, DateListColumnAp, DateTimeEdit
- `getDisplayName` | 20 次 | 15 个类 | AbstractGrid, Calendar, Chronology, Currency
- `getDisplayProp` | 11 次 | 11 个类 | AbstractBasedataField, AbstractRefBillField, AfterBindingDataEvent, BasedataEdit
- `getDouble` | 12 次 | 7 个类 | ByteBuffer, CallableStatement, Field, IRowData
- `getEmail` | 11 次 | 11 个类 | ResponseData, UserBaseInfo, UserBusiRole, UserDrDim
- `getEmptyText` | 20 次 | 19 个类 | AbstractBasedataField, AbstractRefBillField, AdminDivisionField, CardEntryFieldAp
- `getEnable` | 14 次 | 14 个类 | AddUsrGrpReq, ArchiveDatabase, ArchiveRule, ArchiveSchedule
- `getEndDate` | 35 次 | 35 个类 | AttFileExt, AttFileQueryParamExt, AttFileScheduleEntityExt, AttFileVersion
- `getEndTime` | 18 次 | 18 个类 | ArchivePlan, ArchiveSchedule, AttBillTimeBucketExt, CollectReportDetail
- `getEntityId` | 32 次 | 31 个类 | AbstractOperate, AttachmentPanel, BillListAp, Chunk
- `getEntityKey` | 11 次 | 11 个类 | AbstractValidator, AnalysisField, CtBFRowId, FilterField
- `getEntityName` | 22 次 | 21 个类 | AgentTask, ConvertBill, CtConvertBill, Entity
- `getEntityNumber` | 71 次 | 71 个类 | AbstractFuncParamPlugIn, AbstractOpBizRuleParameterEdit, AdvFilterGrid, AfterReviseMsgEvent
- `getEntityType` | 14 次 | 14 个类 | AbstractFilterGridView, BillList, BillListGetEntityTypeListener, FilterColumn
- `getEntryEntity` | 13 次 | 12 个类 | AbstractFormDataModel, AbstractMobBillInfoPlugin, BillList, FilterColumn
- `getEntryId` | 10 次 | 10 个类 | AbstractPricingBillEntryInfo, AbstractPricingInfo, BFRowId, CtBFRowId
- `getEntryKey` | 10 次 | 10 个类 | AbstractGrid, CtBFEntryTable, CtBillEntryInfo, CtSourceBillReport
- `getErrorCode` | 10 次 | 10 个类 | ApiResult, BizResult, CountRst, CustomApiResult
- `getErrorMsg` | 10 次 | 10 个类 | ApiResponse, AssignQueryResponse, BaseDataResponse, BizResult
- `getEventId` | 12 次 | 12 个类 | BatchVersionChangeRespData, HisBatchDiscardApiBo, HisDiscardApiBo, HisEnableParamBo
- `getField` | 16 次 | 13 个类 | AfterCreatVo, BeforeOutputRowEvent, BillPageAttributeConfig, DataRowSet
- `getFieldKey` | 32 次 | 32 个类 | AbstractColumnDesc, AbstractListColumn, BasedataItem, BillTypeControlInfo
- `getFieldName` | 42 次 | 41 个类 | BeforeFilterF7SelectEvent, BillTypeControlInfo, ChangeDto, CompareTypeValue
- `getFileName` | 18 次 | 18 个类 | AdjConfirmPrintEvent, AfterExportEntryEvent, AttDto, AttachmentFieldSaveDto
- `getFilter` | 23 次 | 23 个类 | AdminDivisionField, ApiFilterPlugin, BillListAp, CommonBaseDataFilterColumn
- `getFilters` | 11 次 | 11 个类 | AddStepCustomFilterEvent, AdjDetailQueryParamEvent, BeforeQueryOfExportEvent, BuildTreeListFilterEvent
- `getFldProperties` | 13 次 | 13 个类 | AfterBizRuleEventArgs, AfterConvertEventArgs, AfterCreateLinkEventArgs, AfterCreateTargetEventArgs
- `getFont` | 10 次 | 8 个类 | AccessibleComponent, Font, FontMetrics, GlyphVector
- `getFormat` | 10 次 | 10 个类 | AmountColumnDesc, BaseControl, CodeRuleEntryInfo, FileInfo
- `getFormId` | 30 次 | 30 个类 | AICommandParameter, AbstractOperationResult, AppMenuInfo, AppParam
- `getFormula` | 10 次 | 10 个类 | CRValByCondition, Cell, CtFieldMapItem, CtWriteBackFormula
- `getGroupId` | 11 次 | 11 个类 | ArchiveDatabase, ArchiveRule, Chunk, CompareType
- `getHeight` | 24 次 | 24 个类 | BaseControl, Component, ControlAp, CustomizeLink
- `getId` | 176 次 | 173 个类 | AbstractElement, AdmGroup, AdminGroupReq, Agent
- `getIncludeSub` | 11 次 | 11 个类 | Dim, DimFieldPerm, DimFuncPermReq, DimRoleReq
- `getIndex` | 27 次 | 26 个类 | Attributes, BaseControl, BeforeCreatVo, CharacterIterator
- `getInstance` | 52 次 | 34 个类 | AlgorithmParameters, AtomicIncrement, AttFileQueryParamExt, AttItemSpecExt
- `getInt` | 14 次 | 9 个类 | ByteBuffer, CallableStatement, CommonDtxResponse, CommonParam
- `getItems` | 23 次 | 23 个类 | AnchorItems, AttachmentPanelMapPolicy, BillTypeMapPolicy, CRValByConditions
- `getKey` | 61 次 | 56 个类 | AbstractColumnDesc, AbstractElement, AbstractGrid$GridState, AccessibleRelation
- `getLocation` | 14 次 | 12 个类 | AccessibleComponent, CodeSource, Component, DragSourceEvent
- `getLong` | 22 次 | 14 个类 | ByteBuffer, CallableStatement, CommonDtxResponse, CommonParam
- `getMainEntityType` | 10 次 | 10 个类 | AbstractFormDataModel, BasedataEdit, BeforeExportFileEvent, CustomBaseDataSchemeFilterColumn
- `getMask` | 11 次 | 11 个类 | ColumnDesc, DateListColumn, DateListColumnAp, DateTimeEdit
- `getMessage` | 44 次 | 39 个类 | AbstractReportListDataPlugin, AfterExcessCheckEventArgs, ApiResult, BComputeResultParam
- `getModel` | 17 次 | 14 个类 | AbstractFormPlugin, AdminGroupPermSubBO, CardBindDataDTO, Control
- `getModelType` | 16 次 | 16 个类 | BasedataFormAp, BillFormAp, CardAp, DynamicFormInfo
- `getMsg` | 11 次 | 11 个类 | BatchResult, BeforeAttachmentRemoveEvent, BeforeAttachmentUploadEvent, EpmResult
- `getName` | 176 次 | 173 个类 | AbstractElement, AdmGroup, AdminGroupReq, Agent
- `getNumber` | 68 次 | 67 个类 | AdmGroup, AdminGroupReq, Agent, AppInfo
- `getObject` | 16 次 | 5 个类 | CallableStatement, FieldRuleArgs, Ref, ReportRowSet
- `getOffset` | 11 次 | 9 个类 | BadgeInfo, ChronoZonedDateTime, DataBuffer, GradientItem
- `getOperation` | 18 次 | 18 个类 | BaseDataBeforeInvokeApiArgs, BillView, EntityEvent, EntityMetadata
- `getOperationKey` | 19 次 | 19 个类 | Button, ButtonAp, Container, DropdownItem
- `getOption` | 14 次 | 14 个类 | AbstractOperate, AbstractValidator, EntityOperateService, IConvertPlugIn
- `getOrgId` | 27 次 | 27 个类 | AppParam, AttFileExt, BaseDataUseRelBit, BaseSettleParam
- `getPageId` | 25 次 | 23 个类 | AbstractFormDataModel, AbstractOperate, AbstractReportModel, CloseCallBackWraper
- `getParam` | 19 次 | 19 个类 | AfterExecAttendanceEvent, AfterExecBusinessTripEvent, AfterExecExEvent, AfterExecOvertimeEvent
- `getParameter` | 15 次 | 15 个类 | AICommand, AICommandParameter, AbstractOperate, BeforeShowBillFormEvent
- `getParams` | 23 次 | 23 个类 | AfterSyncPersonCopyEvent, AppMenuInfo, BeforeSalaryAdjSyncDeleteEvent, CommDataDto
- `getParent` | 22 次 | 21 个类 | AdmGroup, AdminGroupReq, BusiRoleGroup, ClassLoader
- `getPath` | 10 次 | 10 个类 | AttDto, Cookie, File, FileItem
- `getPersonId` | 16 次 | 16 个类 | AttFileVersion, AttStateExt, CoordinationExpandParam, CoreCoordinationParam
- `getPhone` | 12 次 | 12 个类 | ResponseData, ShortMessageInfo, UserBaseInfo, UserBusiRole
- `getPkId` | 23 次 | 23 个类 | AssistantFlexEdit, BasedataEdit, BasedataFlexEdit, BeforeDoCheckDataPermissionArgs
- `getPlugins` | 11 次 | 11 个类 | BillEntity, CtPlugInPolicy, FormAp, FormConfig
- `getPosition` | 12 次 | 12 个类 | AttFileVersion, Axis, BeforeOpenSaveAsFormEvent, EmpJobRelExt
- `getPrecision` | 11 次 | 11 个类 | BigDecimalType, DecimalProp, DrawFormFieldDto, IDBField
- `getProcessInstanceId` | 12 次 | 12 个类 | AgentExecution, AgentTask, BizProcessStatus, Comment
- `getProperty` | 24 次 | 23 个类 | BeforeF7PrepareUserOrgsEvent, BeforeF7SelectEvent, BeforeSetItemValueEventArgs, ConditionEntryInfo
- `getQFilter` | 12 次 | 12 个类 | AbstractFilterContantParser, BasedataEdit, ConditionVariableContext, FilterBuilder
- `getQFilters` | 18 次 | 18 个类 | AfterBuildQueryParemeterEventArgs, BasedataEdit, BeforeGetSourceDataEventArgs, BeforeSetItemValueEventArgs
- `getResult` | 30 次 | 30 个类 | AICommandEvent, AfterParseMsgContentEvent, AfterSaveReceiveMsgEvent, BaseDataResponse
- `getRow` | 17 次 | 16 个类 | BeforeBatchFillEntryArgs$RowItem, BeforeF7PrepareUserOrgsEvent, BeforeF7SelectEvent, BeforeShowAttachmentsArgs
- `getRowCount` | 16 次 | 16 个类 | AfterMoveEntryEventArgs, AfterTogetherMoveEntryRowEventArgs, CachedDataSet, CtSourceBillReport
- `getRowIndex` | 25 次 | 24 个类 | AbstractPWGridCell, AdjSalSynTmplSetEvent, BeforeFieldPostBackEvent, BindingContext
- `getRule` | 20 次 | 20 个类 | AdoptionRule, AfterCalcWriteValueEventArgs, AfterCloseRowEventArgs, AfterCommitAmountEventArgs
- `getRuleId` | 12 次 | 12 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, ConvertOpRule, CtConvertOpRule
- `getScale` | 15 次 | 15 个类 | BigDecimalType, DecimalDataGridColumn, DecimalDataGridColumnAp, DecimalField
- `getSelectedRows` | 11 次 | 11 个类 | AbstractGrid$GridState, AbstractListPlugin, AfterOperationArgs, BeforeBuildRowConditionEventArgs
- `getSeq` | 38 次 | 38 个类 | AbstractValidator, AppInfo, AppMenuInfo, AttachmentPanelMapItem
- `getSize` | 15 次 | 14 个类 | AccessibleComponent, AttDto, AttachmentDto, Component
- `getSource` | 24 次 | 24 个类 | EmbedFormShowParamItem, EventObject, FieldRuleArgs, IApprovalRecordItem
- `getSourceEntityNumber` | 13 次 | 13 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, ConvertBill, ConvertOperationResult
- `getSrcActiveRow` | 10 次 | 10 个类 | AfterCloseRowEventArgs, AfterCommitAmountEventArgs, AfterExcessCheckEventArgs, BeforeCloseRowEventArgs
- `getSrcEntity` | 10 次 | 10 个类 | AfterCloseRowEventArgs, AfterCommitAmountEventArgs, AfterExcessCheckEventArgs, BeforeCloseRowEventArgs
- `getSrcSubMainType` | 16 次 | 16 个类 | AfterCloseRowEventArgs, AfterCommitAmountEventArgs, AfterExcessCheckEventArgs, AfterReadSourceBillEventArgs
- `getStartDate` | 34 次 | 34 个类 | AttFileExt, AttFileQueryParamExt, AttFileScheduleEntityExt, AttFileVersion
- `getStartTime` | 23 次 | 23 个类 | ArchivePlan, AttBillTimeBucketExt, CollectReportDetail, ConvertOperationResult
- `getState` | 12 次 | 12 个类 | AbstractGrid$GridState, Frame, IApprovalRecordItem, InputMethodHighlight
- `getStatus` | 22 次 | 22 个类 | AbstractFormView, ArchiveRule, ArchiveSchedule, BComputeResultParam
- `getString` | 23 次 | 13 个类 | CallableStatement, CommonDtxResponse, CommonParam, DynamicObject
- `getStyle` | 14 次 | 14 个类 | AbstractStyle, AfterCreatVo, BaseControl, ControlAp
- `getSummary` | 11 次 | 11 个类 | AmountMobTableColumn, AmountMobTableColumnAp, DecimalEdit, DecimalListColumn
- `getTargetActiveRow` | 10 次 | 10 个类 | AfterCloseRowEventArgs, AfterCommitAmountEventArgs, AfterExcessCheckEventArgs, BeforeCloseRowEventArgs
- `getTargetEntity` | 12 次 | 12 个类 | AfterCloseRowEventArgs, AfterCommitAmountEventArgs, AfterExcessCheckEventArgs, BeforeCloseRowEventArgs
- `getTargetEntityNumber` | 11 次 | 11 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, ConvertOperationResult, ConvertPath
- `getTargetExtDataEntitySet` | 11 次 | 11 个类 | AfterBizRuleEventArgs, AfterConvertEventArgs, AfterCreateLinkEventArgs, AfterCreateTargetEventArgs
- `getTaskId` | 43 次 | 43 个类 | AICommand, AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, AbstractTaskClick
- `getTenantId` | 10 次 | 10 个类 | CommDataDto, CtBFEntryTable, CtBFRowId, CtBFTable
- `getText` | 21 次 | 21 个类 | CodeEdit, CustomizeLink, InputMethodEvent, KingScriptEdit
- `getTime` | 14 次 | 8 个类 | Calendar, CallableStatement, HistoricData, IApprovalRecord
- `getTimestamp` | 17 次 | 9 个类 | CallableStatement, CodeSigner, CommonSecurityDto, IRowData
- `getTimeZone` | 10 次 | 9 个类 | AttFileExt, Calendar, DateFormat, DateTimeEdit
- `getTitle` | 31 次 | 28 个类 | AbstractMessageInfo, CardInfo, ChartData, Chunk
- `getTrueName` | 10 次 | 10 个类 | PermUser, UserBusiRole, UserDrDim, UserDrPrDim
- `getType` | 98 次 | 94 个类 | AbstractOperate, AffineTransform, Agent, AnnotatedType
- `getUserId` | 39 次 | 39 个类 | CheckPermissionReq, CheckUserBizAppReq, Comment, CompleteTaskParam
- `getUserName` | 15 次 | 15 个类 | DatabaseMetaData, IOlapConnection, PermUser, RequestContext
- `getUserNumber` | 10 次 | 10 个类 | PermUser, UserBusiRole, UserDrDim, UserDrPrDim
- `getValue` | 142 次 | 135 个类 | AbstractColumnDesc, ApproveOverViewDealEvent, ArchiveConfigConnectionTypeEnum, ArchiveConfigFilterTypeEnum
- `getValues` | 16 次 | 16 个类 | Axis, Capture, ComboSearchValue, EntryGridSetRowDataEvent
- `getVersion` | 27 次 | 25 个类 | AfterCleanHisDataEvent, AfterTieTaskEndEvent, ApiSerializerPlugin, AttDataPushReq
- `getView` | 38 次 | 36 个类 | AbstractFormPlugin, AbstractOperate, AbstractOperateWebApi, AbstractReportModel
- `getViewClass` | 11 次 | 11 个类 | CtsyBillShowParameter, CtsyFormShowParameter, CtsyListShowParameter, CtsyMobileBillShowParameter
- `getVisible` | 14 次 | 14 个类 | AbstractFilterGridView, BillTypeControlInfo, ControlAp, DataGridColumn
- `getWidth` | 28 次 | 28 个类 | BaseControl, Component, ControlAp, CustomizeLink
- `gt` | 12 次 | 2 个类 | EasyMock, HRDefineFunction

### H

- `hashCode` | 15 次 | 14 个类 | Annotation, ArrayUtils, ChronoLocalDate, ChronoLocalDateTime

### I

- `indexOf` | 28 次 | 5 个类 | ArrayUtils, List, StringUtils, Vector
- `init` | 20 次 | 9 个类 | AlgorithmParameters, ApiResult, ChgLogEntryDto, Cipher
- `insert` | 12 次 | 3 个类 | LogORM, Menu, __AbstractStringBuilder
- `isCancel` | 55 次 | 55 个类 | AddStepCustomParamEvent, BeforeAttachmentRemoveEvent, BeforeAttachmentUploadEvent, BeforeChangeMainOrgEventArgs
- `isEmpty` | 28 次 | 18 个类 | ArrayUtils, BitSet, Collection, CollectionUtils
- `isEnabled` | 18 次 | 17 个类 | AccessibleComponent, BizRule, CRBizRuleElement, CRCondition
- `isEqual` | 17 次 | 10 个类 | AttributeSet, ChronoLocalDate, ChronoLocalDateTime, ChronoZonedDateTime
- `isMulti` | 10 次 | 10 个类 | BeforeFilterF7SelectEvent, BillListAp, CommonFilterColumn, CommonFilterColumnAp
- `isMustInput` | 14 次 | 14 个类 | AbstractMobF7Plugin, BasedataProp, BillTypeControlInfo, CommonFilterColumn
- `isNoDisplayScaleZero` | 11 次 | 11 个类 | AmountDataGridColumn, AmountDataGridColumnAp, AmountMobTableColumn, AmountMobTableColumnAp
- `isNotEmpty` | 14 次 | 4 个类 | ArrayUtils, CollectionUtils, FlexEntireData$FlexData, StringUtils
- `isShowTitle` | 11 次 | 11 个类 | AttachmentPanelAp, Chart, ChartAp, FieldAp
- `isSuccess` | 41 次 | 39 个类 | AssignQueryResponse, AttacheHandlerService, AuditElementParseResponse, BaseDataResponse
- `isValid` | 11 次 | 10 个类 | BillTypeMapItem, Component, Connection, CtBillTypeMapItem
- `isVisible` | 12 次 | 12 个类 | AccessibleComponent, AppInfo, BillTypeControlInfo, CompareType
- `isWrap` | 12 次 | 12 个类 | CardEntryFixRowAp, CardEntryRowAp, CardEntryViewAp, CardRowPanelAp
- `isZeroShow` | 15 次 | 15 个类 | AmountDataGridColumn, AmountDataGridColumnAp, AmountMobTableColumn, AmountMobTableColumnAp
- `itemClick` | 10 次 | 10 个类 | BizCustomList, Button, CommonFunctionControl, FloatMenu

### J

- `join` | 32 次 | 5 个类 | DataSet, DataSetX, JoinFunction, QFilter

### L

- `lastIndexOf` | 28 次 | 5 个类 | ArrayUtils, List, StringUtils, Vector
- `load` | 13 次 | 8 个类 | BusinessDataServiceHelper, HSPMBusinessDataServiceHelper, IFilterModel, MappedByteBuffer
- `loadSingle` | 11 次 | 3 个类 | BusinessDataServiceHelper, HRBaseServiceHelper, ServiceLoader
- `loadTableDefine` | 10 次 | 5 个类 | ConvertDataService, ConvertMetaServiceHelper, CtConvertMetaServiceHelper, EntityMetadataCache
- `lt` | 12 次 | 2 个类 | EasyMock, HRDefineFunction

### M

- `map` | 11 次 | 10 个类 | DataSet, DataSetX, DoubleStream, FileChannel
- `max` | 14 次 | 11 个类 | BigDecimal, BigInteger, DataSetX, DoubleStream
- `min` | 13 次 | 10 个类 | BigDecimal, BigInteger, DataSetX, DoubleStream
- `mock` | 17 次 | 4 个类 | EasyMock, EasyMockSupport, IMockBuilder, IMocksControl

### N

- `name` | 12 次 | 12 个类 | ApiHeader, AttributeView, Charset, CollectionPropertyAttribute
- `not` | 10 次 | 2 个类 | BigInteger, EasyMock
- `now` | 22 次 | 9 个类 | Instant, KDDateUtils, LocalDate, LocalDateTime
- `nullToEmpty` | 19 次 | 1 个类 | ArrayUtils

### O

- `of` | 55 次 | 27 个类 | Chronology, Collector, DecimalStyle, DoubleStream
- `open` | 11 次 | 5 个类 | AsynchronousFileChannel, CustomizedOutput, FileChannel, WebOffice
- `or` | 20 次 | 10 个类 | BigInteger, BitSet, DoublePredicate, EasyMock

### P

- `parse` | 33 次 | 20 个类 | CronStruct, DateFormat, DateTimeColumnDesc, DateTimeFormatter
- `parseDate` | 14 次 | 6 个类 | DateTimeUtils, DateUtils, HRDateTimeUtils, HRDefineFunction
- `plus` | 11 次 | 6 个类 | BigDecimal, ChronoPeriod, Duration, HRDefineFunction
- `position` | 10 次 | 6 个类 | ApiParam, Blob, Buffer, Clob
- `print` | 20 次 | 7 个类 | Component, ComponentPeer, DataSet, IListView
- `println` | 19 次 | 3 个类 | PrintStream, PrintWriter, ServletOutputStream
- `put` | 56 次 | 24 个类 | AbstractGrid$GridState, ByteBuffer, CharBuffer, CommonDtxResponse

### Q

- `query` | 25 次 | 12 个类 | AbstractBillWebApiPlugin, AbstractReportTreeDataPlugin, HRBaseServiceHelper, IAccBalReportQuery
- `queryOne` | 13 次 | 2 个类 | HRBaseServiceHelper, QueryServiceHelper
- `queryOriginalOne` | 13 次 | 2 个类 | HRBaseServiceHelper, HisCommonEntityRepository

### R

- `read` | 17 次 | 9 个类 | AsynchronousFileChannel, ExcelReader, FileChannel, InputStream
- `reduce` | 15 次 | 10 个类 | ConcurrentHashMap, DoubleStream, GroupCombineReduceFunction, GroupReduceFunction
- `register` | 28 次 | 10 个类 | ControlTypes, DTXHandle, ECGlobalSession, ECSession
- `registerOutParameter` | 12 次 | 1 个类 | CallableStatement
- `release` | 15 次 | 14 个类 | ConvertOperationResult, CtConvertOperationResult, DataMutex, EntityOperateService
- `remove` | 43 次 | 30 个类 | AccessibleRelationSet, AccessibleStateSet, ArrayUtils, AttachmentServiceHelper
- `removeElement` | 10 次 | 2 个类 | ArrayUtils, Vector
- `replace` | 10 次 | 5 个类 | FunDef, ImmutablePropertyBag, Map, StringUtils
- `reset` | 17 次 | 16 个类 | Buffer, ByteArrayOutputStream, Calls, Capture
- `reverse` | 22 次 | 5 个类 | ArrayUtils, Long, NotLikeHint, StringUtils

### S

- `save` | 33 次 | 17 个类 | AppMetaServiceHelper, AppWriter, BatchImportPlugin, CtConvertMetaServiceHelper
- `search` | 16 次 | 9 个类 | ConcurrentHashMap, HRSmartSearchService, ListColumnCompareService, MobFilterSort
- `select` | 12 次 | 9 个类 | DataSet, DataSetX, JoinDataSet, JoinDataSetX
- `set` | 38 次 | 26 个类 | AtomicReference, BitSet, Calendar, CellSet
- `setAccountId` | 14 次 | 14 个类 | CommDataDto, CtBFEntryTable, CtBFRowId, CtBFTable
- `setAppId` | 38 次 | 38 个类 | AICommand, AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, App
- `setAttFileBoId` | 11 次 | 11 个类 | AdPlanRuleQuery, MultiCardExt, OffShiftTakeCardRangeEvent, OnMatchBillDutyDateEvent
- `setAttribute` | 10 次 | 9 个类 | Element, FileSystemProvider, HttpSession, QrCodeResult
- `setBaseEntityId` | 11 次 | 11 个类 | AbstractBasedataField, BasedataProp, CommonBaseDataFilterColumnAp, CustomBaseDataFilterColumn
- `setBillId` | 16 次 | 16 个类 | BFRowId, CreditPointDTO, CtBFRowId, CtSourceBillReport
- `setBillNo` | 21 次 | 21 个类 | BillEntityType, CreditPointDTO, CtExtendedDataEntity, CtSourceBillReport
- `setBusinessKey` | 10 次 | 10 个类 | CompleteTaskParam, IApprovalRecord, IApprovalRecordItem, IPreComputorRecord
- `setCancel` | 64 次 | 64 个类 | AddStepCustomParamEvent, BeforeAttachmentRemoveEvent, BeforeAttachmentUploadEvent, BeforeChangeMainOrgEventArgs
- `setCaption` | 19 次 | 18 个类 | AbstractReportColumn, AnchorItems, ComboItem, DataGridColumn
- `setCode` | 13 次 | 12 个类 | BizResult, DecimalField, EpmResult, HisResponse
- `setColor` | 11 次 | 11 个类 | BadgeInfo, BarSeries, GradientItem, Graphics
- `setContent` | 20 次 | 19 个类 | AbstractMessageInfo, Chunk, DingdingTodoInfo, EmailInfo
- `setContext` | 14 次 | 14 个类 | BeforeExecWriteBackRuleEventArgs, CtBeforeExecWriteBackRuleEventArgs, FilterColumn, IConvertPlugIn
- `setCtlTips` | 16 次 | 16 个类 | AbstractReportColumn, AdvConAp, BillListAp, ButtonAp
- `setCustomParam` | 14 次 | 13 个类 | AfterSaveAsDocumentEvent, BeforeOpenDocumentListEvent, BeforeOpenSaveAsFormEvent, BeforeReplaceVariableEvent
- `setCustomParams` | 12 次 | 12 个类 | AfterAddFieldContainerEvent, AfterEmbedChildPageEvent, BeforeCreateMobTableColumnsEvent, BeforeFilterF7SelectEvent
- `setData` | 64 次 | 62 个类 | ApiResult, AppInfo, AppMenuInfo, AppStarted
- `setDataType` | 11 次 | 11 个类 | CalItem, ClientAjaxOption, Field, FilterObject
- `setDefValue` | 18 次 | 17 个类 | AbstractBasedataField, AdminDivisionField, BasedataProp, BillTypeControlInfo
- `setDesc` | 10 次 | 10 个类 | ArchiveInfo, DataRole, FieldPermScheme, FieldPermSchemeDetail
- `setDescription` | 34 次 | 31 个类 | AddUsrGrpReq, AdmGroup, AdminGroupReq, AppInfo
- `setDimId` | 12 次 | 12 个类 | Dim, DimFieldPerm, DimFuncPermReq, DimRoleReq
- `setDimType` | 13 次 | 13 个类 | BizRoleInfo$BizRoleOrg, Dim, DimFieldPerm, FieldControlRuleDto
- `setDirection` | 14 次 | 14 个类 | AutoMatchInfoParam, CardEntryFixRowAp, CardEntryRowAp, CardEntryViewAp
- `setDisplayFormatString` | 12 次 | 12 个类 | ColumnDesc, DateListColumn, DateListColumnAp, DateTimeEdit
- `setDisplayProp` | 13 次 | 13 个类 | AbstractBasedataField, AbstractRefBillField, AfterBindingDataEvent, BasedataEdit
- `setDynamicProperty` | 37 次 | 36 个类 | AddressField, AdminDivisionField, AmountField, AssistantField
- `setEmail` | 11 次 | 11 个类 | ResponseData, UserBaseInfo, UserBusiRole, UserDrDim
- `setEmptyText` | 20 次 | 19 个类 | AbstractBasedataField, AbstractRefBillField, AdminDivisionField, CardEntryFieldAp
- `setEnable` | 27 次 | 26 个类 | AddUsrGrpReq, ArchiveDatabase, ArchiveRule, ArchiveSchedule
- `setEnabled` | 20 次 | 19 个类 | AccessibleComponent, BizRule, CRBizRuleElement, CRCondition
- `setEndDate` | 20 次 | 20 个类 | AttFileQueryParamExt, AttFileVersion, AttStatisticAdminOrgParam, CardMatchTaskParam
- `setEndTime` | 12 次 | 12 个类 | ArchiveSchedule, CollectReportDetail, DimRoleReq, PlanInfo
- `setEntityId` | 29 次 | 27 个类 | AbstractOperate, BillListAp, Chunk, DesignFormMeta
- `setEntityName` | 18 次 | 17 个类 | ConvertBill, CtConvertBill, Entity, EntityExcelModel
- `setEntityNumber` | 57 次 | 57 个类 | AdvFilterGrid, AfterReviseMsgEvent, AggregateResult, AppMenuInfo
- `setEventId` | 12 次 | 12 个类 | BatchVersionChangeRespData, HisBatchDiscardApiBo, HisDiscardApiBo, HisEnableParamBo
- `setFieldKey` | 18 次 | 18 个类 | BasedataItem, BillTypeControlInfo, CellStyle, CellStyleRule
- `setFieldName` | 23 次 | 23 个类 | BillTypeControlInfo, ChangeDto, CompareTypeValue, DependField
- `setFileName` | 13 次 | 13 个类 | AdjConfirmPrintEvent, AfterExportEntryEvent, AttDto, BeforeExportFileEvent
- `setFilter` | 23 次 | 23 个类 | AbstractBasedataField, AbstractRefBillField, AdminDivisionField, BillList
- `setFontSize` | 10 次 | 10 个类 | BaseControl, ColumnStyle, ControlAp, DataGridColumn
- `setForeColor` | 10 次 | 10 个类 | BaseControl, CellStyleRule, ColumnStyle, ControlAp
- `setFormId` | 23 次 | 23 个类 | AICommandParameter, AbstractOperationResult, AppMenuInfo, AppParam
- `setGroupId` | 10 次 | 10 个类 | ArchiveDatabase, ArchiveRule, Chunk, CompareType
- `setHeight` | 10 次 | 10 个类 | BaseControl, ControlAp, CustomizeLink, DrawFormFieldDto
- `setId` | 143 次 | 140 个类 | AbstractElement, AdmGroup, AdminGroupReq, Agent
- `setIncludeSub` | 12 次 | 12 个类 | BizRoleInfo$BizRoleOrg, Dim, DimFieldPerm, DimFuncPermReq
- `setIndex` | 23 次 | 23 个类 | BaseControl, BeforeCreatVo, CharacterIterator, CircleRest
- `setItems` | 14 次 | 14 个类 | AnchorItems, AttachmentPanelMapPolicy, ComboField, CtAttachmentPanelMapPolicy
- `setKey` | 35 次 | 31 个类 | AbstractColumnDesc, AbstractElement, ArchiveInfo, BasLoginConfigParam
- `setLocation` | 11 次 | 7 个类 | AccessibleComponent, CityEdit, Component, Point
- `setLock` | 11 次 | 9 个类 | BillTypeControlInfo, Control, ControlAp, DrawFormFieldDto
- `setMask` | 11 次 | 11 个类 | ColumnDesc, DateListColumn, DateListColumnAp, DateTimeEdit
- `setMessage` | 37 次 | 35 个类 | AbstractReportListDataPlugin, AfterExcessCheckEventArgs, ApiResult, BComputeResultParam
- `setMsg` | 10 次 | 10 个类 | BatchResult, BeforeAttachmentRemoveEvent, BeforeAttachmentUploadEvent, EpmResult
- `setMulti` | 10 次 | 10 个类 | BillListAp, CommonFilterColumn, CommonFilterColumnAp, CompareType
- `setMustInput` | 17 次 | 17 个类 | AbstractGrid, BasedataProp, BillTypeControlInfo, CommonFilterColumn
- `setName` | 117 次 | 115 个类 | AbstractElement, AdmGroup, AdminGroupReq, Agent
- `setNoDisplayScaleZero` | 11 次 | 11 个类 | AmountDataGridColumn, AmountDataGridColumnAp, AmountMobTableColumn, AmountMobTableColumnAp
- `setNumber` | 55 次 | 55 个类 | AdmGroup, AdminGroupReq, Agent, AppInfo
- `setObject` | 12 次 | 4 个类 | CallableStatement, FieldRuleArgs, PreparedStatement, Ref
- `setOperation` | 14 次 | 14 个类 | BaseDataBeforeInvokeApiArgs, EntityEvent, MessageInfo, MessageInfoModel
- `setOperationKey` | 18 次 | 18 个类 | Button, ButtonAp, Container, DropdownItem
- `setOrgId` | 19 次 | 19 个类 | AppParam, BaseDataUseRelBit, BaseSettleParam, BasedataItem
- `setPageId` | 19 次 | 17 个类 | AbstractOperate, AbstractReportModel, CloseCallBackWraper, DragRowGridToGridEventArgs$FromDragRowInfo
- `setParam` | 11 次 | 10 个类 | AfterReviseMsgEvent, ConditionVariableContext, CustomMessageParamBo, F7SelectedListRemoveEvent
- `setParameter` | 10 次 | 10 个类 | AICommand, AICommandParameter, AbstractOperate, CustOperationParameter
- `setParams` | 17 次 | 17 个类 | AfterSyncPersonCopyEvent, AppMenuInfo, BeforeSalaryAdjSyncDeleteEvent, CommDataDto
- `setPersonId` | 11 次 | 11 个类 | AttFileVersion, CoordinationExpandParam, EntryCoordinationParam, MobileBillListDto
- `setPhone` | 12 次 | 12 个类 | ResponseData, ShortMessageInfo, UserBaseInfo, UserBusiRole
- `setPkId` | 11 次 | 11 个类 | BeforeDoCheckDataPermissionArgs, BeforeF7ViewDetailEvent, BillShowParameter, BillTypeInfo
- `setPosition` | 10 次 | 10 个类 | AttFileVersion, Axis, BeforeOpenSaveAsFormEvent, Label
- `setProperty` | 15 次 | 15 个类 | ActionBuilder, ActionListBuilder, AssistantFlexEdit, BasedataFlexEdit
- `setResult` | 24 次 | 24 个类 | AICommandEvent, AfterParseMsgContentEvent, AfterSaveReceiveMsgEvent, BaseDataResponse
- `setRowIndex` | 16 次 | 15 个类 | AbstractPWGridCell, AdjSalSynTmplSetEvent, CellTipsClickEvent, CtExtendedDataEntity
- `setRuleId` | 11 次 | 11 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, ConvertOpRule, CtConvertOpRule
- `setRuntimeSimpleProperties` | 69 次 | 69 个类 | AmountDataGridColumnAp, AmountMobTableColumnAp, ApproverListColumnAp, BillListAp
- `setScale` | 15 次 | 12 个类 | BigDecimal, DecimalDataGridColumn, DecimalDataGridColumnAp, DecimalField
- `setSeq` | 36 次 | 36 个类 | AbstractValidator, AppInfo, AppMenuInfo, AttachmentPanelMapItem
- `setServerEditorProperties` | 14 次 | 13 个类 | AssistantField, BasedataField, BasedataPropField, BillStatusField
- `setShowTitle` | 11 次 | 11 个类 | AttachmentPanelAp, Chart, ChartAp, FieldAp
- `setSize` | 15 次 | 11 个类 | AccessibleComponent, AttDto, AttachmentDto, Component
- `setSource` | 17 次 | 17 个类 | AWTEvent, EmbedFormShowParamItem, FieldRuleArgs, IApprovalRecordItem
- `setSourceEntityNumber` | 13 次 | 13 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, ConvertBill, ConvertOperationResult
- `setStartDate` | 18 次 | 18 个类 | AttFileQueryParamExt, AttFileVersion, AttStatisticAdminOrgParam, CardMatchTaskParam
- `setStartTime` | 17 次 | 17 个类 | CollectReportDetail, ConvertOperationResult, CtConvertOperationResult, CtSaveOperationResult
- `setState` | 11 次 | 11 个类 | AbstractGrid$GridState, FilterGrid$FilterGridState, Frame, IApprovalRecordItem
- `setStatus` | 26 次 | 25 个类 | ArchiveRule, ArchiveSchedule, BComputeResultParam, CollectReportDetail
- `setStyle` | 14 次 | 14 个类 | AfterCreatVo, AfterOutputWidgetEvent, BaseControl, BeforeOutputWidgetEvent
- `setSuccess` | 39 次 | 37 个类 | AbstractOperationResult, ApiResult, AssignQueryResponse, AuditElementParseResponse
- `setSummary` | 11 次 | 11 个类 | AmountMobTableColumn, AmountMobTableColumnAp, DecimalEdit, DecimalListColumn
- `setTargetEntityNumber` | 11 次 | 11 个类 | AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, ConvertOperationResult, ConvertPath
- `setTargetExtDataEntitySet` | 11 次 | 11 个类 | AfterBizRuleEventArgs, AfterConvertEventArgs, AfterCreateLinkEventArgs, AfterCreateTargetEventArgs
- `setTaskId` | 30 次 | 30 个类 | AICommand, AbstractConvertServiceArgs, AbstractCtConvertServiceArgs, AfterSalaryCalEvent
- `setText` | 22 次 | 22 个类 | CodeEdit, CustomizeLink, FieldEdit, KingScriptEdit
- `setTimeout` | 10 次 | 8 个类 | AsyncContext, CacheConfigInfo, CacheHint, JobFormInfo
- `setTitle` | 31 次 | 28 个类 | AbstractMessageInfo, CardInfo, Chunk, DingdingTodoInfo
- `setTrueName` | 10 次 | 10 个类 | PermUser, UserBusiRole, UserDrDim, UserDrPrDim
- `setType` | 64 次 | 63 个类 | AbstractOperate, Agent, AppInfo, ApproveOverViewDealEvent
- `setUrl` | 13 次 | 13 个类 | BatchDownloadRequest$File, Button, ClientAjaxOption, CommDataDto
- `setUserId` | 37 次 | 37 个类 | CheckPermissionReq, CheckUserBizAppReq, Comment, CompleteTaskParam
- `setUserName` | 14 次 | 14 个类 | IOlapConnection, PermUser, RequestContext, UserBaseInfo
- `setUserNumber` | 10 次 | 10 个类 | PermUser, UserBusiRole, UserDrDim, UserDrPrDim
- `setValue` | 64 次 | 59 个类 | AdvFilterGrid, ApproveOverViewDealEvent, AsyncStatusEnum, Attr
- `setVersion` | 15 次 | 15 个类 | AttDataPushReq, AttDataWithDrawReq, CandContrastPropLoadEvent, ContrastPropLoadEvent
- `setView` | 30 次 | 27 个类 | AbstractOperate, AbstractReportModel, ActiveViewEvent, AdminGroupPermSubBO
- `setVisible` | 25 次 | 25 个类 | AccessibleComponent, AppInfo, BillTypeControlInfo, CompareType
- `setWidth` | 16 次 | 16 个类 | BaseControl, ControlAp, CustomizeLink, DataGridColumn
- `setWrap` | 12 次 | 12 个类 | CardEntryFixRowAp, CardEntryRowAp, CardEntryViewAp, CardRowPanelAp
- `setZeroShow` | 15 次 | 15 个类 | AmountDataGridColumn, AmountDataGridColumnAp, AmountMobTableColumn, AmountMobTableColumnAp
- `show` | 10 次 | 5 个类 | BufferStrategy, EmbeddedControlService, FuncSettingHelper, HRDataBaseEdit
- `showConfirm` | 12 次 | 2 个类 | AbstractFormView, IFormView
- `size` | 18 次 | 18 个类 | AccessibleRelationSet, AsynchronousFileChannel, BasicFileAttributes, BitSet
- `start` | 12 次 | 11 个类 | AppStarter, AsyncContext, CountDown, LittleK
- `success` | 22 次 | 11 个类 | ApiResponse, ApiResult, CustomApiResult, EpmResult
- `sum` | 10 次 | 7 个类 | DataSetX, DoubleStream, GroupbyDataSet, Grouper

### T

- `toArray` | 15 次 | 12 个类 | AccessibleRelationSet, AccessibleStateSet, ArrayUtils, Collection
- `toMap` | 25 次 | 20 个类 | ApiOperateOption, ApiResult, ArrayUtils, ImportEntity
- `toPrimitive` | 16 次 | 1 个类 | ArrayUtils
- `toString` | 23 次 | 20 个类 | Annotation, BigInteger, ByteArrayOutputStream, CharSequence
- `Try` | 12 次 | 3 个类 | TCCAdapterService, TCCGlobalSession, TCCSession

### U

- `update` | 21 次 | 12 个类 | Cipher, Component, HRBaseServiceHelper, IBasLoginConfigService
- `upload` | 12 次 | 10 个类 | AttachmentAction, AttachmentServiceHelper, Button, FileService

### V

- `validate` | 16 次 | 14 个类 | AbstractValidator, Component, EntityOperateService, HRPIPersonGenericServiceHelper
- `value` | 17 次 | 17 个类 | ApiContent, ApiContents, ApiController, ApiErrorCodes
- `valueOf` | 193 次 | 164 个类 | AdminGroupPermTypeEnum, AdminType, Agent$Type, AnimationType
- `values` | 159 次 | 157 个类 | AbstractRow, AdminGroupPermTypeEnum, AdminType, Agent$Type

### W

- `wrap` | 21 次 | 10 个类 | AlgoException, ByteBuffer, CharBuffer, Cipher
- `write` | 19 次 | 9 个类 | AsynchronousFileChannel, CustomizedOutput, DataOutput, FileChannel
