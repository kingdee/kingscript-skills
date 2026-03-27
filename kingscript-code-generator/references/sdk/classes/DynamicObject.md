# DynamicObject

## 基本信息

- 名称: `DynamicObject`
- Java 类名: `kd.bos.dataentity.entity.DynamicObject`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/dataentity/entity`
- 类型: 动态实体对象

## 用途概览

`DynamicObject` 是 Kingscript 二开里最常见的数据载体。单据头、分录行、基础资料引用值、查询结果行，很多最终都会落到它或它的集合上。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `get(propertyName)` | 按字段标识取值 | 读取头字段或引用字段 |
| `set(propertyName, value)` | 按字段标识赋值 | 补默认值、改状态、写结果 |
| `getDynamicObject(propertyName)` | 取引用字段实体 | 基础资料、组织、人员等 |
| `getDynamicObjectCollection(propertyName)` | 取分录集合 | 遍历和维护分录行 |
| `getPkValue()` | 取主键 | 回写、日志、关联判断 |
| `getDataEntityType()` | 取实体类型 | 做元数据或泛型判断 |

## 运行时注意事项

- `get(...)` 返回的通常是 Java 对象，不要想当然当成原生 JS 对象处理。
- `Long`、`BigDecimal`、`Date` 这类值要按 Java 对象方式用，尤其不要直接按 JS number 精度处理长整型。
- 引用字段常常拿到的是子 `DynamicObject`，不是直接字符串。
- 分录字段一般要先取 `DynamicObjectCollection`，再逐行读写。

## 常见搭配

- 分录遍历: [DynamicObjectCollection.md](DynamicObjectCollection.md)
- 字段联动参数: [PropertyChangedArgs.md](PropertyChangedArgs.md)
- 操作结果处理: [OperationResult.md](OperationResult.md)

## 关键词

- 中文: 动态实体, 数据包, 字段取值, 字段赋值, 分录遍历
- 英文: `DynamicObject`
