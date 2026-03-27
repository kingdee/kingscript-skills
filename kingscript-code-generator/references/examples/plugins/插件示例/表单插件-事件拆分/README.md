# 表单插件事件拆分

本目录从 [`../表单插件.md`](../表单插件.md) 中拆出高频、易误判、用户会直接问“怎么写”的事件示例。

## 第一批：表单生命周期与数据联动

- [beforePropertyChanged.md](beforePropertyChanged.md)
- [propertyChanged.md](propertyChanged.md)
- [createNewData.md](createNewData.md)
- [preOpenForm.md](preOpenForm.md)
- [beforeBindData.md](beforeBindData.md)
- [afterBindData.md](afterBindData.md)
- [beforeDoOperation.md](beforeDoOperation.md)
- [afterDoOperation.md](afterDoOperation.md)
- [beforeClosed.md](beforeClosed.md)

## 第二批：监听注册与回调

- [registerListener.md](registerListener.md)
- [initialize.md](initialize.md)
- [closedCallBack.md](closedCallBack.md)
- [beforeFieldPostBack.md](beforeFieldPostBack.md)

## 第三批：页面能力与资源释放

- [timerElapsed.md](timerElapsed.md)
- [pageRelease.md](pageRelease.md)
- [setWaterMarkInfo.md](setWaterMarkInfo.md)

## 第四批：权限与数据包扩展

- [beforePackageData.md](beforePackageData.md)
- [beforeDoCheckDataPermission.md](beforeDoCheckDataPermission.md)

## 使用建议

- 已知事件名时，直接打开对应事件文件。
- 需要了解完整表单插件能力时，再回到总览文档。
- 涉及参数语义、触发边界和运行时限制时，配合 `references/sdk/classes/` 和 `references/sdk/packages/` 下的知识卡一起看。
