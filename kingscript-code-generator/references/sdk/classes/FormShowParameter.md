# FormShowParameter

## 基本信息

- 名称：`FormShowParameter`
- Java 类名：`kd.bos.form.FormShowParameter`
- TS 导出名：`FormShowParameter`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.form`
- 类型：打开表单或子页面的参数对象
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-form-metadata.d.ts`
  - Javadoc：待补充

## 用途概述

用于在脚本里配置“打开哪个页面、怎么打开、带哪些参数、关闭后如何回调”，是页面跳转和弹窗场景的核心参数对象。

## 典型场景

- 打开子页面或引导页面
- 以模态或非模态方式展示表单
- 向子页面传递自定义参数
- 配置关闭回调和父子页面联动

## 用户常见问法

- 子页面怎么传参数
- 怎么模态打开页面
- 怎么拿子页面回传值
- `FormShowParameter` 应该设置哪些字段

## 常见搭配

- `ShowType`
  - 指定页面展示方式
- `CloseCallBack`
  - 指定子页面关闭后的回调
- `IFormView`
  - 最终通常通过视图能力打开页面

## 高频方法

- `setFormId(...)`
- `getFormId()`
- `setCustomParams(...)`
- `getCustomParams()`
- `setCloseCallBack(...)`
- `getOpenStyle()`
- `setShowWaterMark(...)`
- `createViewForWebApi()`

## 高价值规则

- `setFormId(...)` 是最基础的前提，没有目标表单标识就谈不上打开页面
- 传自定义参数时，要区分“完整替换参数包”和“增量设置单个参数”
- 回调需求要和 `CloseCallBack` 一起设计，不要等页面打开后再补救

## 运行时注意事项

- 页面能否打开，不只取决于参数对象，还取决于当前视图环境和权限
- 相同的参数对象，在普通表单和 WebApi 场景里的视图承载方式可能不同
- 展示方式、父页面、回调关系最好在打开前一次性配齐

## 常见错误

### 1. 页面打开了，但拿不到子页面回传值

高概率原因：
- 只配置了 `FormShowParameter`，没有配 `CloseCallBack`
- 回调标识和父页面处理逻辑没有对齐

## 相关文档

- [ShowType.md](ShowType.md)
- [CloseCallBack.md](CloseCallBack.md)
- [IFormView.md](IFormView.md)

## 关键词

- 中文关键词：打开页面参数、弹窗参数、子页面参数、页面跳转参数
- 英文关键词：`FormShowParameter`
- 常见报错词：页面打不开、参数没传过去、回调没触发
