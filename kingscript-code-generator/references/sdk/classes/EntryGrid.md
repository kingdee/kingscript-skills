# EntryGrid

## 基本信息

- 名称: `EntryGrid`
- Java 类名: `kd.bos.form.control.EntryGrid`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/form/control`
- 类型: 单据体分录表格控件

## 用途概览

`EntryGrid` 是单据体在页面层的控件对象，偏“界面交互”和“表格表现”。它适合处理当前选中行、焦点单元格、列属性、汇总显示、行锁定、事件监听等问题，但不负责真正保存分录数据。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `getSelectRows()` | 获取当前选中行 | 批量操作、行级校验 |
| `focusCell(row, fieldKey)` | 聚焦到指定单元格 | 校验失败后跳到问题字段 |
| `setMustInput(fieldKey, required)` | 设置列必录 | 按业务状态动态控制必录 |
| `setColumnProperty(col, prop, value)` | 调整列属性 | 控制可见性、标题、只读 |
| `setRowLock(lock, rows)` | 锁定指定行 | 已下推行不允许再编辑 |
| `getEntryKey()` | 获取分录标识 | 从控件回跳到模型层 |

## 高价值规则

- `EntryGrid` 是控件层，不是数据层。真正的分录数据读写，仍然优先走 `this.getModel().getEntryEntity(...)`、`createNewEntryRow(...)`、`deleteEntryRow(...)`。
- “当前焦点行”和“当前选中行”不一定相同，涉及批量操作时优先以 `getSelectRows()` 为准。
- 行锁定、列只读、单元格聚焦这些都是前端交互能力，不等于后端事务保护。

## 常见搭配

- 分录集合: [DynamicObjectCollection.md](DynamicObjectCollection.md)
- 分录元数据: [EntryType.md](EntryType.md)
- 子分录控件: [SubEntryGrid.md](SubEntryGrid.md)

## 关键词

- 中文: 单据体, 分录表格, 选中行, 焦点单元格, 锁定分录
- 英文: `EntryGrid`
