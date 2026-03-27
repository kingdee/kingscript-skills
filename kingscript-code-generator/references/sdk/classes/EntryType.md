# EntryType

## 基本信息

- 名称: `EntryType`
- Java 类名: `kd.bos.entity.EntryType`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity`
- 类型: 单据体分录实体类型

## 用途概览

`EntryType` 描述的是分录实体的元数据，比如分录字段、分录显示名、主外键关系、子分录结构等。它解决的是“这条分录长什么样”，不是“这条分录现在有什么值”。

## 高频问法

- 分录字段元数据怎么拿
- 当前分录实体是不是某个 entry
- 分录和子分录的类型怎么区分
- 通用分录工具怎么判断字段类型

## 运行时注意事项

- 页面层 `EntryGrid` 更关注交互；`EntryType` 更关注结构。
- 当你处理批量导入、分录复制、通用分录校验时，`EntryType` 比控件对象更稳定。
- 如果只想拿当前行值，优先还是 `getEntryEntity(...)`；不要为了读值绕到元数据层。

## 常见搭配

- 分录控件: [EntryGrid.md](EntryGrid.md)
- 分录集合: [DynamicObjectCollection.md](DynamicObjectCollection.md)
- 子分录类型: [SubEntryType.md](SubEntryType.md)

## 关键词

- 中文: 分录类型, 单据体类型, 分录元数据
- 英文: `EntryType`
