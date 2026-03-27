# EntityMetadataCache

## 基本信息

- 名称: `EntityMetadataCache`
- Java 类名: `kd.bos.entity.EntityMetadataCache`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity`
- 类型: 实体元数据缓存入口

## 用途概览

`EntityMetadataCache` 用来按实体标识读取和复用元数据，减少重复加载和重复解析。它更适合做元数据级工具、调试辅助、通用框架代码，不适合直接当业务事件入口。

## 什么时候会用到

- 需要按实体编码加载 `MainEntityType` / `EntityType`
- 写通用查询、导入、转换工具
- 做“字段是否存在 / 字段类型是什么”的统一判断

## 高价值规则

- 它是缓存入口，不是业务数据入口。
- 用它拿到的依然是元数据对象，后续通常还要配合 `DynamicObject` 或模型层 API。
- 二开问“某实体有哪些字段、哪些是分录、哪些是基础资料”时，这类缓存入口比页面事件更可靠。

## 常见搭配

- 主实体类型: [MainEntityType.md](MainEntityType.md)
- 元数据基类: [EntityType.md](EntityType.md)
- 动态对象: [DynamicObject.md](DynamicObject.md)

## 关键词

- 中文: 元数据缓存, 实体缓存, 实体定义缓存
- 英文: `EntityMetadataCache`
