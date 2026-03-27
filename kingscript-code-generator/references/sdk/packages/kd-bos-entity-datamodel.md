# kd/bos/entity/datamodel

## 基本信息

- 包名：`kd/bos/entity/datamodel`
- 所属模块：`@cosmic/bos-core`
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/entity/datamodel` 相关声明核对
  - Javadoc：Cosmic V8.0.1

## 包职责

提供表单和单据运行时数据模型能力，负责字段读写、分录行操作、数据实体获取和模型级上下文访问。

## 高频类与接口

| 名称 | 类型 | 典型用途 | 文档状态 |
|------|------|----------|----------|
| `AbstractFormDataModel` | 类 | 表单/单据数据模型抽象层 | 已有类卡 |
| `IDataModel` | 接口 | 统一读取和写入模型值 | 待补 |
| `ListSelectedRowCollection` | 类 | 列表选中行集合 | 待补 |
| `BizDataEventArgs` | 类 | 新建数据包时注入自定义数据 | 待补 |
| `LoadDataEventArgs` | 类 | 加载数据包时自定义取数 | 待补 |

## 常见场景

- `this.getModel().getValue()` 和 `setValue()` 读写字段
- 创建默认分录行、删除分录行、移动分录行
- 复制或新建数据包时补默认值
- 配合事件包判断当前行、父行和数据实体

## 常见风险

- 把页面显示状态和模型数据处理混在一起
- 不区分表头和分录行的索引语义
- 批量写值时没有考虑 `propertyChanged` 的触发方式
- 直接依赖 TS 类型，忽略运行时是否真有值

## 相关示例与 FAQ

- 示例：
  - [表单插件.md](../../examples/plugins/插件示例/表单插件.md)
- FAQ：
  - 表单模型怎么读写字段
  - 默认分录行在哪个阶段创建
  - 批量设置值为什么会慢
