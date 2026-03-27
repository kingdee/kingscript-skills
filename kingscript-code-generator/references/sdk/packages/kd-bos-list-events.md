# kd/bos/list/events

## 基本信息

- 包名：`kd/bos/list/events`
- 所属模块：`@cosmic/bos-core`
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/list/events` 相关声明核对
  - Javadoc：Cosmic V8.0.1

## 包职责

提供列表插件相关事件参数，覆盖列表绑定前、移动端选择控件、树列表过滤和单据关闭回调等高频列表交互。

## 高频类与接口

| 名称 | 类型 | 典型用途 | 文档状态 |
|------|------|----------|----------|
| `BillClosedCallBackEvent` | 类 | 列表打开单据后接收关闭回调 | 已补类卡 |
| `ListBeforeBindDataEvent` | 类 | 列表绑定前初始化过滤或取消绑定 | 待补 |
| `DataSelectEvent` | 类 | 移动端选择控件设置回调与多选 | 待补 |
| `BuildTreeListFilterEvent` | 类 | 树列表过滤条件构造 | 待补 |
| `DataSelectListener` | 接口 | 选择控件监听扩展 | 待补 |

## 常见场景

- 列表打开子单据后关闭回调刷新
- 列表绑定前按组织、方案、状态调整过滤
- 移动端列表选择控件设置单选/多选和关闭回调
- 树列表和普通列表的过滤策略差异

## 常见风险

- 打开子单据时未设置 `CloseCallBack`，导致列表侧回调不触发
- 把列表事件和表单事件混用
- 在列表绑定前做过重查询，导致首屏变慢
- 只刷新列表不恢复选中状态，用户体验不稳定

## 相关示例与 FAQ

- 示例：
  - [列表插件-事件拆分/README.md](../../examples/plugins/插件示例/列表插件-事件拆分/README.md)
- FAQ：
  - 列表打开单据后怎么刷新
  - 移动端数据选择控件怎么拿到结果
  - 列表绑定前在哪改过滤
