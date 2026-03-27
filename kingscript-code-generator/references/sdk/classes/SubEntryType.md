# SubEntryType

## 基本信息

- 名称: `SubEntryType`
- Java 类名: `kd.bos.entity.SubEntryType`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity`
- 类型: 子分录实体类型

## 用途概览

`SubEntryType` 描述的是子分录的元数据结构，常见于多层明细、套件明细、费用拆分等场景。二开里只要出现“分录里还有一层分录”，通常就需要回到它这层确认结构。

## 典型场景

- 子分录字段判断
- 子分录和父分录的关系确认
- 嵌套分录调试

## 常见搭配

- 子分录控件: [SubEntryGrid.md](SubEntryGrid.md)
- 分录类型: [EntryType.md](EntryType.md)
- 元数据基类: [EntityType.md](EntityType.md)

## 关键词

- 中文: 子分录类型, 子单据体元数据
- 英文: `SubEntryType`
