# IDataModelListener

## 基本信息

- 名称：`IDataModelListener`
- Java 类名：`kd.bos.entity.datamodel.events.IDataModelListener`
- TS 导出名：`IDataModelListener`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity/datamodel/events`
- 类型：模型初始化监听接口
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/entity/datamodel/events` 相关声明核对
  - 相关示例：[表单插件.md](../../examples/plugins/插件示例/表单插件.md)
  - 相关案例：[createNewData.md](../../examples/plugins/插件示例/表单插件-事件拆分/createNewData.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

负责数据包创建、复制、引入和加载阶段的模型初始化逻辑，适合处理默认值、默认分录、复制清理和引入前后修正。

## 典型场景

- `createNewData` 中自定义构建初始数据包
- `afterCreateNewData` 中追加默认值和默认分录
- `afterCopyData` 中清理来源单据痕迹
- `beforeImportData` / `afterImportData` 中修正引入数据

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `createNewData` | 创建数据包 | `BizDataEventArgs` | `void` | 平台默认建空白数据包前的自定义入口 |
| `afterCreateNewData` | 创建后补默认值 | `EventObject` | `void` | 常用于增加默认分录行 |
| `loadData` | 自定义加载数据包 | `LoadDataEventArgs` | `void` | 页面装载数据库数据时使用 |
| `afterCopyData` | 复制后清理或重置 | `EventObject` | `void` | 常用于清审批和关联信息 |
| `beforeImportData` | 引入前修正数据源 | `BeforeImportDataEventArgs` | `void` | 可取消单据引入 |
| `afterImportData` | 引入后保存前收口 | `ImportDataEventArgs` | `void` | 适合做最终清洗 |

## 运行时注意事项

- `createNewData` 和 `afterCreateNewData` 分工不同，前者偏构造，后者偏补齐。
- 引入、复制、下推、新建都可能进入不同的初始化链路，不要假设只走一个入口。
- 如果复制或引入后需要清空来源痕迹，优先在模型初始化阶段做，而不是等到页面绑定后再改。
- TS 类型只能说明结构，不能替代运行时对单据状态、组织和权限的判断。

## 常见搭配

- 搭配类：`BizDataEventArgs`、`LoadDataEventArgs`、`AbstractFormDataModel`
- 搭配示例：
  - [createNewData.md](../../examples/plugins/插件示例/表单插件-事件拆分/createNewData.md)
  - [preOpenForm.md](../../examples/plugins/插件示例/表单插件-事件拆分/preOpenForm.md)
- 搭配 FAQ：
  - 默认分录应该在哪创建
  - 复制单据怎么清审批信息

## 常见错误

### 1. 把复制或引入修正放到页面绑定后

高概率原因：
- 没区分模型初始化阶段和页面展示阶段
- 想当然认为页面绑定后改值更直观

### 2. 自定义创建数据包后又依赖平台默认值

高概率原因：
- `createNewData` 完全接管后，没有补齐必须字段
- 对默认值生成机制理解不完整

## 相关示例

- [表单插件.md](../../examples/plugins/插件示例/表单插件.md)
- [createNewData.md](../../examples/plugins/插件示例/表单插件-事件拆分/createNewData.md)

## 关键词

- 中文关键词：模型初始化监听、新建数据包、复制数据包、引入数据
- 英文关键词：`IDataModelListener`
- 常见别名：初始化监听、数据包监听
- 常见报错词：默认值没带出、复制后状态错误、引入后字段丢失
