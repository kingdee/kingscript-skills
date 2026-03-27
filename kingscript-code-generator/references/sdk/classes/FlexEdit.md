# FlexEdit

## 基本信息

- 名称: `FlexEdit`
- Java 类名: `kd.bos.form.field.FlexEdit`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/form/field`
- 类型: 弹性域控件

## 用途概览

`FlexEdit` 用来处理弹性域的展示、编辑和弹窗选择。它通常不是简单的一个值，而是一组维度的组合，因此排查问题时既要看控件，也要看 `FlexProp` / `FlexEntityType`。

## 高频问法

- 弹性域怎么取值
- 弹性域怎么取显示文本
- 弹性域为什么显示正常但保存结构不对
- 弹性域列表列怎么补显示值

## 运行时注意事项

- 弹性域经常返回的是引用对象或组合对象，不要把它当普通字符串字段处理。
- “显示值”和“实际值”经常不是一回事，调试时优先同时看模型值和数据包值。
- 页面层问题先看 `FlexEdit`，结构层问题再看 `FlexProp`、`FlexEntityType`。

## 常见搭配

- 弹性域字段: [FlexProp.md](FlexProp.md)
- 弹性域实体类型: [FlexEntityType.md](FlexEntityType.md)
- 弹性域属性: [FlexProperty.md](FlexProperty.md)

## 关键词

- 中文: 弹性域控件, Flex 控件
- 英文: `FlexEdit`
