# PropertyChangedArgs

## 基本信息

- 名称: `PropertyChangedArgs`
- Java 类名: `kd.bos.entity.datamodel.events.PropertyChangedArgs`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/datamodel/events`
- 类型: 字段变化事件参数

## 用途概览

`PropertyChangedArgs` 是数据模型层字段变化的核心参数。它比页面事件更靠近模型，适合处理字段联动、批量变化和分录级变更。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `getProperty()` | 取发生变化的字段 | 判断当前联动入口 |
| `getChangeSet()` | 取变化数据集合 | 批量改值、分录联动 |
| `getVarMap()` | 取表达式变量 | 条件计算或规则扩展 |

## 运行时注意事项

- `getChangeSet()` 可能不止一条，批量变化时不要只取第一条。
- 它描述的是“模型值变化”，不等于“客户端交互事件”。
- 如果问题本质是字段回传、F7、关闭回调，优先看页面事件；如果问题本质是数据模型联动，再看它。

## 常见搭配

- 变化明细: [ChangeData.md](ChangeData.md)
- 数据模型监听器: [IDataModelChangeListener.md](IDataModelChangeListener.md)

## 关键词

- 中文: 字段变化参数, 属性变化, 模型联动
- 英文: `PropertyChangedArgs`
