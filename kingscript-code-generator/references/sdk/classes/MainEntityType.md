# MainEntityType

## 基本信息

- 名称: `MainEntityType`
- Java 类名: `kd.bos.entity.MainEntityType`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity`
- 类型: 单据头主实体类型

## 用途概览

`MainEntityType` 是单据头或主业务对象对应的实体类型。它通常是 `getDataEntity().getDataEntityType()` 拿到的第一层元数据入口，适合用来确认单据头字段、分录关系和实体别名。

## 典型场景

- 通用工具里判断当前单据头有哪些字段
- 动态根据主实体元数据决定是否补默认值
- 排查“字段明明存在但运行时报找不到”这类元数据问题

## 常见搭配

- 元数据基类: [EntityType.md](EntityType.md)
- 动态数据对象: [DynamicObject.md](DynamicObject.md)
- 元数据缓存: [EntityMetadataCache.md](EntityMetadataCache.md)

## 关键词

- 中文: 主实体, 单据头类型, 主表元数据
- 英文: `MainEntityType`
