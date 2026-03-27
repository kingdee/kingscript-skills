# SDK 报错索引

这个文件用于从“报错现象”反查最可能相关的 SDK 卡片、示例和第一排查入口。

## 使用方式

- 用户贴出了具体报错文本时，先按关键词匹配本索引。
- 用户没有贴栈信息，只描述“找不到包”“类型不对”“调试起不来”时，也先从这里缩小范围。
- 先定位问题落在哪一层：导入与打包、运行时上下文、序列化、查询过滤、数值/日期、页面生命周期。

## 高频报错条目

### 1. 依赖包无法识别 / 找不到模块

- 常见现象
  - `Cannot find module '@cosmic/bos-core/...'`
  - `找不到包 kd/bos/...`
  - import 路径提示不存在
- 优先排查
  - import 路径是否与模板中的标准路径一致
  - 当前脚本是不是用了错误的插件基类
  - 安装的 skill 是否包含 `references/` 和平台入口文件
- 推荐先看
  - [references/templates/README.md](../templates/README.md)
  - [AbstractFormPlugin.md](../classes/AbstractFormPlugin.md)
  - [AbstractBillPlugIn.md](../classes/AbstractBillPlugIn.md)
  - [package-index.md](package-index.md)

### 2. 引擎未初始化 / 插件未生效 / 页面打开后没有任何反应

- 常见现象
  - 脚本加载了但事件不触发
  - 页面打开正常，插件方法完全没有进入
  - 控制台提示脚本入口异常或实例未导出
- 优先排查
  - 文件末尾是否正确 `export { plugin }`
  - 实例名是否和模板保持一致
  - 插件挂载类型是否和页面/操作场景一致
- 推荐先看
  - [references/templates/form-plugin-template.md](../templates/form-plugin-template.md)
  - [references/templates/bill-plugin-template.md](../templates/bill-plugin-template.md)
  - [references/templates/list-plugin-template.md](../templates/list-plugin-template.md)
  - [plugin-index.md](plugin-index.md)

### 3. QFilter 类型转换错误 / 过滤条件不生效

- 常见现象
  - `ClassCastException`
  - `类型转换错误`
  - 查询条件写了但结果明显不对
- 优先排查
  - 比较值类型是否和字段真实类型一致
  - 基础资料、组织、枚举字段是否误传成字符串
  - F7 过滤事件里是追加过滤还是覆盖过滤
- 推荐先看
  - [QFilter.md](../classes/QFilter.md)
  - [BeforeF7SelectEvent.md](../classes/BeforeF7SelectEvent.md)
  - [BeforeFilterF7SelectEvent.md](../classes/BeforeFilterF7SelectEvent.md)
  - [beforeF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeF7Select.md)
  - [beforeFilterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeFilterF7Select.md)

### 4. 长整型精度丢失 / 单号或 ID 变形

- 常见现象
  - 大整数尾数被改写
  - 单据 ID、基础资料 ID 变成科学计数法
  - 传输后比对主键失败
- 优先排查
  - 是否把长整型主键直接当普通 `number` 使用
  - 是否在 JSON 序列化前做了字符串保护
  - 前后端传值过程中是否做了隐式数值转换
- 推荐先看
  - [BigDecimal.md](../classes/BigDecimal.md)
  - [SerializationUtils.md](../classes/SerializationUtils.md)
  - [RequestContext.md](../classes/RequestContext.md)

### 5. 序列化 / 反序列化失败

- 常见现象
  - `NotSerializableException`
  - `反序列化失败`
  - 页面回调、任务消息、缓存对象恢复失败
- 优先排查
  - 传递对象是否包含运行时上下文、视图对象或不可序列化句柄
  - 是否把页面对象直接塞进任务消息、缓存或扩展参数
  - 序列化边界是否该改成传主键、字段值或 DTO
- 推荐先看
  - [SerializationUtils.md](../classes/SerializationUtils.md)
  - [CloseCallBack.md](../classes/CloseCallBack.md)
  - [ClosedCallBackEvent.md](../classes/ClosedCallBackEvent.md)

### 6. 关闭回调不触发 / 回调数据为空

- 常见现象
  - 子页面关闭后 `closedCallBack` 或 `billClosedCallBack` 不进
  - `getReturnData()` 返回空
  - 列表打开单据后关闭没有刷新
- 优先排查
  - 打开页面时是否显式设置了回调对象
  - `actionId` 是否前后保持一致
  - 用户是否直接关闭页面导致没有返回有效数据
- 推荐先看
  - [ClosedCallBackEvent.md](../classes/ClosedCallBackEvent.md)
  - [BillClosedCallBackEvent.md](../classes/BillClosedCallBackEvent.md)
  - [closedCallBack.md](../../examples/plugins/插件示例/表单插件-事件拆分/closedCallBack.md)
  - [billClosedCallBack.md](../../examples/plugins/插件示例/列表插件-事件拆分/billClosedCallBack.md)

### 7. 字段联动不触发 / propertyChanged 没进

- 常见现象
  - 页面字段改了，但服务端联动没执行
  - `propertyChanged`、`beforePropertyChanged` 不触发
  - 调了 `setCancel(true)` 后后续逻辑消失
- 优先排查
  - 是否在 `beforeFieldPostBack` 中取消了字段回传
  - 当前字段是否只是前端展示字段，没有绑定到模型
  - 联动逻辑写在页面事件还是模型事件，层级是否搞混
- 推荐先看
  - [BeforeFieldPostBackEvent.md](../classes/BeforeFieldPostBackEvent.md)
  - [IDataModelChangeListener.md](../classes/IDataModelChangeListener.md)
  - [beforeFieldPostBack.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeFieldPostBack.md)

### 8. 页面关闭被拦住 / 未保存提示异常

- 常见现象
  - 页面明明没改数据，却一直弹未保存提示
  - 关闭事件中取消和脏检查行为不符合预期
  - 页面释放和关闭拦截逻辑互相干扰
- 优先排查
  - 是否在 `beforeClosed` 中错误设置了 `setCheckDataChange`
  - 是否把 `beforeClosed` 和 `pageRelease` 的职责写反
  - 是否存在未绑定物理字段导致的脏数据误判
- 推荐先看
  - [BeforeClosedEvent.md](../classes/BeforeClosedEvent.md)
  - [beforeClosed.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeClosed.md)
  - [pageRelease.md](../../examples/plugins/插件示例/表单插件-事件拆分/pageRelease.md)

## 使用建议

- 先按报错现象缩小范围，再跳到类卡或示例确认触发边界。
- 没有精确报错文本时，优先根据“在哪个插件类型里出错”回跳到 `plugin-index.md`。
- 如果本索引没有命中，再继续走 `keyword-index.md`、`method-index.md` 和 `manifests/`。
