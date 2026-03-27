# kd/bos/form/control/events

## 基本信息

- 包名：`kd/bos/form/control/events`
- 所属模块：`@cosmic/bos-core`
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/control/events` 相关声明核对
  - Javadoc：Cosmic V8.0.1

## 包职责

聚合控件级事件，覆盖附件、图片、按钮、提示、列表列依赖和 WebOffice 等控件交互场景。

## 高频类与接口

| 名称 | 类型 | 典型用途 | 文档状态 |
|------|------|----------|----------|
| `AttachmentPreviewEvent` | 类 | 附件预览前扩展 | 待补 |
| `BeforeAttachmentUploadEvent` | 类 | 上传前校验 | 待补 |
| `BeforeClickEvent` | 类 | 控件点击前拦截 | 待补 |
| `BaseDataColumnDependFieldSetEvent` | 类 | 控件依赖字段动态设置 | 待补 |
| `WebOfficeDataListener` | 接口 | WebOffice 数据变化监听 | 待补 |

## 常见场景

- 附件上传、预览、删除和打标控制
- 控件点击前校验上下文
- 依赖字段驱动控件列显示
- WebOffice 或附件类控件扩展

## 常见风险

- 控件级事件里直接写重业务逻辑
- 上传或预览控制漏掉权限校验
- 把控件事件误放到表单生命周期方法里
- 控件 key 不一致导致监听注册后不生效

## 相关示例与 FAQ

- 示例：
  - [表单插件-事件拆分/registerListener.md](../../examples/plugins/插件示例/表单插件-事件拆分/registerListener.md)
- FAQ：
  - 控件监听应该在什么时候注册
  - 附件上传前怎么校验
  - WebOffice 数据变化怎么接
