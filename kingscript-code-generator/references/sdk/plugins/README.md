# SDK Plugins

这个目录用于沉淀“插件类型”和“扩展点接口”层面的知识卡，不是放原始 SDK 扫描结果。

## 现在先看哪里

- 表单/单据插件: `../../examples/plugins/插件示例/表单插件-事件拆分/README.md`
- 列表插件: `../../examples/plugins/插件示例/列表插件-事件拆分/README.md`
- 操作插件: `../../examples/plugins/插件示例/操作插件-事件拆分/README.md`
- F7 与基础资料控件: `../../examples/plugins/插件示例/基础资料控件-事件拆分/README.md`
- 插件总入口: `../indexes/plugin-index.md`

## 后续建议在这里补的卡片

- `AbstractListPlugin`
- `IListPlugin`
- `AbstractConvertPlugIn`
- `AbstractWriteBackPlugIn`
- 操作插件、打印插件、任务插件的扩展点总览

## 不建议做法

- 不要把整个 `bos/bos` 插件说明原样搬进来
- 不要让这个目录继续只有占位说明

在没有补齐单卡前，这个 README 至少要承担插件路由页的作用。
