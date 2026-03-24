# SDK 包索引

本文件基于本地 TypeScript 定义自动生成，用于按模块和包定位能力边界。

- 生成时间：2026-03-24 10:59:15
- 包数：514

## @constellation/epm

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/epm/bgmd` | 5 | AbstractBgmdFormPlugin、BgControlSettingTypeNumbers、FacTabFieldDefFields、IBgmdFormPlugin、SdkClassUtils |
| `kd/sdk/epm/bgmd/enums/formplugin` | 2 | ReturnAndCloseEnum、SysDimensionEnum |
| `kd/sdk/epm/bgmd/formplugin` | 7 | AbstractCusPermPlugin、IAdjustMobExtService、IDataIntegrateDataDealService、ISubTaskExtFiledSaveService、ITaskPackageExtFiledSaveService |
| `kd/sdk/epm/bgmd/util` | 9 | AbstractUtils、BusinessModelUtils、CubeUtils、DatasetUtils、DimensionUtils |
| `kd/sdk/epm/bgmd/util/f7` | 2 | IF7、IF8 |
| `kd/sdk/epm/business` | 1 | EbOlapServiceHelper |
| `kd/sdk/epm/cm/extplugin` | 2 | DefaultMergeControlServiceExtPlugin、IMergeControlServiceExtPlugin |
| `kd/sdk/epm/common` | 5 | Convert、LogStats、MemberServiceHelper、QFBuilder、StringUtils |
| `kd/sdk/epm/control` | 1 | ControlResultEnum |
| `kd/sdk/epm/control/impl` | 1 | ControlResult |
| `kd/sdk/epm/ebBusiness/sql` | 1 | DateTimeUtils |
| `kd/sdk/epm/emr` | 7 | CellInfoParameter、IAfterReportBtnBackExtPlugin、IAfterReportBtnCommitExtPlugin、IAfterReportBtnCompleteExtPlugin、IReportEditInvisibleButtons |
| `kd/sdk/epm/emr/perm` | 1 | EmrDataRoleHelper |
| `kd/sdk/epm/epbs/dataperm` | 1 | DataRoleHelper |
| `kd/sdk/epm/epml/balance` | 2 | BalanceComputeHelper、IAfterBalanceComputeExtPlugin |

## @constellation/fi

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/fi/pa` | 3 | PAIdCreator、PARowMetaBuilder、PARowXProcessor |
| `kd/fi/pa/algox` | 8 | FlatMapFunctionProxy、GenerateRuleBaseScript、GroupReduceFunctionProxy、MapFunctionProxy、ScriptFlatMapFunction |
| `kd/sdk` | 1 | SdkFiModule |
| `kd/sdk/fi/aef` | 1 | IBusinessTypeExtService |
| `kd/sdk/fi/ai` | 1 | IDapBillFilter |
| `kd/sdk/fi/ai/business/utils` | 1 | DapBizVoucherSdk |
| `kd/sdk/fi/ap/extpoint` | 21 | IAddErrorFilter、IAfterBizProcess、IAfterGenerateVoucherExt、IAfterImportDataExt、IAfterSettleProcess |
| `kd/sdk/fi/ap/extpoint/invoicematch` | 1 | ISelectMatchBillHandler |
| `kd/sdk/fi/ar/extpoint` | 4 | IConvertVerify、IInvIssueCallback、IPlanRowSplit、IRecSettleWarnFilter |
| `kd/sdk/fi/arapcommon` | 3 | ReportQueryParam、ReportQuerySDKHelper、SettleServiceSDKHelper |
| `kd/sdk/fi/bd/service` | 3 | BalanceExecutorSdk、CDCServiceGLIntegratorSDK、QueryParam |
| `kd/sdk/fi/cal/extpoint` | 4 | CalBalDataSDK、ICalGroupCostAcct、ICalMoveGroupCost、IQueueTypeMatch |
| `kd/sdk/fi/cas/extpoint` | 34 | BankAutoMatchCheck、CheckBalanceAdjust、CompareCheckRule、IAgentPayBillRepay、IAgentPayField |
| `kd/sdk/fi/dhc` | 1 | ISynchronizationDataExtPlugin |
| `kd/sdk/fi/er/extpoint` | 20 | AfterSelectInvoice、IAfterHandleBillPool、IAfterHandleShareLogic、IAIReimburseService、IAmountControl |
| `kd/sdk/fi/er/extpoint/tripstd` | 2 | ITripOverStdFormula、ITripStdDaysFormula |
| `kd/sdk/fi/fatvs/extpoint` | 5 | ISkillRunnableExtPlugin、SkillIndicatorParam、SkillRunAnalysisPageParam、SkillRunExtContext、SkillRunExtResult |
| `kd/sdk/fi/fca` | 1 | ITranSupBillVoucher |
| `kd/sdk/fi/fcm/extpoint` | 3 | CheckContext、CheckResult、IClosePeriodCheckPlugin |
| `kd/sdk/fi/fgptas/extpoint` | 10 | IAttachContentService、IAttachmentHandler、IAttachmentInfoService、IAttachPicturePreProcess、IAuditElementParser |
| `kd/sdk/fi/fircm` | 2 | IAddCreditPoints、IDeductCreditPoints |
| `kd/sdk/fi/fircm/extpoint/common` | 1 | ModifySourceEnum |
| `kd/sdk/fi/fr` | 1 | IBankInfoF7Service |
| `kd/sdk/fi/frm/extpoint` | 1 | ISummaryDataHandler |
| `kd/sdk/fi/gl/extpoint` | 22 | AccountAssgrpMapping、AccountAssgrpMappingParam、IAccBalOrgNumberOrder、IAccBalReportQuery、IAccountAssgrpMapping |
| `kd/sdk/fi/ict` | 2 | IAutoReconcValidate、IExtensibleFilter |
| `kd/sdk/fi/qitc/extpoint` | 1 | ITaskRectiferService |

## @constellation/hdtc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/hdtc` | 2 | SdkHdtcHrccModule、SdkHdtcHrdiModule |
| `kd/sdk/hdtc/hrcc/fileimport` | 2 | FileInfo、IFileMigrationService |
| `kd/sdk/hdtc/hrdbs` | 1 | ApiResponse |
| `kd/sdk/hdtc/hrdi/adaptor` | 11 | BaseDataBeforeInvokeApiArgs、BizPersonDataMappingArgs、HrdiBizDataSyncServiceHelper、IBaseDataBeforeInvokeApiExtend、IBaseDataUniqueFieldExtend |

## @constellation/hr

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/hr` | 6 | SdkHRHdmModule、SdkHRHlcmModule、SdkHRHomModule、SdkHRHpfsModule、SdkHRHspmModule |
| `kd/sdk/hr/common` | 3 | DepempBean、EmpBean、PerChgBizInfoNew |
| `kd/sdk/hr/hdm/business` | 1 | IBatchTransferExtendService |
| `kd/sdk/hr/hdm/business/mservice` | 4 | HDMPartBillServiceHelper、HDMRegBillServiceHelper、HDMTransferQueryHelper、HDMTransferServiceHelper |
| `kd/sdk/hr/hlcm` | 1 | SdkHRHlcmModule |
| `kd/sdk/hr/hlcm/business` | 1 | IHLCMTemplateService |
| `kd/sdk/hr/hlcm/business/domain` | 1 | HLCMServiceHelper |
| `kd/sdk/hr/hlcm/business/mservice` | 1 | ContractServiceHelper |
| `kd/sdk/hr/hom` | 3 | IHOMLoginService、IHOMMessageService、IOnbrdInfoService |
| `kd/sdk/hr/hom/business` | 14 | IBankCardService、IBaseInfoService、ICancontactService、ICanFamilyService、ICertificateInfoService |
| `kd/sdk/hr/hom/business/mservice` | 1 | HOMLoginServiceHelper |
| `kd/sdk/hr/hom/mservice` | 1 | HOMServiceHelper |
| `kd/sdk/hr/hpfs` | 1 | ChgRecordMsgUtils |
| `kd/sdk/hr/hpfs/business` | 2 | ICustomPersonFlowService、MultiViewTempService |
| `kd/sdk/hr/hpfs/business/mservice` | 2 | HPFSPersonChgServiceHelper、HPFSPersonFlowServiceHelper |
| `kd/sdk/hr/hpfs/business/perchg` | 3 | PerChgAttachment、PerChgBizInfo、PerChgBizResult |
| `kd/sdk/hr/hpfs/business/perchg/executor` | 6 | ChgExternalDataEntryDto、ChgFlowTypeEnum、ChgLogEntryDto、ChgLogEntryStatusEnum、ChgModeEnum |
| `kd/sdk/hr/hpfs/common` | 1 | PerChgStatusEnum |
| `kd/sdk/hr/hpfs/formplugin` | 2 | DynFilePagePlugin、MultiViewTemplatePlugin |
| `kd/sdk/hr/hspm/business` | 12 | ApprovalHelper、AttacheHandlerService、BasedataHelper、CommonQFilterHelper、ErManFileQfilter |
| `kd/sdk/hr/hspm/business/mservice` | 1 | HSPMServiceHelper |
| `kd/sdk/hr/hspm/common` | 68 | AfterCreatVo、ApprovalConstants、ApprovalEntityUtils、AttachConstants、BaseRefEnum |
| `kd/sdk/hr/hspm/common/ext` | 16 | CardBindDataDTO、DialogBindDataDTO、EmpReportExtCalculateDTO、EmpReportExtColumnDTO、EmpReportExtQueryFieldsDTO |
| `kd/sdk/hr/hspm/formplugin/mobile/file` | 1 | AbstractMobileFormDrawEdit |
| `kd/sdk/hr/hspm/formplugin/web/file/employee` | 1 | AbstractPCFormDrawEdit |
| `kd/sdk/hr/hspm/formplugin/web/file/ermanfile` | 10 | AbstractCardDrawEdit、AbstractEntryEntityDrawEdit、AbstractFormDrawEdit、ApControlService、ApCreateUtils |
| `kd/sdk/hr/hspm/formplugin/web/file/ermanfile/ext` | 1 | ManagePCFullFormDrawEdit |
| `kd/sdk/hr/hspm/formplugin/web/file/ermanfile/ext/service` | 2 | IFileCardPluginService、MobileHomeExtUtil |
| `kd/sdk/hr/htm/business/mservice` | 1 | HTMQuitBillServiceHelper |

## @constellation/hrmp

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/hr/hbp/business` | 12 | AbstractConsumerHandleService、AbstractInitDomainDataService、AppIdServiceHelper、ExcludeFromJacocoGeneratedReport、HRBackgroundTaskHelper |
| `kd/hr/hbp/business/application/impl` | 7 | AbstractSortingArrayService、CompareDiffController、DynamicObjectCommonService、HisModelAttachController、HisModelController |
| `kd/hr/hbp/business/domain` | 3 | HisCommonEntityRepository、HisModelNonEventUtil、HisSyncDataStatusRepository |
| `kd/hr/hbp/business/domain/model` | 13 | BatchVersionChangeRespData、HisBaseBo、HisImportBo、HisInitReturnBo、HisResponse |
| `kd/hr/hbp/business/domain/model/newhismodel` | 5 | HisBatchDiscardApiBo、HisDiscardApiBo、HisEnableParamBo、HisSynDataStatusServicerHelper、IHisSynDataStatusService |
| `kd/hr/hbp/business/domain/model/newhismodel/api` | 5 | CompareDiffApiBatchInputParam、CompareDiffApiInputParam、CompareDiffApiOutPutParam、HisAttachmentDataBo、HisAttachmentParamBo |
| `kd/hr/hbp/business/domain/service` | 1 | HisAttachmentService |
| `kd/hr/hbp/business/domain/service/impl/newhismodel` | 1 | HisVersionNumberService |
| `kd/hr/hbp/business/extpoint` | 1 | IStrategyExtService |
| `kd/hr/hbp/business/extpoint/permission` | 9 | IAdminGroupListSubPlugin、IAdminGroupPermSubPlugin、IExportRolePermCusPlugin、IMemAssignRoleCusPlugin、IPermRuleMatchPlugin |
| `kd/hr/hbp/business/history` | 1 | HistoryEntityUtils |
| `kd/hr/hbp/business/openservicehelper` | 34 | AdminOrgServiceHelper、HCFModule、HCFServiceHelper、HPRIPerBankCardServiceHelper、HRActivityModule |
| `kd/hr/hbp/business/service` | 9 | FormulaParseService、HRFormulaPlatformModule、HRPluginProxy、HRPlugInProxyFactory、HRSmartSearchService |
| `kd/hr/hbp/business/service/formula/cal` | 1 | AbsHRMPCalcService |
| `kd/hr/hbp/business/service/perm/dyna` | 1 | IDynaCondParser |
| `kd/hr/hbp/business/service/query` | 2 | IKsqlConfig、KsqlListDataProvider |
| `kd/hr/hbp/business/service/timeline` | 1 | TimelineEntityConf |
| `kd/sdk/hr/hrmp` | 2 | HRHdtcModule、IHRCommonIntegrationService |
| `kd/sdk/hr/hrmp/haos` | 3 | HROdcModule、IStaffExtDimFilterExtend、IStaffRuleConfigExtend |
| `kd/sdk/hr/hrmp/hbjm` | 2 | HROdcModule、IJobTreeSortConditionExtend |
| `kd/sdk/hr/hrmp/hbpm` | 6 | HROdcModule、IBosPositionValidateServiceExt、IPositionCompareEntryServiceExtend、IPositionF7OrgTreeOrgIdsServiceExtend、IPositionSkipValidateServiceExtend |
| `kd/sdk/hr/hrmp/hrpi` | 2 | ErmanfileDataMapBeforeDelUtil、IErmanfileDataMapBeforeDelExtService |

## @constellation/macc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/macc/cad/common` | 7 | BgParamEnum、CadEmptyUtils、ExecuteResult、MfgFeeAllocImportParam、MfgfeeBillImportHelper |
| `kd/sdk/macc/aca` | 2 | IActCostCalcLvlPlugin、IActCostCalcPlugin |
| `kd/sdk/macc/cad` | 2 | IDealMatCostInfoAfterUpdate、ISettleSchemeListModifyPlugin |

## @constellation/mmc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/mmc` | 6 | IMRPSDKEnv、IPomOrderSdk、IPropOrderSdk、SdkMmcMrpModule、SdkMmcPomModule |
| `kd/sdk/mmc/mrp` | 4 | IMRPCalcNetDemandPlugin、IMRPClearHistoryDataPlugin、IMRPInitBomDataPlugin、IMRPMaterialPlanPlugin |
| `kd/sdk/mmc/mrp/framework` | 2 | IResModelDataTable、IRowData |

## @constellation/odc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/odc` | 2 | SdkOdcHaosModule、SdkOdcHbpmModule |
| `kd/sdk/odc/haos` | 1 | IAdminOrgSDKService |
| `kd/sdk/odc/hbpm` | 1 | IPositionSDKService |

## @constellation/qmc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/qmc` | 1 | SdkQmcQcbdModule |
| `kd/sdk/qmc/qcbd` | 4 | ICalculatorExt、IInspectProPriorityExt、IMaterialInspectSDKService、MaterialInspectHelper |

## @constellation/scm

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/scm` | 10 | SdkScmCommonModule、SdkScmMalModule、SdkScmPbdModule、SdkScmPmmModule、SdkScmPsscModule |
| `kd/sdk/scm/common` | 9 | IBidHallByEntryPlugin、ICreateUserNumberSupport、IMaterialGroupStandardService、IPurInstockCheckMappingService、IPurInvoiceCfgService |
| `kd/sdk/scm/pbd` | 11 | IBusinessRulesCallBackService、IBusinessRulesCheckParseService、IBusinessRulesFillParseService、IBusinessRulesRequestParseService、IPbdCostModelPlugInValue |
| `kd/sdk/scm/pbd/analyse` | 1 | AbstractPbdQueryFilter |
| `kd/sdk/scm/pbd/spread` | 9 | BorderLine、Cell、CellStyle、Range、ScmSpreadBook |
| `kd/sdk/scm/pmm` | 1 | IOperateMonitorRuleService |
| `kd/sdk/scm/pssc` | 6 | IPsscPackageGroupPrepareExecutor、IPsscTaskSplitBillBasis、IReqContactOrderHandler、ITaskStatusCalculator、ITaskStatusEnum |
| `kd/sdk/scm/pssc/packagegroup` | 3 | PsscMaterialGroupInfo、PsscPackageGroupContext、PsscTagGroupRuleOrderInfo |
| `kd/sdk/scm/pur` | 7 | IBatchStockSupport、ICreateAPBillSupport、ICreateOrderSupport、IDeliveryAssistantSupport、IGenericLogisticsSupport |
| `kd/sdk/scm/quo` | 1 | IQuoInquiryVerify |
| `kd/sdk/scm/scp` | 4 | IAutoStockSupport、IScpHandCheckSupport、IScpInvoiceCloudSupport、IScpOrderChangeSupport |
| `kd/sdk/scm/sou` | 10 | AdoptionRule、ISouBidBillToEasXKOrder、ISouCompareAssistantDataSource、ISouCompareAssistantRecentPriceSource、ISouComparePushNoticeVerify |
| `kd/sdk/scm/srm` | 15 | IMainPage1NoticeService、ISrmAccessNodeService、ISrmAllScorerScoredService、ISrmAssignUserRoleService、ISrmAutoCalGroupOrgService |
| `kd/sdk/scm/srm/extpoint` | 10 | AbstractSrmPortraitDataSetStatistic、ISupplierQualifiedService、SrmAutoScoreReq、SrmAutoScoreResp、SrmMapping |
| `kd/sdk/scm/srm/extpoint/dto` | 2 | SrmPortraitContext、SrmPortraitStatisticInfo |

## @constellation/scmc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/mpscmm/mscommon/writeoff/business/config` | 1 | WriteOffOverCheckResult |
| `kd/scmc/mobim/common` | 1 | BotpUtils |
| `kd/scmc/mobim/plugin/form` | 2 | IScanResultExtPlugin、PurInBillEntryEditPlugin |
| `kd/scmc/mobim/plugin/tpl` | 3 | MobImBillEntryEditPlugin、MobImBillInfoPlugin、MobImBillListPlugin |
| `kd/scmc/msmob` | 2 | FormMappingRelationship、QrCodeResult |
| `kd/scmc/msmob/business/helper` | 2 | EntryMappingIndex、VisitingContext |
| `kd/scmc/msmob/business/helper/change` | 8 | AbstractDataChangedContext、EntryPageFieldsExtension、EntryRowAddedExtension、EntryRowDeletedExtension、PropertyChangedContext |
| `kd/scmc/msmob/common/design/factory` | 1 | IFormFactory |
| `kd/sdk/fi/cal/extpoint` | 3 | ICalFallPriceEx、ICalSynGroupBillEx、ISyncBizBillEx |
| `kd/sdk/mpscmm` | 4 | SdkMsbdModule、SdkMsconModule、SdkMsmobModule、SdkMsrcsModule |
| `kd/sdk/mpscmm/msbd` | 1 | MsbdExpandCaseCodes |
| `kd/sdk/mpscmm/msbd/algorithm` | 3 | AlgorithmService、FetchPriceHelperService、IAlgorithmExtPlugin |
| `kd/sdk/mpscmm/msbd/expoint` | 7 | BizOperatorAndGroup、IDataCtrlCasePlugin、IDataCtrlCasePlugin$QFilterLogic、IQuoteCasePlugin、IWorkBenchPlugin |
| `kd/sdk/mpscmm/mscommon/writeoff/extpoint` | 8 | IKdtxUnWfPlugin、IKdtxWfPlugin、IUnWfEndWriteBackPlugin、IUnWriteOffCheckPlugin、IUnWriteOffPlugin |
| `kd/sdk/mpscmm/mscon/extpoint` | 1 | IDocumentPlugin |
| `kd/sdk/mpscmm/mscon/extpoint/documentedit` | 5 | AfterSaveAsDocumentEvent、BeforeOpenDocumentListEvent、BeforeOpenSaveAsFormEvent、BeforeReplaceVariableEvent、BeforeSaveAsDocumentEvent |
| `kd/sdk/mpscmm/msmob` | 6 | IMobBotpResultHandlerPlugin、IMobHomePageCustomDataPlugin、IMobListFilterPlugin、IMobOpenApiUrlMapping、IMobOperationDataTransferPlugin |
| `kd/sdk/mpscmm/msrcs` | 1 | IRebatePlugin |
| `kd/sdk/scmc` | 9 | SdkMobImModule、SdkScmcCcmModule、SdkScmcConmModule、SdkScmcDiModule、SdkScmcImModule |
| `kd/sdk/scmc/ccm` | 1 | ICcmServiceCasePlugin |
| `kd/sdk/scmc/conm` | 2 | IWebOfficePlugin、IXContractPlugin |
| `kd/sdk/scmc/im` | 20 | AuxQtyAndUnitHelper、BillQtyAndUnitHelper、BillUnitAndQtytHelper、DateHelper、DateUtils |
| `kd/sdk/scmc/im/mdc` | 1 | IMftManuInBillValExt |
| `kd/sdk/scmc/ism` | 13 | AfterMatchSettleRelationArgs、AfterSettleBillDeleteArgs、BeforeSettleBillSaveArgs、IInterOrgSettleExpand、IInterOrgSettlePricingPlugin |
| `kd/sdk/scmc/mobim` | 3 | IInvQueryExpand、MobImBillInvQueryExpand、MobImExpandCaseCodes |
| `kd/sdk/scmc/pm` | 12 | IForecastPlanCasePlugin、IPmAPIImportCasePlugin、IPurBatChangeCasePlugin、IPurQuotaCasePlugin、ISouceControlCasePlugin |
| `kd/sdk/scmc/sbs` | 2 | ISbsSelectSNExpand、SbsExpandCaseCodes |
| `kd/sdk/scmc/sctm` | 2 | IXScpoPlugin、SctmExpandCaseCodes |
| `kd/sdk/scmc/sm` | 7 | IAmountCalculateCasePlugin、ICleanFieldsCasePlugin、IDeliverControlCasePlugin、ISmAPIImportCasePlugin、IXSalOrderCasePlugin |
| `kd/sdk/scmc/upm` | 1 | UpmExpandCaseCodes |

## @constellation/sit

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/sit` | 6 | SdkHcsiModule、SdkIitModule、SdkItcModule、SdkSitbpModule、SdkSitbsModule |
| `kd/sdk/sit/hcsi/business` | 3 | IBeforeExportCalPersonExtService、IInsuranceDataSynExtService、ITruncationDealExtService |
| `kd/sdk/sit/hcsi/business/mservice` | 1 | CalResultServiceHelper |
| `kd/sdk/sit/hcsi/common/events` | 7 | AfterInsuranceDataListEvent、ItemDataEvent、SinSurFileBaseAddAttributeEvent、SinSurFileBaseAddPageAttributeEvent、SinSurFileBaseHisChangeEvent |
| `kd/sdk/sit/hcsi/formplugin` | 2 | ISinSurFileBaseAddAttributePlugin、ISinSurFileBaseImportAddExcelColumnPlugin |
| `kd/sdk/sit/hcsi/formplugin/cal` | 2 | ICalPersonListAutoSumPlugin、ICalPersonListDisplayPlugin |
| `kd/sdk/sit/hcsi/oppplugin` | 3 | ISinSurFileBaseAddAttributeService、ISinSurFileBaseHisChangeService、ISinSurFileBsedValidatorPlugin |
| `kd/sdk/sit/hcsi/service` | 3 | ISinSurFileBaseImportAddAttributeService、SinSurFileBaseHelper、SinSurFileHelper |
| `kd/sdk/sit/iit/business/mservice` | 1 | TaxFileServiceHelper |
| `kd/sdk/sit/iit/business/tax` | 1 | TaxPersonQueryService |
| `kd/sdk/sit/itc/business/tax` | 2 | ITaxResultBatchImportService、TaxDataQueryService |
| `kd/sdk/sit/sitbp/service` | 1 | SitbpCommonService |
| `kd/sdk/sit/sitbs/business/extpoint` | 1 | ISITBSPersonExtService |
| `kd/sdk/sit/sitbs/business/tax` | 1 | TaxBasicInfoQueryService |
| `kd/sdk/sit/sitcs/business/extpoint` | 3 | IBeforeSocialCalDataSaveExtService、IDclPersonDataSaveBeforeExtService、ISocialCalDataSave |
| `kd/sdk/sit/sitcs/common/events` | 3 | AfterSocialCalDataSaveEvent、BeforeSocialCalDataSaveEvent、DclPersonDataSaveBeforeEvent |

## @constellation/ssc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/fi/ssc` | 1 | TaskServiceHelper |
| `kd/sdk/fi/ssc/extpoint` | 10 | IAfterDisService、ICustomAchieveFactorPlugin、IDataPrepareService、INotifyWfService、IStateChangeService |
| `kd/sdk/fi/ssc/extpoint/disRebuild` | 2 | DisTaskSourceEnum、DisTypeEnum |
| `kd/sdk/fi/ssc/extpoint/task/withdraw` | 2 | InDealTaskWithdrawService、TaskWithdrawService |
| `kd/sdk/fi/ssc/util` | 1 | PartaskUniversalUtil |
| `kd/sdk/ssc` | 1 | ObjectUtils |

## @constellation/swc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/swc` | 8 | SdkHcdmModule、SdkHpdiModule、SdkHsasModule、SdkHsbpModule、SdkHsbsModule |
| `kd/sdk/swc/hcdm/business/extpoint` | 14 | IAdjConfirmPrintExtPlugin、IAdjConfirmPrintExtService、IAdjDetailRptExtService、IAdjSalSynExtService、IAdjSalSynRecordExtService |
| `kd/sdk/swc/hcdm/business/extpoint/adjapprbill` | 4 | AdjConfirmPrintEvent、AfterBuildEntryGridEvent、BeforeSynDecRecordEvent、DecAdjPropertyChangeEvent |
| `kd/sdk/swc/hcdm/business/extpoint/adjsalsyn` | 2 | BeforeSalaryAdjSyncDeleteEvent、BeforeUpdateSyncDetailStatusEvent |
| `kd/sdk/swc/hcdm/business/extpoint/candsetsalapply` | 1 | AddSyncFieldsEvent |
| `kd/sdk/swc/hcdm/business/extpoint/salarystd` | 16 | CandContrastPropLoadEvent、ContrastPropLoadEvent、OnGetCustomerQFilterEvent、OnGetDefaultDisplayParamEvent、OnGetFieldColumnWidthEvent |
| `kd/sdk/swc/hcdm/business/mservice` | 4 | AdjConfirmBillServiceHelper、AdjConfirmTplServiceHelper、AdjFileInfoServiceHelper、SalaryStdServiceHelper |
| `kd/sdk/swc/hcdm/common` | 4 | SimpleStdRangeMatchParam、SimpleStdRangeMatchResult、StdRangeNameFormatParam、StdTableDataQueryParam |
| `kd/sdk/swc/hcdm/service` | 3 | AdjApprovalBillService、AdjFileInfoService、SalaryStdQueryService |
| `kd/sdk/swc/hpdi/business` | 1 | ICollaMsgReceiveExtService |
| `kd/sdk/swc/hpdi/business/extpoint` | 3 | IBizDataBillEntryExtService、ICollaReviseMsgExtService、ICollaRuleExtService |
| `kd/sdk/swc/hpdi/business/mservice` | 1 | BizDataServiceHelper |
| `kd/sdk/swc/hpdi/common/events` | 9 | AfterAddFieldContainerEvent、AfterGetCustomResultEvent、AfterParseMsgContentEvent、AfterReviseMsgEvent、AfterSaveReceiveMsgEvent |
| `kd/sdk/swc/hpdi/formplugin/extpoint` | 4 | IBizDataBillEntryImportExtPlugin、IBizDataListExtPlugin、IBizDataMatchSalaryFileExtPlugin、IBizDataTransSalaryExtPlugin |
| `kd/sdk/swc/hsas/business/extpoint` | 14 | IAccResultImportExtPlugin、IApproveBillExtService、IAttIntegrateExtPlugin、IBankAccountService、IBankOfferExtService |
| `kd/sdk/swc/hsas/business/mservice` | 11 | BizDataServiceHelper、CalPayrollTaskServiceHelper、OnHoldServiceHelper、PayDetailServiceHelper、PaySettingServiceHelper |
| `kd/sdk/swc/hsas/common` | 6 | Function、ImportEntity、ImportEntityRel、ItemTreeNode、Parameter |
| `kd/sdk/swc/hsas/common/events` | 16 | AddStepCustomFilterEvent、AddStepCustomParamEvent、AfterBizDataListEvent、AfterBuildHeadEvent、AfterBuildPaySettingEventArgs |
| `kd/sdk/swc/hsas/formplugin` | 3 | ICalPersonListAutoSumPlugin、ICalStepCustomFilterPlugin、ICalStepCustomParamPlugin |
| `kd/sdk/swc/hsas/formplugin/extpoint` | 11 | IApproveInvokeReportFormExtService、IApproveOverViewDealExtService、IApproveSpecialRuleVerifyExtPlugin、IBankOfferExtPlugin、ICalResultCoverSalaryItemExtPlugin |
| `kd/sdk/swc/hsas/service` | 2 | CalPersonListService、CalResultQueryService |
| `kd/sdk/swc/hsbp/business` | 2 | SWCFilterCalSalaryFile、SWCSalaryParameterService |
| `kd/sdk/swc/hsbs/business/mservice` | 1 | BizItemServiceHelper |
| `kd/sdk/swc/hscs/business` | 9 | ICalRollBackExtService、IFetchResultCoverDataExtService、IHisDataCheckExtService、INewAttIntegrateExtPlugin、IPayDetailExtService |
| `kd/sdk/swc/hscs/business/mservice` | 2 | HSCSCostAllotDetailServiceHelper、HSCSCostSetUpServiceHelper |
| `kd/sdk/swc/hscs/common` | 12 | AfterCreateAttBizDataEvent、AfterCreatePayDetailEvent、AfterSalaryCalEvent、BeforeSalaryCalCheckEvent、CalRollBackEvent |
| `kd/sdk/swc/hscs/service` | 4 | ICostAllotDetailService、ICostSetUpService、ICustFetchService、ICustomFetchDataService |
| `kd/sdk/swc/hspp/business/extpoint` | 1 | ISalarySlipQueryExtService |
| `kd/sdk/swc/hspp/formplugin` | 1 | ISalaryBaseExtService |
| `kd/sdk/swc/hspp/mservice` | 1 | SalarySlipServiceHelper |
| `kd/sdk/swc/pcs/business/extpoint` | 2 | ICostCfgExportExtService、ICostCfgImportExtService |
| `kd/sdk/swc/pcs/business/mservice` | 2 | PCSCostAllotBillServiceHelper、PCSCostCfgServiceHelper |
| `kd/sdk/swc/pcs/common` | 2 | CostAllotBillArgs、CostCfgEvent |
| `kd/sdk/swc/pcs/service` | 1 | ICostAllotBillService |

## @constellation/taxc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/taxc` | 2 | SdkTaxcBdtaxrModule、SdkTaxcTotfModule |
| `kd/sdk/taxc/bdtaxr` | 5 | DeclareBizExtendServiceHelper、DeclareBizOperationServiceHelper、DeclareBizQueryServiceHelper、DeclareExportDataServiceHelper、DeclarePayExtService |
| `kd/sdk/taxc/tam` | 1 | SdkTaxcTamModule |
| `kd/sdk/taxc/tdm` | 1 | SdkTaxcTdmModule |
| `kd/sdk/taxc/tdm/extpoint` | 2 | IFcsBgentryUpdateService、IFinanceRptFieldExtPlugin |
| `kd/sdk/taxc/totf` | 1 | AccrualGenerateService |

## @constellation/tdc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/tdc` | 8 | SdkTdcCadmModule、SdkTdcCaqmModule、SdkTdcOatrModule、SdkTdcSucpModule、SdkTdcTalpModule |
| `kd/sdk/tdc/caqm` | 1 | IQualiStandExtendService |
| `kd/sdk/tdc/oatr` | 8 | IDimensionOriginalValueExtendService、IDimResultImportExtendService、IEvalImportExtendService、IOnlineCalibrationMapExtService、IReviewObjectTalentFileExtService |
| `kd/sdk/tdc/tala` | 2 | IRuleConditionComparator、ITalentPortraitService |
| `kd/sdk/tdc/tjga` | 1 | IEligibilityExtendService |

## @constellation/tmc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk` | 1 | SdkTmcModule |
| `kd/sdk/tmc/am/extpoint` | 4 | IBankAccountFilter、IDormantFormListFilter、IInspectPushMyself、ILinkPayRelationAddCompanyFilter |
| `kd/sdk/tmc/bei` | 6 | AutoMatchInfoParam、IMatchRuleByAccountService、MatchRequestBean、MatchResultBean、MatchUtil |
| `kd/sdk/tmc/bei/extpoint` | 13 | IAfterBankPayQueryExt、IAfterReceiptRecognition、IAutoMatchWriteBackInterface、IBalanceReportInterface、IBankPayDetailExt |
| `kd/sdk/tmc/cdm` | 2 | ReturnNoteBean、ReturnNoteEndorseBean |
| `kd/sdk/tmc/cdm/extpoint` | 2 | IPayableCanDrawValidatorInterface、IPayableTranEleSDKService |
| `kd/sdk/tmc/cfm` | 3 | CostShareUtil、FeeCostParam、FeeCostShareInfo |
| `kd/sdk/tmc/cfm/extpoint` | 14 | IApplyReturnCreditlimit、IConfirmListInterface、IExtApplyBillSecondDevFields、IGetCustomBillFormIdSecondDevService、IGetExtCfmBillLayoutInfoDev |
| `kd/sdk/tmc/cim` | 2 | IReleaseApplyAutoReleaseSDKService、IReleasePushDptRevenue |
| `kd/sdk/tmc/creditm` | 1 | ICreditLimitExtInerface |
| `kd/sdk/tmc/creditm/util` | 1 | CreditLimitServiceUtil |
| `kd/sdk/tmc/ext/extpoint` | 1 | IGenBankBillSDKService |
| `kd/sdk/tmc/fbp` | 2 | IFeeDetailSaveAndSubmitAddFields、IGetCustomSceneBillStatusSDKService |
| `kd/sdk/tmc/fbp/extpoint` | 1 | IFunderOrgPermissionExtDev |
| `kd/sdk/tmc/fca` | 2 | IBalanceService、ITranSupBillVoucher |
| `kd/sdk/tmc/fcs/extpoint` | 2 | IRelationShipJob、IRelationShipNotFind |
| `kd/sdk/tmc/fpm` | 5 | AfterReportGenerateParam、IInOutCollectSaveExt、IReportGenerateSDKService、IReportManageSDKService、ReportF7CellFilterParam |
| `kd/sdk/tmc/ifm` | 4 | ExtPlanCallResult、IGlAccountBalance、IInstBalanceCalcSecondDev、ITransDetailSecondDevFields |
| `kd/sdk/tmc/ifp/expoint` | 1 | IPlanEditBasedataF7Filter2Dev |
| `kd/sdk/tmc/mon/extpoint` | 1 | IMobileSecondaryDevCard |
| `kd/sdk/tmc/mrm` | 1 | IExRateGapAnalysisService |
| `kd/sdk/tmc/psd` | 2 | ICheckDefaultAccount、IPayScheduleSelectBill |
| `kd/sdk/tmc/psd/extpoint` | 4 | IAssemblySecondaryDevFields、PayScheduleInfo、PaySchedulePropVal、SelectBillParam |
| `kd/sdk/tmc/sar` | 1 | ISarBankAccountRptFilterService |
| `kd/sdk/tmc/tda/extpoint` | 21 | IArApTopCustSuppInterface、IBankAcctByBankInterfaceRPA、IBankAcctInterface、IBigAmountCommonSourceReBuildInterface、IBigAmountDataInterface |
| `kd/sdk/tmc/tm/forex` | 2 | IAutoSetExchangeRateDevService、IForexWbExcludeStatusExtService |
| `kd/sdk/tmc/tm/init` | 2 | IForexFwdInit2BizBillSecondDevService、IForexFwdInit2TradeSecondDevService |
| `kd/sdk/tmc/tm/plinfo` | 1 | IPlInfoDevService |
| `kd/sdk/tmc/tm/swaps` | 1 | IFixedInterestRateAllowZeroDevService |
| `kd/sdk/tmc/tmbrm` | 1 | IFinOrgArchivesAssociatedBillInterface |

## @constellation/tsc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/tsc` | 6 | SdkTscTsirmModule、SdkTscTsoModule、SdkTscTsprModule、SdkTscTsrbdModule、SdkTscTsrscModule |
| `kd/sdk/tsc/tsirm/extpoint` | 6 | HomeViewService、IChangeStageStatusService、IEmpCVdeliveryService、IEmpCVdeliveryValidator、IEmpCVService |
| `kd/sdk/tsc/tsirm/service` | 3 | AppFileServiceHelper、EmpCVServiceHelper、ResumeServiceHelper |
| `kd/sdk/tsc/tso` | 5 | IMkProcessService、IOfferCustomFieldValidate、OfferBasicServiceHelper、OfferInductionServiceHelper、OfferListService |
| `kd/sdk/tsc/tspr` | 1 | HcfServiceHelper |
| `kd/sdk/tsc/tsrbd/extpoint` | 2 | IGptCustomParamService、IMessageCustomParamService |
| `kd/sdk/tsc/tsrsc` | 2 | HcfServiceHelper、IUserMappingService |
| `kd/sdk/tsc/tstpm` | 1 | CandidateServiceHelper |

## @constellation/wtc

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd/sdk/wtc` | 13 | OnMatchOtDutyDateEvent、OtDutyDateParam、SdkWtcWtabmModule、SdkWtcWtamModule、SdkWtcWtbsModule |
| `kd/sdk/wtc/wtabm/business` | 23 | DayTimeDetail、OnCalVaApplyTimeEvent、OnCheckVaApplyOverlapEvent、OnRenameVaTypeEvent、ShiftParseVoExt |
| `kd/sdk/wtc/wtabm/business/helper` | 3 | VaBillValidateErrorInfo、VaPlanRuleQuery、VaPlanRuleResp |
| `kd/sdk/wtc/wtam/business` | 5 | TpApplyTimeCalculateEvent、TpApplyTimeCalculateExtPlugin、TpInfoExpService、TpInfoParameterParam、WtamHelper |
| `kd/sdk/wtc/wtam/business/tp` | 1 | TpBillValidateErrorInfo |
| `kd/sdk/wtc/wtbs` | 10 | AbstractTaskRequest、AfterSubTaskEndEvent、AfterTaskEndEvent、BeforeSubTaskStartEvent、BeforeTaskStartEvent |
| `kd/sdk/wtc/wtbs/business` | 9 | BillUnifyResult、BillValidateErrorInfo、DateRangeRuleExpPlugin、ISchemeMatchPlugin、OnLimitConditionEvent |
| `kd/sdk/wtc/wtbs/business/bill` | 2 | BillDutyDateExtPlugin、OnMatchBillDutyDateEvent |
| `kd/sdk/wtc/wtbs/common` | 11 | AbstractExtendableObj、ConditionDtoExt、Extendable、Nullable、RefDateType |
| `kd/sdk/wtc/wtes/business` | 4 | OnTimeCutMatchEvent、QteContextExt、QteRequest、TimeCutMatchExtPlugin |
| `kd/sdk/wtc/wtes/business/qte` | 27 | AfterQteAllParamInitEvent、AfterQteGenQTEvent、AfterQteNoGenDateEvent、AfterQteParamInitEvent、AfterQteResolveRefDateEvent |
| `kd/sdk/wtc/wtes/business/qte/init` | 4 | CircleConfig、CircleRest、DataPoint、QuotaGenConditionExt |
| `kd/sdk/wtc/wtes/business/tie` | 2 | AfterTieTaskEndEvent、TieTaskEndExtPlugin |
| `kd/sdk/wtc/wtes/business/tie/core` | 4 | AfterTieAllParamInitEvent、TieContentPersistentExt、TieContextExt、TieParamInitExtPlugin |
| `kd/sdk/wtc/wtes/business/tie/core/chain` | 1 | TieAttPeriodContextExt |
| `kd/sdk/wtc/wtes/business/tie/exexutor` | 25 | AfterExecAttendanceEvent、AfterExecAttendanceParam、AfterExecBusinessTripEvent、AfterExecBusinessTripParam、AfterExecDailyChainParam |
| `kd/sdk/wtc/wtes/business/tie/init` | 20 | AttFileQueryParamExt、ConfigMixInitPluginDemo、OnBuildOTQFilterEvent、OnBuildTPQFilterEvent、OnQueryInitParamOfAttFileEvent |
| `kd/sdk/wtc/wtes/business/tie/model` | 49 | AttBillTimeBucketExt、AttendConfigExt、AttendPersonExt、AttFileExt、AttFileScheduleEntityExt |
| `kd/sdk/wtc/wtes/business/tie/model/ex` | 2 | DurationUnitEnumExt、ExDealTypeEnumExt |
| `kd/sdk/wtc/wtes/business/tie/persistent` | 13 | AfterCleanExDataEvent、AfterCleanHisDataEvent、AfterCleanHisEvent、AfterSaveAllPerPeriodDataResultEvent、BeforeSaveDailyDataResultEvent |
| `kd/sdk/wtc/wtis/business` | 13 | AttDataPushReq、AttDataWithDrawReq、AttDataWithdrawTaskFinishedEvent、AttDataWithdrawTaskFinishedExtPlugin、AttFileSchemeDto |
| `kd/sdk/wtc/wtis/business/attdata` | 1 | QTPushAttDataInfoEnumExt |
| `kd/sdk/wtc/wtom` | 2 | OtDutyDateExtPlugin、WtomHelper |
| `kd/sdk/wtc/wtom/business` | 3 | OnCalOtApplyTimeEvent、OnSetOtApplyTimeQuery、OtApplyTimeExtPlugin |
| `kd/sdk/wtc/wtp` | 1 | WTCAttPeriodConstants |
| `kd/sdk/wtc/wtp/business` | 31 | AdPlanHelper、AdPlanRuleQuery、AdPlanRuleResp、AfterCoordinationEvent、AttFileVersion |
| `kd/sdk/wtc/wtp/business/quota` | 2 | QTSummaryExpService、QTSummaryServiceDefault |
| `kd/sdk/wtc/wtpm` | 1 | WTPMSignCardHelper |
| `kd/sdk/wtc/wtpm/business` | 10 | AfterCardMatchEvent、AfterCardMatchExtPlugin、BeforeCardMatchIntersectionEvent、CardMatchIntersectionExtPlugin、CardMatchOffShiftExtPlugin |
| `kd/sdk/wtc/wtpm/model` | 7 | CardMatchTaskVoExt、CardMatchVoExt、MultiCardEntryExt、MultiCardEntryExtStd、MultiCardExt |
| `kd/sdk/wtc/wts/business` | 9 | OnRosterAfterGenDataEvent、OnRosterBeforeValidateEvent、OnRosterValidatorEvent、RosterAfterGenDataExtPlugin、RosterValidateBeginExtPlugin |
| `kd/sdk/wtc/wts/business/roster` | 1 | OnRosterViewControlEvent |
| `kd/sdk/wtc/wtss/business` | 16 | AfterInitAttStatisticAdminOrgEvent、AttStatisticAdminOrgParam、AttStatisticQueryExtPlugin、AttStatisticTargetQueryParam、AttTargetQueryExpandService |
| `kd/sdk/wtc/wtss/business/spi` | 1 | WtssHomepageService |
| `kd/sdk/wtc/wtte` | 1 | WTTEServiceHelper |
| `kd/sdk/wtc/wtte/business` | 11 | AttSettleTaskReq、AttSettleTaskResp、QTTaskHelper、QTTaskReq、QTTaskStartReq |
| `kd/sdk/wtc/wtte/business/attrecord` | 8 | AttRecordDailyItemRptExtPlugin、AttRecordDailyRptExtPlugin、AttRecordPeriodItemRptExtPlugin、AttRecordPeriodRptExtPlugin、OnGetBaseQFiltersEvent |

## @cosmic/bos-core

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `kd` | 1 | SdkBaseModule |
| `kd/bos` | 477 | AbstractBasedataController、AbstractBasePlugIn、AbstractBillPlugIn、AbstractBillWebApiPlugin、AbstractCAService |
| `kd/bos/algo` | 34 | AbstractRow、AlgoCrossThreadAccessDataSetException、AlgoExceedAllowMaxDataSetsException、AlgoExceedAllowMaxRows4SortException、AlgoExceedAllowMaxRowsException |
| `kd/bos/algo/dataset` | 1 | CachedDataSetBuilder |
| `kd/bos/archive` | 4 | ArchiveConfigConnectionTypeEnum、ArchiveConfigFilterTypeEnum、ArchiveConfigMovingTypeEnum、ArchiveRepeatModeEnum |
| `kd/bos/archive/api` | 15 | ArchiveApiFactory、ArchiveBasedata、ArchiveDatabase、ArchiveDatabaseApi、ArchiveMcApi |
| `kd/bos/base/user` | 6 | ResponseData、UserBaseInfo、UserDepartment、UserInfo、UserResult |
| `kd/bos/base/utils` | 1 | BaseMessageUtils |
| `kd/bos/basedata` | 4 | BaseDataCtrlCache、BaseDataCtrlCacheMrg、BaseDataServiceImpl、BillTypeQueryHelper |
| `kd/bos/baserecordset` | 1 | BaseDataSetDao |
| `kd/bos/basmsg` | 1 | IBaseMessageService |
| `kd/bos/bd` | 5 | BaseDataCommonService、BaseDataListProvider、BaseDataUseRelBit、BaseDataUseRelQueryEngine、FieldPropUtils |
| `kd/bos/bd/ctsy` | 1 | CtsyDBUtils |
| `kd/bos/bec` | 6 | EntityEvent、IEventHandler、IEventService、IEventServicePlugin、JsonEvent |
| `kd/bos/bill` | 3 | AICommandEvent、ConvertPkEvent、LocateEvent |
| `kd/bos/ca` | 1 | VerifySignResult |
| `kd/bos/cache` | 1 | TempFileCacheDownloadable |
| `kd/bos/coderule` | 7 | CodeRuleEntryInfo、CodeRuleInfo、CodeRuleServiceImp、ConditionEntryInfo、ICodeRuleEditPlugin |
| `kd/bos/ctcompare` | 1 | CtCpCondition |
| `kd/bos/dataentity` | 97 | ArrayUtils、CharSequenceUtils、CharUtils、CloneUtils、CollectionPropertyAttribute |
| `kd/bos/dataentity/metadata` | 31 | CollectionProperty、CollectionPropertyMap、ComplexProperty、ComplexPropertyMap、DataEntityMetadataMapBase |
| `kd/bos/dataentity/resource` | 1 | CacheKeyUtil |
| `kd/bos/db` | 10 | ArchiveInfo、ArchiveRoute、CommitListener、MCArchive、Propagation |
| `kd/bos/designer` | 24 | BillListCDWDesignerPlugin、BizAppTreeBuilder、DesignerData、FieldSelectPlugin、FormTemplateFactory |
| `kd/bos/designer/property` | 1 | DSField |
| `kd/bos/devportal` | 7 | AppPackageUtil、AssignPermMode、AuthorizeType、DevPortalServiceResult、DevportalUtil |
| `kd/bos/devportal/common` | 3 | AppUtils、SubSysTreeBuilder、TreeLeafType |
| `kd/bos/dts` | 3 | DtsConfigOperator、DtsConfigOperatorInfo、MultiEntity |
| `kd/bos/dts/business` | 1 | DtsBusinessType |
| `kd/bos/dts/impl` | 1 | Mapper |
| `kd/bos/entity` | 408 | AbstractDataModelPlugin、AbstractFilterContantParser、AbstractFormat、AbstractFormDataModel、AbstractKsPrintServicePlugin |
| `kd/bos/entity/botp` | 22 | AbstractConvertPlugIn、AbstractConvertServiceArgs、AbstractWriteBackPlugIn、BeforeDrawArgs、BeforeDrawOpResult |
| `kd/bos/entity/botp/plugin` | 35 | AfterBizRuleEventArgs、AfterBuildDrawFilterEventArgs、AfterBuildQueryParemeterEventArgs、AfterBuildRowConditionEventArgs、AfterBuildSourceBillIdsEventArgs |
| `kd/bos/entity/ctbotp` | 29 | AbstractCtConvertServiceArgs、CtBFEntryTable、CtBFRow、CtBFRowId、CtBFRowLinkDownNode |
| `kd/bos/entity/ctbotp/plugin` | 8 | AbstractCtConvertPlugIn、AbstractCtWriteBackPlugIn、CtBillCloseType、CtDistributeType、CtExcessCheckType |
| `kd/bos/entity/ctbotp/plugin/save` | 4 | AfterBatchSetBaseDataEventArg、BeforeFieldMappingEventArgs、BeforeSaveEventArgs、SavePluginEventArgs |
| `kd/bos/entity/ctbotp/plugin/tracker` | 34 | CtAfterBuildDrawFilterEventArgs、CtAfterBuildQueryParemeterEventArgs、CtAfterBuildRowConditionEventArgs、CtAfterBuildSourceBillIdsEventArgs、CtAfterCalcWriteValueEventArgs |
| `kd/bos/entity/datamodel` | 28 | AfterAddRowEventArgs、AfterDeleteEntryEventArgs、AfterDeleteRowEventArgs、AfterMoveEntryEventArgs、AfterTogetherMoveEntryRowEventArgs |
| `kd/bos/entity/earlywarn` | 1 | WarnSchedule |
| `kd/bos/entity/earlywarn/warn` | 2 | IEarlyWarnConditionForm、IEarlyWarnMessageHandler |
| `kd/bos/entity/earlywarn/warnschedule` | 1 | WarnMessageReceiver |
| `kd/bos/entity/list` | 34 | AbstractColumnDesc、AdminDivisionColumnDesc、AmountColumnDesc、ApproverColumnDesc、BaseDataColumnDesc |
| `kd/bos/entity/mulentities` | 3 | QSExpr、QSIdentifierExpr、QSPropExpr |
| `kd/bos/entity/operate` | 22 | AbstractOpBizRuleAction、ApiCreateOption、ApiCreateSaveOption、ApiErrorCode、ApiModifyOption |
| `kd/bos/entity/operate/bizrule` | 3 | AbstractAsyncMService、AbstractAsyncOpBizRuleAction、AsyncServiceParam |
| `kd/bos/entity/operate/bizrule/asyncbizrule` | 1 | AsyncStatusEnum |
| `kd/bos/entity/plugin` | 18 | AfterOperationArgs、BeforeLoadDataArgs、BeforeOperationArgs、BeforeSaveAuditLogArg、BeforeSaveAuditLogBizEvent |
| `kd/bos/entity/plugin/support` | 8 | Assert、ClassUtils、CollectionUtils、MultiValueMap、ObjectUtils |
| `kd/bos/entity/property` | 8 | EntryFilterItemInfo、EntryQueryParam、OrgRelationConfig、OrgRelationItem、OrgRelationItemDirect |
| `kd/bos/entity/report` | 2 | ReportFilterField、ReportFilterFieldConfig |
| `kd/bos/ext/form` | 18 | AnchorControl、AppStarted、Audio、CommonFunctionControl、CountDown |
| `kd/bos/ext/form/control` | 6 | AppStartedEvent、AppStartedListener、CountDownEvent、CountDownListener、MapSelectEvent |
| `kd/bos/fileservice` | 2 | FileServiceExt、FileServiceExtFactory |
| `kd/bos/filestorage` | 2 | FileStorageConfig、FileStorageService |
| `kd/bos/filter` | 8 | BaseDataSearchHelper、MobCommonBaseDataFilterColumn、MobCommonDateFilterColumn、MobCommonFilterColumn、MobFilterSort |
| `kd/bos/form` | 286 | AbstractFlexBasedataService、AbstractFormPlugin、AbstractFuncParamPlugIn、AbstractGrid、AbstractGrid$GridState |
| `kd/bos/form/attachment` | 1 | AttachmentControlUtil |
| `kd/bos/form/chart` | 6 | RadarAxis、RadarChart、RadarChartData、RadarData、RadarIndicator |
| `kd/bos/form/control` | 137 | ActiveViewEvent、ActiveViewListener、AfterSearchClickListener、AfterShowTipsEvent、AttachmentDownLoadEvent |
| `kd/bos/form/control/events` | 4 | FilterSchemeDto、FilterSchemeRow、SchemeValidateListener、WebOfficeDataListener |
| `kd/bos/form/control/grid` | 13 | AmountDataGridColumn、BeforeCreateDataGridColumnsEvent、DataGridBindDataEvent、DataGridBindDataListener、DataGridColumn |
| `kd/bos/form/field` | 34 | AddFuzzySearchEvent、AfterBindingDataEvent、AfterChangeMainOrgEventArgs、AfterF7SelectEvent、AfterF7SelectListener |
| `kd/bos/form/flex` | 1 | FlexControlMetaPreRenderEvent |
| `kd/bos/form/mcontrol` | 7 | IMobTableModel、IMobTablePackageDataHandler、MobTable、MobTableData、MobTablePackageDataHandler |
| `kd/bos/form/mcontrol/mobtable` | 19 | AmountMobTableColumn、AttachmentMobTableColumn、BeforeCreateMobTableColumnsEvent、DateMobTableColumn、DecimalMobTableColumn |
| `kd/bos/form/operate` | 9 | AbstractOperateWebApi、CopyEntryRow、DeleteEntry、InteractionCallBackHandler、NewEntry |
| `kd/bos/form/plugin` | 11 | AbstractMobF7Plugin、BatchImportPlugin、BdCtrlStrtgyUtils、Column、ComplexSettingItem |
| `kd/bos/form/plugin/importentry` | 2 | BeforeDownloadImportEntryTemplateEvent、ImportEntryTemplateListener |
| `kd/bos/form/spread` | 2 | ISpreadAction、SpreadEvent |
| `kd/bos/form/widget` | 2 | WidgetChangedEvent、WidgetContainerDesignerListener |
| `kd/bos/formula` | 25 | Avg、BinaryExpr、CompoundId、Count、ExecuteContext |
| `kd/bos/formula/platform` | 14 | FormulaDesigner、FormulaDesignerParameter、FormulaDesignerResult、FormulaEngine、FormulaException |
| `kd/bos/formula/platform/api` | 1 | IFuncParamInputFormPlugin |
| `kd/bos/framework` | 1 | Service |
| `kd/bos/framework/lifecycle` | 1 | AppStarter |
| `kd/bos/fulltext` | 1 | FieldValue |
| `kd/bos/gptas` | 6 | AIServiceProxy、EmbeddedControlServiceImpl、KMEntityType、LLMService、ResultBuilder |
| `kd/bos/gptas/adapter/llm/kdai` | 1 | KDAILLMService |
| `kd/bos/gptas/api` | 15 | Chunk、CustomSplitter、DocParser、EmbeddedCustomEventArgs、EmbeddedCustomEventExecutor |
| `kd/bos/gptas/api/embedctrl` | 6 | Agent、InitialConfig、ReferenceData、ReferenceData$Item、ShowStyle |
| `kd/bos/gptas/api/embedctrl/dto` | 6 | AgentParameter、ButtonItem、ButtonItem$ButtonType、ButtonItem$Type、CardInfo |
| `kd/bos/gptas/api/km` | 2 | SplitConfig、SplitEvent |
| `kd/bos/gptas/common/llm` | 1 | LLMServiceImpl |
| `kd/bos/gptas/qa` | 2 | ChunkProvider、QAPrompt |
| `kd/bos/inte` | 2 | EnabledLang、IInteService |
| `kd/bos/invoice` | 1 | InvoiceServiceInterface |
| `kd/bos/isc/http` | 2 | HttpResponse、HttpUtil |
| `kd/bos/isc/service/job` | 1 | FormOpener |
| `kd/bos/kdtx` | 2 | CommonParam、Param |
| `kd/bos/kdtx/common` | 9 | BranchExecuteInfo、CommonDtxResponse、CompensateResponse、CompensateResponse$TxInfo、DtxBranch |
| `kd/bos/kdtx/sdk` | 11 | AbstractSession、DTX、DTXCallback、DtxContext、DtxFactory |
| `kd/bos/kdtx/sdk/session` | 4 | ECGlobalSession、ECSession、TCCGlobalSession、TCCSession |
| `kd/bos/kingscript` | 2 | IvsCodeListener、PushContent |
| `kd/bos/license` | 2 | LicenseCheckResult、LicenseConfigParseResult |
| `kd/bos/license/api` | 3 | LicenseError、LicenseError$LicenseErrorType、LicenseGroupInfo |
| `kd/bos/list` | 62 | AbstractListPlugin、AbstractListViewPluginProxy、AbstractMobListPlugin、AbstractTreeListPlugin、BackPressedEvent |
| `kd/bos/message` | 9 | AbstractMessageInfo、DingdingMessageInfo、DingdingTodoInfo、EmailInfo、IMessageService |
| `kd/bos/message/service/handler` | 2 | ChannelRuntimeConfig、DyanmicChannelConfig |
| `kd/bos/metadata` | 162 | AbstractMetadataReader、AbstractMetadataWriter、AbstractStyle、AppMetadata、AppReader |
| `kd/bos/metadata/domainmodel` | 1 | DomainModelTypeFactory |
| `kd/bos/metadata/entity` | 126 | AbstractBasedataField、AbstractDefValueParamPlugIn、AbstractOpBizRuleParameterEdit、AbstractOpParameterPlugin、AbstractRefBillField |
| `kd/bos/metadata/entity/businessfield` | 1 | StatusItem |
| `kd/bos/metadata/form` | 119 | AdvConAp、AdvConBarItemAp、AdvConChildPanelAp、AdvConSummaryPanelAp、AdvConToolbarAp |
| `kd/bos/metadata/form/control` | 3 | DataGridAp、EmbedFormAp、EmbedFormShowParam |
| `kd/bos/metadata/form/control/grid` | 9 | AmountDataGridColumnAp、DataGridColumnAp、DateDataGridColumnAp、DecimalDataGridColumnAp、IntegerDataGridColumnAp |
| `kd/bos/metadata/form/mcontrol` | 1 | MobTableAp |
| `kd/bos/metadata/form/mcontrol/mobtable` | 8 | AmountMobTableColumnAp、DateMobTableColumnAp、DecimalMobTableColumnAp、IntegerMobTableColumnAp、MobTableColumnAp |
| `kd/bos/metadata/model` | 1 | AbstractModelOperater |
| `kd/bos/metadata/print` | 3 | Barcode、BaseControl、Text |
| `kd/bos/mq` | 2 | BroadcastService、MQCreateFactory |
| `kd/bos/mq/support` | 1 | PartitionStrategy |
| `kd/bos/mservice` | 5 | ListQueryParameter、ListService、ListServiceResult、PrintServiceImp、ReportProgressRecorder |
| `kd/bos/mulimport/extplugin` | 2 | BeforeExecuteMulImportSaveOpEvent、MulImportSearchBdEvent |
| `kd/bos/mutex` | 4 | IntentLockInfo、MutexBaseInfo、MutexLockDataInfo、MutexLockInfo |
| `kd/bos/mvc` | 30 | AbstractListView、BaseModel、BaseView、BillModel、BillTypeApHelper |
| `kd/bos/mvc/form` | 2 | WebOfficeBrowserHelper、WebOfficeBrowserParam |
| `kd/bos/newdevportal` | 3 | DesingerUtils、DynamicFormInfo、GotoDesignerUtils |
| `kd/bos/newdevportal/app` | 3 | DevportalModelTypes、MyAppUtils、PageType |
| `kd/bos/open` | 3 | OpenApiModule、OpenAuthModule、OpenCustomModule |
| `kd/bos/openapi/api` | 20 | ApiAppendEntryRowsPlugin、ApiAuditPlugin、ApiCommonPlugin、ApiDeleteEntryRowsPlugin、ApiDeletePlugin |
| `kd/bos/openapi/api/plugin` | 2 | ApiFilterPlugin、ApiPlugin |
| `kd/bos/openapi/common` | 6 | ApiErrorCode、CustomApiResult、ICustomApiServlet、OpenApiFile、OpenApiResult |
| `kd/bos/openapi/common/custom` | 15 | ApiContent、ApiContents、ApiController、ApiErrorCode、ApiErrorCodes |
| `kd/bos/openapi/security` | 7 | CommDataDto、CommonSecurityDto、EncryptInfo、EncryptionEnum、RequestSecurityDto |
| `kd/bos/openapi/service` | 1 | ServiceApiContext |
| `kd/bos/openapi/service/custom` | 1 | ValidatorUtil |
| `kd/bos/org` | 7 | DynamicObjectUtils、EnableEnum、OrgTreeSearchParam、OrgTreeUtils、OrgViewUtils |
| `kd/bos/org/service` | 1 | OrgManagerUtils |
| `kd/bos/orm` | 17 | DataEntityCacheManager、DataManagerUtils、Distinctable、DtsAccountPower、EntityNotExistsException |
| `kd/bos/permission` | 34 | AdminAppResult、AdminGroupPermTypeEnum、AdminType、AssignModEnum、BizRoleInfo |
| `kd/bos/permission/model` | 20 | AdmGroup、App、Cloud、ComRoleFieldPermScheme、ComRoleFieldPermSchemeDetail |
| `kd/bos/permission/model/perm` | 23 | AdminGroupReq、BusiRoleGroup、CheckPermissionReq、DimFuncPermReq、DimRoleReq |
| `kd/bos/permission/model/perm/req` | 18 | AddUsrGrpReq、CheckUserBizAppReq、ComRoleFieldPermSchemeReq、DelUsrGrpReq、FieldControlRules2RuleReq |
| `kd/bos/permission/model/perm/req/bat` | 9 | BusiRoleAfterDelReq、ComRoleAfterDelReq、UserBusiRoleAfterDelReq、UserComRoleAfterDelReq、UserDirectDisPermAfterDelReq |
| `kd/bos/permission/model/perm/resp` | 4 | AdmGrpHasPermResp、GetHasPermPermCtrlObjResp、GetHasPermUserResp、GetUserDimFieldPermResp |
| `kd/bos/portal` | 15 | BasLoginConfigParam、BillStatsCardCustomFilter、BrandUpEnum、CardCountType、CardInfo |
| `kd/bos/portal/pluginnew` | 1 | BizAppHomeAbstract |
| `kd/bos/print` | 17 | BosPrintServiceHelper、BosPrintServiceHelper$TplInfo、FieldScanner、FileStorageType、IPrintWorkExt |
| `kd/bos/print/api` | 2 | PrintMetadata、SerializeUtils |
| `kd/bos/print/api/metedata` | 1 | Barcode |
| `kd/bos/print/business` | 1 | PrintMetadataUtil |
| `kd/bos/print/business/metedata/service` | 1 | PrintTplImpExp |
| `kd/bos/print/core` | 8 | AbstractPrintPlugin、CurrencyFormat、DataRowSet、IPrintPlugin、PFileStorageType |
| `kd/bos/print/core/data` | 22 | BigIntegerField、CollectionField、CustomDataSource、DateField、DateTimeField |
| `kd/bos/print/core/data/datasource` | 1 | SortField |
| `kd/bos/print/core/execute/render/common/linewrap` | 1 | LineWrapRule |
| `kd/bos/print/core/model` | 1 | StyleKey |
| `kd/bos/print/core/model/designer` | 1 | MergeBlock |
| `kd/bos/print/core/model/widget` | 1 | AbstractPWGridCell |
| `kd/bos/print/core/plugin` | 17 | AfterLoadDataEvent、AfterOutputGridEvent、AfterOutputRowEvent、AfterOutputWidgetEvent、BeforeExportEvent |
| `kd/bos/print/core/plugin/event` | 7 | IPrintEventBo、PluginDataVisitorBo、PWGridBo、PWGridCellBo、PWGridColumnBo |
| `kd/bos/print/core/plugin/event/bo` | 2 | NegativeTypeEnum、TextFormatEnum |
| `kd/bos/privacy` | 5 | DesenContextArgs、DesenOperateType、DesenStrategy、IDesenPlugin、PrivacyCenterService |
| `kd/bos/report` | 23 | AbstractReportFormPlugin、CellStyleRule、ColHeadFilterClickEvent、CreateColumnEvent、CreateFilterInfoEvent |
| `kd/bos/schedule` | 38 | AbstractJobHandler、AbstractTask、AbstractTaskClick、BackgroundTaskSubscriber、BroadcastTask |
| `kd/bos/schedule/dao` | 1 | DbJobOperation |
| `kd/bos/schedule/form` | 2 | ClickEventArgs、ItemClickEventArgs |
| `kd/bos/schedule/server` | 1 | CronStruct |
| `kd/bos/service` | 13 | AttachmentServiceImpl、Donothing、EarlyWarnServiceImpl、EntityOperateService、IAttachmentOperateService |
| `kd/bos/service/attachment/extend` | 3 | FileImportExtensionFactory、FilePermissionExtensionFactory、IFileImportExtension |
| `kd/bos/service/metadata` | 1 | GzipUtils |
| `kd/bos/service/operation` | 5 | BaseDataDeleteValidator、ConditionValidator、DataMutexResult、MutexValidator、ValidationService |
| `kd/bos/servicehelper` | 63 | AduitLogServiceHelper、ApiOperationServiceHelper、AppMetaServiceHelper、AssistantDataServiceHelper、AttachmentFieldSaveDto |
| `kd/bos/servicehelper/billtype` | 1 | BillTypeFile |
| `kd/bos/servicehelper/org` | 1 | OrgViewTypeEnum |
| `kd/bos/servicehelper/permission` | 1 | NoCodePermissionServiceHelper |
| `kd/bos/servicehelper/print` | 1 | ReportDataProvider |
| `kd/bos/svc` | 5 | AttachmentModule、CAModule、CodeRuleModule、EarlyWarnModule、PrintModule |
| `kd/bos/svc/attachment` | 1 | ThirdPreviewAndEditServiceFactory |
| `kd/bos/svc/attachment/wps` | 1 | WpsAttachAction |
| `kd/bos/sysint` | 1 | PortalAppFeaturesCache |
| `kd/bos/sysint/servicehelper` | 1 | LocationConst |
| `kd/bos/template/orgctrl` | 2 | ParamUtils、PrintTemplateServiceFactory |
| `kd/bos/trace` | 1 | MemSpanTrace |
| `kd/bos/unifiedthreadpool` | 5 | PoolRejectedExecutionHandler、ThreadExecutorService、ThreadPoolFactory、ThreadPoolStrategy、ThreadPoolStrategyFactory |
| `kd/bos/util` | 3 | DBHintContext、ResourceModule、Resources |
| `kd/bos/web` | 2 | AttachmentAction、ImageAction |
| `kd/bos/web/actions` | 3 | ExportSheetStyle、ExportWriter、ExportWriterFormat |
| `kd/bos/workflow` | 23 | AgentExecution、AgentTask、BatchResult、BatchResult$ItemResult、BizProcessStatus |
| `kd/bos/workflow/api` | 13 | CompleteTaskParam、MacroItem、NodeMacro、NodeProperty、ProcessDefinitionInfo |
| `kd/bos/workflow/bpmn` | 5 | BillSetting、DecisionOption、FlowElement、FlowElementsContainer、Variable |
| `kd/bos/workflow/component` | 4 | CustomizeLink、IApprovalRecord、IApprovalRecordGroup、IApprovalRecordItem |
| `kd/bos/workflow/design` | 1 | IWorkflowDesigner |
| `kd/bos/workflow/engine` | 26 | AddSignInfo、AggregateInfo、AggregateResult、BatchOperateResult、BizType |
| `kd/bos/workflow/engine/dynprocess` | 15 | WFAuditTask、WFAutoTask、WFAutoTaskExtItf、WFBillSetting、WFCustomParam |
| `kd/bos/workflow/engine/impl/persistence/entity` | 2 | ModelType、TaskCenterNavigationEntity |
| `kd/bos/workflow/engine/impl/persistence/entity/task` | 3 | ApprovalRecord、ApprovalRecordGroup、ApprovalRecordItem |
| `kd/bos/workflow/engine/msg` | 15 | AbstractServiceHandler、DingdingServiceHandler、EmailServiceHandler、ITaskMsg、MessageAttachment |
| `kd/bos/workflow/engine/rule` | 1 | IExtExpressionParse |
| `kd/bos/workflow/engine/task` | 7 | CirculateOperationParam、CompleteOperationParam、DeleteOperationParam、TaskOperationInfo、TaskOperationParam |
| `kd/bos/workflow/management` | 1 | ApprovalPageTpl |
| `kd/bos/workflow/message` | 3 | IMessageCenterService、MsgTypeEnum、SmsUsingQuantities |
| `kd/bos/workflow/message/service/api` | 1 | MessageInfoModel |
| `kd/bos/workflow/taskcenter/plugin` | 3 | BeforeSubmitCustomEventArgs、BeforeSubmitCustomEventArgsClosedCallBack、NextUserTaskNode |
| `kd/bos/xdb` | 5 | DBHighBatchContext、HintCondition、NoShardingHint、ShardingHintContext、ShardingMetadataService |
| `kd/bos/xdb/sharding` | 1 | BaseCustomStrategy |
| `kd/bos/xdb/sharding/strategy/map` | 2 | AbstractValueMapper、ValueMapper |
| `kd/bos/zip` | 2 | ModelModule、ZipParameters |
| `kd/bos/zip/io` | 2 | OutputStreamModule、ZipOutputStream |
| `kd/sdk` | 5 | Module、Plugin、Service、ServiceLoader、SPIConfigurationException |
| `kd/sdk/bos` | 1 | LogFactory |

## @cosmic/bos-script

| 包 | 类型导出数 | 示例类型 |
|----|------------|----------|
| `java` | 228 | AbstractCollection、AbstractList、AbstractMap、AbstractSequentialList、AbstractSet |
| `java/awt` | 83 | ActionEvent、ActionListener、AffineTransform、AWTEventListener、BufferedImage |
| `java/awt/image` | 2 | RenderableImage、RenderContext |
| `java/lang` | 2 | Annotation、Reference |
| `java/nio` | 2 | AccessMode、LinkOption |
| `java/security` | 3 | AlgorithmParameterSpec、Certificate、CertPath |
| `java/time` | 25 | AbstractChronology、ChronoField、ChronoLocalDate、ChronoLocalDateTime、Chronology |
| `java/util` | 64 | BaseStream、BiConsumer、BiFunction、BinaryOperator、Callable |
| `java/util/concurrent` | 1 | AtomicReference |
| `javax` | 19 | Accessible、AccessibleAction、AccessibleBundle、AccessibleComponent、AccessibleContext |
| `javax/security` | 2 | Destroyable、Subject |
| `javax/servlet` | 3 | HttpServletRequest、HttpServletResponse、HttpSession |
| `javax/swing` | 2 | AttributeSet、TreePath |
| `javax/xml` | 7 | Location、NamespaceContext、QName、Result、Source |
| `org` | 5 | Assert、Capture、EasyMock、EasyMockSupport、MockType |
| `org/w3c` | 19 | Attr、CDATASection、CharacterData、Comment、Document |
| `org/xml` | 10 | Attributes、ContentHandler、DTDHandler、EntityResolver、ErrorHandler |
| `org/xml/sax` | 2 | DefaultHandler、LexicalHandler |

