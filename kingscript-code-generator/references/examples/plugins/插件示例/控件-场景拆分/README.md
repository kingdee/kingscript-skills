# 控件-场景拆分

这个目录聚焦“复杂控件交互怎么搭”，优先沉淀搜索框、树控件这类既要注册监听、又要组织返回数据结构的高频场景。

## 案例列表

- [`configureSearchAndQuickFilter.md`](./configureSearchAndQuickFilter.md): 搜索框同时承担联想建议、结果缓存和快速打开
- [`buildTreeViewAndLazyLoadNodes.md`](./buildTreeViewAndLazyLoadNodes.md): 初始化树根节点，并在展开、勾选、拖拽时做懒加载和交互反馈

## 使用建议

- 如果你已经确定问题落在 `Search`、`TreeView` 这类复合控件上，先看这里，而不是直接翻 `控件.md` 的长总览。
- 如果你只是不确定某个监听器签名怎么写，再回到 [`控件.md`](../控件.md) 查事件卡片。
