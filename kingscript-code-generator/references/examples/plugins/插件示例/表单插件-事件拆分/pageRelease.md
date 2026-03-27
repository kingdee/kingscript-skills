# pageRelease - 页面释放事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 页面销毁、资源释放前触发 |
| 方法签名 | `pageRelease(e: any): void` |

## 说明

`pageRelease` 用于清理页面生命周期里创建的资源，比如定时器、监听器、临时缓存、外部服务句柄。它不是业务保存事件，而是资源收尾事件。

## 业务场景

大屏页面打开后注册了定时刷新和自定义监听；页面关闭时统一释放，避免页面反复打开后出现重复监听和内存占用。

## 完整示例代码

```typescript
import { AbstractFormPlugIn } from "@cosmic/bos-core/kd/bos/form/plugin";

class ResourceCleanupPlugin extends AbstractFormPlugIn {

  afterBindData(e: any): void {
    super.afterBindData(e);
    this.getView().startTimer(15000);
  }

  pageRelease(e: any): void {
    super.pageRelease(e);
    this.getView().stopTimer();
  }
}

let plugin = new ResourceCleanupPlugin();
export { plugin };
```

## 注意事项

- 这里更适合做“收尾”，不适合再发起复杂交互。
- 如果插件里启用了定时器、注册了页面级监听，优先在这里关闭。
- 需要弹提示时应尽量轻量，避免页面释放阶段再依赖复杂 UI。
