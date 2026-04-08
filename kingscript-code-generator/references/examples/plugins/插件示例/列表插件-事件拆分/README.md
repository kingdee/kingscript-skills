# 列表插件事件拆分

本目录聚焦列表打开、行选择和单据关闭回调这几类高频事件，优先覆盖“列表怎么初始化过滤”“选中后怎么联动”“列表打开单据后怎么接回调”。

## 事件目录

- [listBeforeBindData.md](listBeforeBindData.md)
- [billClosedCallBack.md](billClosedCallBack.md)
- [beforePackageData.md](beforePackageData.md)

## 使用建议

- 需要初始化列表过滤条件时，先看 `listBeforeBindData`。
- 需要处理从列表打开单据后的关闭回调时，先看 `billClosedCallBack`。
- 需要在列表输出前补充数据包字段时，先看 `beforePackageData`。
