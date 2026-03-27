# DynamicObjectCollection

## 基本信息

- 名称: `DynamicObjectCollection`
- Java 类名: `kd.bos.dataentity.entity.DynamicObjectCollection`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/dataentity/entity`
- 类型: 动态实体集合

## 用途概览

`DynamicObjectCollection` 通常承载分录行、子实体集合或批量查询结果。二开里“遍历分录”“新增一行”“删除一行”基本都绕不开它。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `size()` / `isEmpty()` | 判断行数 | 校验是否有分录 |
| `get(index)` | 取指定行 | 遍历分录读取字段 |
| `addNew()` | 追加新行 | 新增分录 |
| `add(index, item)` | 插入行 | 指定位置插入 |
| `remove(index)` | 删除行 | 删分录 |
| `clear()` | 清空集合 | 重新构建分录 |

## 运行时注意事项

- 这是 Java 集合，不要把它当原生 JS `Array` 使用。
- 遍历时优先用 `size() + get(index)`，兼容性最稳。
- `addNew()` 返回的也是 `DynamicObject`，新增后通常还要继续给字段赋值。
- 分录删除和重建要注意触发的联动、校验和界面刷新。

## 常见搭配

- 实体对象: [DynamicObject.md](DynamicObject.md)
- 字段变化监听: [PropertyChangedArgs.md](PropertyChangedArgs.md)

## 关键词

- 中文: 分录集合, 分录行, 新增分录, 删除分录
- 英文: `DynamicObjectCollection`
