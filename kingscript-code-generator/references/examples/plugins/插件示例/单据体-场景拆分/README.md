# 单据体场景拆分

这个目录聚焦“单据体怎么操作”，优先覆盖新增分录、删除分录、批量补行、分页装载大分录、动态重建列、读取分录实体这几类二开高频问法。

## 场景目录

- [createNewEntryRow.md](createNewEntryRow.md)
- [deleteEntryRow.md](deleteEntryRow.md)
- [batchCreateEntryRows.md](batchCreateEntryRows.md)
- [batchLoadEntryRows.md](batchLoadEntryRows.md)
- [createGridColumnsDynamically.md](createGridColumnsDynamically.md)
- [getEntryEntity.md](getEntryEntity.md)

## 使用建议

- 问“怎么加分录/删分录/一次性装很多行分录”时，先看这里，不要先去翻超长总览。
- 如果问题开始变成“分录字段是什么类型、子分录结构是什么”，再回跳到 `EntryType`、`SubEntryType`。
