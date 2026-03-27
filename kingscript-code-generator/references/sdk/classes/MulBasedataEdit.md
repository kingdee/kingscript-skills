# MulBasedataEdit

## 基本信息

- 名称: `MulBasedataEdit`
- Java 类名: `kd.bos.form.field.MulBasedataEdit`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/form/field`
- 类型: 多选基础资料控件

## 用途概览

`MulBasedataEdit` 是基础资料多选控件，适合处理“多个辅助资料、多个人员、多个标签、多个组织”的录入和过滤。它通常继承了基础资料控件的大部分行为，但更强调多选结果和展示方式。

## 高频问法

- 基础资料多选怎么过滤
- 多选 F7 怎么限制可选范围
- 多选结果怎么回填或展示
- 多选控件和 `MulBasedataProp` 的关系是什么

## 运行时注意事项

- `MulBasedataEdit` 偏控件层，字段底层结构仍要回到 `MulBasedataProp` 和模型层确认。
- 多选返回值的结构经常比单选复杂，调试时先确认模型里保存的是主键、集合还是引用对象。
- 复杂场景优先结合 `beforeF7Select`、`afterF7Select` 一起看。

## 常见搭配

- 多选基础资料字段: [MulBasedataProp.md](MulBasedataProp.md)
- 基础资料控件: [BasedataEdit.md](BasedataEdit.md)
- F7 示例入口: [../../examples/plugins/插件示例/基础资料控件-事件拆分/README.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/README.md)

## 关键词

- 中文: 多选基础资料, 多选 F7, 多选资料控件
- 英文: `MulBasedataEdit`
