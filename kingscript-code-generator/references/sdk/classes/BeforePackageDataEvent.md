# BeforePackageDataEvent

## 基本信息

- 名称：`BeforePackageDataEvent`
- Java 类名：`kd.bos.entity.datamodel.events.BeforePackageDataEvent`
- TS 导出名：`BeforePackageDataEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity/datamodel/events`
- 类型：列表数据格式化前事件参数
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/entity/datamodel/events` 相关声明核对
  - 相关示例：[beforePackageData.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforePackageData.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

用于列表数据显示前读取或改写当前页数据集合，适合补充显示字段、格式化展示值或附加头像、统计信息等列表渲染数据。

## 典型场景

- 列表展示前补图片、头像、标签字段
- 对当前页数据做只影响显示的格式化处理
- 统一补充列表侧展示用的派生字段

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `getPageData` | 获取当前页数据集合 | 无 | `DynamicObjectCollection` | 可直接遍历并改写显示值 |
| `setPageData` | 回写数据集合 | `DynamicObjectCollection` | `void` | 替换整个页数据时使用 |

## 运行时注意事项

- 这里更偏列表显示格式化，不是单据模型联动入口。
- 直接改 `pageData` 会影响当前页展示结果，需控制好字段范围。
- 不要在这里做重数据库查询，避免拖慢列表首屏。

## 常见搭配

- 搭配类：`IListPlugin`、`BillList`
- 搭配示例：[beforePackageData.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforePackageData.md)
- 搭配 FAQ：
  - 列表显示字段怎么补
  - 头像和标签怎么在列表里显示

## 常见错误

### 1. 把显示格式化写成保存逻辑

高概率原因：
- 混淆了列表展示和业务持久化
- 想在列表上顺手补业务字段

### 2. 在当前事件里做过重查询

高概率原因：
- 想一次性把所有关联值查全
- 没考虑列表分页和刷新频率

## 相关示例

- [beforePackageData.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforePackageData.md)

## 关键词

- 中文关键词：列表格式化、列表数据包、显示前事件、列表补字段
- 英文关键词：`BeforePackageDataEvent`
- 常见别名：列表打包前事件、列表显示前事件
- 常见报错词：列表显示不对、列表补字段、列表刷新变慢
