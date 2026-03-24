# 单据插件字段修改前校验模板

## 适用场景

- 单据场景
- 需要在字段写入前进行前置拦截
- 典型场景如：禁止修改审核后字段、禁止录入负数、禁止跨组织改值

## 推荐基类

- `AbstractBillPlugIn`

## 推荐事件

- `beforePropertyChanged`

## 模板代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class BillBeforePropertyChangedTemplate extends AbstractBillPlugIn {

  beforePropertyChanged(e: any): void {
    super.beforePropertyChanged(e);

    const fieldKey = e.getPropertyName();
    if (fieldKey !== "<字段标识>") {
      return;
    }

    const currentValue = this.getModel().getValue("<依赖字段>");
    const newValue = e.getNewValue();

    if (<拦截条件>) {
      e.setCancel(true);
      this.getView().showWarnNotification("<提示语>");
      return;
    }

    // 如有需要，可继续补充数值、组织、状态等校验
  }
}

let plugin = new BillBeforePropertyChangedTemplate();
export { plugin };
```

## 需要替换的占位项

- `<字段标识>`：当前要拦截的字段 key
- `<依赖字段>`：判断逻辑需要读取的其他字段
- `<拦截条件>`：真正的业务判断表达式
- `<提示语>`：给终端用户看的提示文案

## 风险提示

- 该模板只适合单据场景，不适合表单、列表、操作服务插件
- 事件里如果继续修改同一个字段，容易形成循环联动
- 字段 key 和状态值需要以实际元数据为准，不要直接照搬示例

## 参考示例

- [beforePropertyChanged.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6-%E4%BA%8B%E4%BB%B6%E6%8B%86%E5%88%86/beforePropertyChanged.md)
- [AbstractBillPlugIn.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractBillPlugIn.md)
