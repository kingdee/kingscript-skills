# kd/bos/form/events

## 基本信息

- 包名：`kd/bos/form/events`
- 所属模块：`@cosmic/bos-core`
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/events` 相关声明核对
  - Javadoc：Cosmic V8.0.1

## 包职责

承接表单插件生命周期、页面回调、操作前后事件和页面交互前置校验，是 `AbstractFormPlugin` 与 `AbstractBillPlugIn` 最常用的事件参数包之一。

## 高频类与接口

| 名称 | 类型 | 典型用途 | 文档状态 |
|------|------|----------|----------|
| `BeforeFieldPostBackEvent` | 类 | 控制字段值是否回传服务器 | 已补类卡 |
| `BeforeDoCheckDataPermissionArgs` | 类 | 数据权限检查前拦截或跳过 | 已补类卡 |
| `BeforeDoOperationEventArgs` | 类 | 按操作键拦截保存、提交、审核 | 已补类卡 |
| `AfterDoOperationEventArgs` | 类 | 操作成功后刷新界面或跳转 | 已补类卡 |
| `BeforeBindDataEvent` | 类 | 页面绑定前初始化 | 已补类卡 |
| `AfterBindDataEvent` | 类 | 页面绑定后回写显示状态 | 已补类卡 |
| `BeforeClosedEvent` | 类 | 页面关闭前确认或拦截 | 已补类卡 |

## 常见场景

- 页面字段变更较多，想减少无意义字段回传
- 表单操作前，需要决定是否跳过数据权限或返回自定义提示
- 页面绑定前后按状态控制按钮、控件和提示信息
- 页面关闭前校验未保存数据或释放资源

## 常见风险

- 误把页面事件当成模型事件，导致在错误生命周期里写逻辑
- 取消字段回传后，还期待服务端 `propertyChanged` 被触发
- 直接跳过数据权限检查，却没有补充角色边界和风险说明
- 在表单事件里混入大量业务数据处理，导致页面逻辑和模型逻辑耦合

## 相关示例与 FAQ

- 示例：
  - [表单插件-事件拆分/README.md](../../examples/plugins/插件示例/表单插件-事件拆分/README.md)
  - [beforeFieldPostBack.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeFieldPostBack.md)
- FAQ：
  - 字段回传写在哪
  - 权限校验前能不能跳过
  - 页面级事件和模型级事件怎么区分
