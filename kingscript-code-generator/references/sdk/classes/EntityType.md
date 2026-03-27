# EntityType

## 基本信息

- 名称: `EntityType`
- Java 类名: `kd.bos.entity.EntityType`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity`
- 类型: 实体元数据基类

## 用途概览

`EntityType` 表示一个业务实体的元数据定义。字段列表、主键、显示名、父子关系、子实体切片等能力都在这一层。它更偏“元数据”和“结构说明”，不是实际数据对象。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `getName()` | 获取实体名称 | 打日志、调试元数据 |
| `getFields()` | 获取字段字典 | 判断字段是否存在 |
| `findProperty(name)` | 查字段元数据 | 动态判断字段类型 |
| `getPrimaryKey()` | 获取主键字段 | 主键处理、通用工具 |
| `getSubEntityType(props)` | 派生子实体类型 | 裁剪字段、局部处理 |

## 高价值规则

- `EntityType` 是“结构”，`DynamicObject` 是“数据”，两者不要混用。
- 当你在写通用工具、桥接代码或复杂调试时，`EntityType` 的价值会比页面事件更高。
- 如果问题是“字段到底是不是基础资料/弹性域/分录字段”，优先回到元数据层确认。

## 常见搭配

- 主实体类型: [MainEntityType.md](MainEntityType.md)
- 分录类型: [EntryType.md](EntryType.md)
- 元数据缓存: [EntityMetadataCache.md](EntityMetadataCache.md)

## 关键词

- 中文: 实体类型, 元数据, 字段定义
- 英文: `EntityType`
