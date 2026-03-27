# SDK 插件与扩展点索引

这个文件用于回答一个问题：某个插件类型或扩展点应该去哪里找对应 SDK。

## 使用方式

- 用户问“某种插件能用哪些接口”
- 用户知道插件场景，不知道对应扩展点名称
- 用户需要从插件类型反查可用 SDK

## 推荐组织方式

- 按插件类型分组
  - 表单
  - 单据
  - 列表
  - 报表
  - 调度
  - 工作流
  - 打印
  - 引入引出
- 每组列出：
  - 常用基类
  - 高频事件
  - 高频扩展点接口
  - 相关示例
  - 常见坑

## 建设建议

- 与 `references/examples/plugins/` 保持互链
- 与 `references/examples/plugins/` 保持互链

## 当前高频插件类型入口

### 表单插件

- 常用基类：
  - `AbstractFormPlugin`
  - `AbstractBillPlugIn`
- 高频事件：
  - `preOpenForm`
  - `beforeBindData`
  - `afterBindData`
  - `registerListener`
  - `beforeFieldPostBack`
  - `closedCallBack`
  - `timerElapsed`
  - `pageRelease`
  - `setWaterMarkInfo`
  - `beforeDoCheckDataPermission`
- 相关 SDK：
  - `packages/kd-bos-form-events.md`
  - `classes/BeforeFieldPostBackEvent.md`
  - `classes/BeforeDoCheckDataPermissionArgs.md`
- 相关示例：
  - `references/examples/plugins/插件示例/表单插件-事件拆分/`

### 基础资料控件 / F7

- 常用基类：
  - `BasedataEdit`
  - `BasedataEditListener`
- 高频事件：
  - `beforeF7Select`
  - `afterF7Select`
  - `beforeFilterF7Select`
  - `beforeQuickAddNew`
- 相关 SDK：
  - `packages/kd-bos-form-field-events.md`
  - `classes/BeforeF7SelectEvent.md`
  - `classes/AfterF7SelectEvent.md`
  - `classes/BeforeFilterF7SelectEvent.md`
- 相关示例：
  - `references/examples/plugins/插件示例/基础资料控件-事件拆分/`

### 列表插件

- 常用基类：
  - `BillList`
  - `ListView`
- 高频事件：
  - `listBeforeBindData`
  - `beforePackageData`
  - `dataSelect`
  - `billClosedCallBack`
- 相关 SDK：
  - `packages/kd-bos-list-events.md`
  - `classes/BeforePackageDataEvent.md`
  - `classes/BillClosedCallBackEvent.md`
- 相关示例：
  - `references/examples/plugins/插件示例/列表插件-事件拆分/`
