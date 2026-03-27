# SubEntryGrid

## 基本信息

- 名称: `SubEntryGrid`
- Java 类名: `kd.bos.form.control.SubEntryGrid`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/form/control`
- 类型: 子单据体表格控件

## 用途概览

`SubEntryGrid` 用来处理“分录中的子分录”这类两层明细结构。它的关注点和 `EntryGrid` 类似，但适用的是子明细、子服务行、子费用行这类嵌套表格。

## 高频问法

- 子分录怎么拿当前行
- 子分录怎么锁定某几行
- 主分录切换后怎么刷新子分录
- 子分录控件和 `SubEntryType` 是什么关系

## 运行时注意事项

- `SubEntryGrid` 负责界面层，真正的子分录数据结构还是落在 `DynamicObjectCollection` 和 `SubEntryType` 上。
- 主分录行切换时，子分录上下文也会跟着变化，调试时要先确认当前父行。
- 子分录经常和联动刷新一起出现，问题定位要分清是控件刷新问题还是模型数据问题。

## 常见搭配

- 子分录类型: [SubEntryType.md](SubEntryType.md)
- 分录控件: [EntryGrid.md](EntryGrid.md)
- 分录集合: [DynamicObjectCollection.md](DynamicObjectCollection.md)

## 关键词

- 中文: 子单据体, 子分录, 嵌套分录
- 英文: `SubEntryGrid`
