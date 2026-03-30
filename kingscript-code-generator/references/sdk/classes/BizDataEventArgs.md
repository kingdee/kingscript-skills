# BizDataEventArgs

## 基本信息

- 名称：`BizDataEventArgs`
- Java 类名：`kd.bos.entity.datamodel.events.BizDataEventArgs`
- TS 导出名：`BizDataEventArgs`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity/datamodel/events`
- 类型：新建数据包事件参数
- 相关示例：[createNewData.md](../../examples/plugins/插件示例/表单插件-事件拆分/createNewData.md)

## 用途概述

用于 `createNewData` 这类“创建数据包”阶段的回调参数，核心能力是读取或替换当前正在创建的数据包。

## 常用方法

| 方法 | 作用 | 说明 |
|------|------|------|
| `getDataEntity()` | 获取当前数据包 | 适合直接 `set(key, value)` 初始化字段 |
| `setDataEntity(dataEntity)` | 替换数据包 | 仅在确实要接管默认创建逻辑时使用 |
| `getIsExecuteRule()` | 查看是否执行实体规则 | 属于底层控制项 |
| `setIsExecuteRule(value)` | 控制实体规则执行 | 使用前先确认业务影响 |

## 运行时注意事项

- 这是 `createNewData` 的参数，不是 `afterCreateNewData` 的参数。
- 当前版本声明层已经给出 `BizDataEventArgs`，生成代码时不应再写成 `any`。
- `getDataEntity()` 返回的是底层数据包，适合做初始化，不等于页面模型对象。

## 相关文档

- [IDataModelListener.md](IDataModelListener.md)
- [createNewData.md](../../examples/plugins/插件示例/表单插件-事件拆分/createNewData.md)

## 关键词

- 中文关键词：创建数据包、新建事件参数、模型初始化参数
- 英文关键词：`BizDataEventArgs`
