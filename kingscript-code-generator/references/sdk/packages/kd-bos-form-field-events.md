# kd/bos/form/field/events

## 基本信息

- 包名：`kd/bos/form/field/events`
- 所属模块：`@cosmic/bos-core`
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/field/events` 相关声明核对
  - Javadoc：Cosmic V8.0.1

## 包职责

面向字段和基础资料控件事件，重点覆盖 F7 选择前后、过滤容器 F7、快捷新增和模糊搜索等交互场景。

## 高频类与接口

| 名称 | 类型 | 典型用途 | 文档状态 |
|------|------|----------|----------|
| `BeforeF7SelectEvent` | 类 | F7 打开前追加过滤条件、改显示参数 | 已补类卡 |
| `AfterF7SelectEvent` | 类 | F7 选择后读取选中结果和回填信息 | 已补类卡 |
| `BeforeFilterF7SelectEvent` | 类 | 列表或过滤容器 F7 的前置过滤 | 已补类卡 |
| `BeforeQuickAddNewEvent` | 类 | 快捷新增前拦截或重定向打开方式 | 待补类卡 |
| `BasedataEditListener` | 接口 | 绑定基础资料控件相关监听 | 待补类卡 |
| `AddFuzzySearchEvent` | 类 | 控件模糊搜索前置扩展 | 待补 |

## 常见场景

- 根据组织、供应商、项目等上下文过滤 F7
- F7 选择后带出多个辅助字段
- 在过滤容器中改 F7 的默认过滤条件和表单参数
- 快捷新增时改为弹窗、新标签或禁止新增

## 常见风险

- 把字段 F7 和过滤容器 F7 混为一谈
- 只过滤了展示列表，没同步控制快捷新增或查看详情
- 在 `afterF7Select` 里直接假设只有单选返回
- 忽略 `sourceMethod`、当前行和多组织上下文

## 相关示例与 FAQ

- 示例：
  - [基础资料控件-事件拆分/README.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/README.md)
- FAQ：
  - F7 打开前怎么过滤
  - F7 选择后怎么带出字段
  - 快捷新增怎么改成自定义弹窗
