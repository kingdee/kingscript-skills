# Kingscript Plugin Templates

这个目录只存放“具体插件类型的基础模板”，用于帮助二开人员快速起一个可继续扩展的插件骨架。

## 目录定位

- 放表单插件模板
- 放单据插件模板
- 放列表插件模板
- 放操作插件模板
- 不放具体业务场景模板

具体事件写法、场景化实现和完整示例，请放到 `../examples/` 中维护。

## 当前基础模板

- [form-plugin-template.md](form-plugin-template.md)
- [bill-plugin-template.md](bill-plugin-template.md)
- [list-plugin-template.md](list-plugin-template.md)
- [operation-plugin-template.md](operation-plugin-template.md)
- [convert-plugin-template.md](convert-plugin-template.md)
- [report-form-plugin-template.md](report-form-plugin-template.md)
- [report-query-plugin-template.md](report-query-plugin-template.md)
- [print-plugin-template.md](print-plugin-template.md)
- [workflow-plugin-template.md](workflow-plugin-template.md)
- [import-plugin-template.md](import-plugin-template.md)
- [export-plugin-template.md](export-plugin-template.md)
- [task-plugin-template.md](task-plugin-template.md)
- [mobile-form-plugin-template.md](mobile-form-plugin-template.md)

## 使用建议

- 先确认当前需求属于哪一类插件，再选择对应模板
- 先用模板起好骨架，再按需补充事件方法和业务逻辑
- 需要具体事件写法时，回到 `../examples/` 查找最接近的示例
- 模板只解决“插件怎么起”的问题，字段、权限和运行时开放能力仍需按实际环境确认
