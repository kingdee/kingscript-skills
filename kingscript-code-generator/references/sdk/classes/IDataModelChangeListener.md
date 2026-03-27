# IDataModelChangeListener

## 基本信息

- 名称：`IDataModelChangeListener`
- Java 类名：`kd.bos.entity.datamodel.events.IDataModelChangeListener`
- TS 导出名：`IDataModelChangeListener`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity/datamodel/events`
- 类型：模型变更监听接口
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/entity/datamodel/events` 相关声明核对
  - 相关示例：[表单插件.md](../../examples/plugins/插件示例/表单插件.md)
  - 相关案例：[表单插件-事件拆分/README.md](../../examples/plugins/插件示例/表单插件-事件拆分/README.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

统一承接字段值变化、分录增删改、批量填充和分录移动等模型层事件，是单据联动、分录汇总和批量赋值性能优化的核心入口。

## 典型场景

- `beforePropertyChanged` 中阻止非法赋值
- `propertyChanged` 中根据新值联动金额、税额或状态
- 分录删除、移动、批量填充后重算合计
- 通过 `isSupportBatchPropChanged()` 打开批量值更新能力

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `beforePropertyChanged` | 字段变更前拦截 | `PropertyChangedArgs` | `void` | 可取消本次修改 |
| `propertyChanged` | 字段变更后联动 | `PropertyChangedArgs` | `void` | 常与 `ChangeData` 配合读取变化集 |
| `initPropertyChanged` | 初始化阶段字段变更 | `PropertyChangedArgs` | `void` | 下推、复制、引入时常见 |
| `beforeDeleteRow` / `afterDeleteRow` | 删除分录前后处理 | 对应事件参数 | `void` | 常用于校验与重算 |
| `beforeBatchFillEntry` | 批量填充分录前处理 | `BeforeBatchFillEntryArgs` | `void` | 常用于金额预估和额度校验 |
| `isSupportBatchPropChanged` | 是否启用批量值更新 | 无 | `boolean` | 批量选择基础资料时影响性能 |

## 运行时注意事项

- `propertyChanged` 支持批量触发，不要默认只处理第一条变更。
- 不建议在 `propertyChanged` 中回滚字段值，容易和其他已触发逻辑冲突。
- `initPropertyChanged` 和用户交互触发的 `propertyChanged` 不是同一个时机。
- TS 声明存在不代表所有事件在当前插件类型和页面场景都一定触发。

## 常见搭配

- 搭配类：`ChangeData`、`AbstractFormDataModel`、`AbstractBillPlugIn`
- 搭配示例：
  - [beforePropertyChanged.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforePropertyChanged.md)
  - [propertyChanged.md](../../examples/plugins/插件示例/表单插件-事件拆分/propertyChanged.md)
- 搭配 FAQ：
  - 批量选择资料为什么很慢
  - 联动计算写在哪个事件

## 常见错误

### 1. 只处理第一条变更

高概率原因：
- 把 `e.getChangeSet()` 当成单条数据用
- 忽略批量赋值和批量选择场景

### 2. 在错误阶段做联动

高概率原因：
- 初始化阶段逻辑写进了用户交互阶段
- 页面事件和模型事件没有分层

## 相关示例

- [表单插件.md](../../examples/plugins/插件示例/表单插件.md)
- [propertyChanged.md](../../examples/plugins/插件示例/表单插件-事件拆分/propertyChanged.md)

## 关键词

- 中文关键词：模型变更监听、字段联动、分录事件、批量值更新
- 英文关键词：`IDataModelChangeListener`
- 常见别名：字段变化监听、分录监听
- 常见报错词：字段联动不生效、批量赋值很慢、分录汇总不更新
