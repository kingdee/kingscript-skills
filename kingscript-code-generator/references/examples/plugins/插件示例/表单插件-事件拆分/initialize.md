# initialize - 初始化事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 插件初始化时触发，是插件生命周期中最早执行的方法之一 |
| 方法签名 | `initialize(): void` |

## 说明

插件的初始化方法，在表单生命周期的最早阶段执行。用于进行非UI相关的初始化操作，如注册工具栏按钮、初始化配置参数等。此时数据模型和界面控件可能尚未完全就绪，因此不建议在此方法中操作数据或控件。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| 无 | - | 该方法不接收参数 |


## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class PmPurorderToolbarPlugin extends AbstractBillPlugIn {

  initialize(): void {
    super.initialize();

  }

}

let plugin = new PmPurorderToolbarPlugin();
export { plugin };
```

## 注意事项

- `initialize` 是插件生命周期中最早执行的方法之一，必须先调用 `super.initialize()`
- 此阶段适合进行非UI相关的初始化操作，如注册工具栏按钮、初始化配置
- 不建议在此方法中操作数据模型（`this.getModel()`），因为数据可能尚未加载
- 界面控件的事件监听应在 `registerListener` 中注册，而非 `initialize`
- 动态添加的按钮需要在 `registerListener` 中注册点击监听，否则点击事件不会触发
- 插件类不能有类属性（如 `private xxx = ...`），只使用局部变量
