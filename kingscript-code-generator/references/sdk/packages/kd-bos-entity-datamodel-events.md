# kd/bos/entity/datamodel/events

## 基本信息

- 包名：`kd/bos/entity/datamodel/events`
- 所属模块：`@cosmic/bos-core`
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/entity/datamodel/events` 相关声明核对
  - Javadoc：Cosmic V8.0.1

## 包职责

集中承载模型层事件参数和监听接口，覆盖字段值变化、分录增删改、数据包初始化、引入和列表数据格式化等高频事件。

## 高频类与接口

| 名称 | 类型 | 典型用途 | 文档状态 |
|------|------|----------|----------|
| `IDataModelChangeListener` | 接口 | 字段变化、分录增删改、批量赋值 | 已补类卡 |
| `IDataModelListener` | 接口 | 新建、复制、引入、加载数据包 | 已补类卡 |
| `ChangeData` | 类 | 读取变化字段的新旧值和行索引 | 已补类卡 |
| `BeforePackageDataEvent` | 类 | 列表显示前格式化数据集合 | 已补类卡 |
| `BeforeImportDataEventArgs` | 类 | 引入前校验或调整数据 | 待补 |
| `BeforeDeleteRowEventArgs` | 类 | 删除分录前校验和拦截 | 待补 |

## 常见场景

- `propertyChanged` 中根据 `ChangeData` 做联动计算
- `createNewData` / `afterCreateNewData` 中补默认值和默认分录
- 引入、复制、下推时修正默认字段或清理继承值
- 列表显示前对 `pageData` 做脱敏、补图或补统计字段

## 常见风险

- 在 `propertyChanged` 中回滚字段，导致其他已触发逻辑无法同步回滚
- 忽略 `isSupportBatchPropChanged()`，导致批量选择或批量赋值性能差
- 把列表格式化事件误当成单据模型事件使用
- 不区分初始化变更和用户交互变更

## 相关示例与 FAQ

- 示例：
  - [beforePropertyChanged.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforePropertyChanged.md)
  - [propertyChanged.md](../../examples/plugins/插件示例/表单插件-事件拆分/propertyChanged.md)
  - [createNewData.md](../../examples/plugins/插件示例/表单插件-事件拆分/createNewData.md)
- FAQ：
  - 批量字段变更怎么处理
  - 引入和新建该写哪个事件
  - 列表显示字段怎么在绑定前补齐
