# AbstractListPlugin

## 基本信息

- 名称: `AbstractListPlugin`
- Java 类名: `kd.bos.list.plugin.AbstractListPlugin`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/list/plugin`
- 类型: 列表插件基类

## 用途概览

`AbstractListPlugin` 是 PC 列表插件最常用的基类，适合处理列表初始化、勾选联动、打开单据回调、过滤方案和批量操作入口。

## 高频事件

| 方法 | 作用 |
|------|------|
| `listBeforeBindData` | 列表初始过滤和加载前处理 |
| `dataSelect` | 勾选结果联动 |
| `billClosedCallBack` | 从列表打开单据后的回调 |
| `beforePackageData` | 输出前补充数据包 |

## 运行时注意事项

- 它偏列表页交互，不适合直接承担复杂服务端事务逻辑。
- 列表插件经常和批量选择、权限、导出、下推操作一起出现，问题定位要分清是页面层还是服务层。

## 常见搭配

- 列表事件示例入口: [../../examples/plugins/插件示例/列表插件-事件拆分/README.md](../../examples/plugins/插件示例/列表插件-事件拆分/README.md)
- 列表事件包: [../packages/kd-bos-list-events.md](../packages/kd-bos-list-events.md)

## 关键词

- 中文: 列表插件, 列表联动, 列表回调
- 英文: `AbstractListPlugin`
