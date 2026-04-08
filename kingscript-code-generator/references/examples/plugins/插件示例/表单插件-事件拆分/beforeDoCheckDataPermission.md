# beforeDoCheckDataPermission - 数据权限校验前置处理

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 执行数据权限校验前触发 |
| 方法签名 | `beforeDoCheckDataPermission(e: BeforeDoCheckDataPermissionArgs): void` |

## 说明

这个事件适合在权限校验前补充上下文、决定是否跳过某些临时场景，或者给权限服务附加识别信息。它不是通用的“绕过权限”入口，应谨慎使用。


## 完整示例代码

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { BeforeDoCheckDataPermissionArgs } from "@cosmic/bos-core/kd/bos/form/events";

class PermissionPreparePlugin extends AbstractFormPlugin {

  beforeCheckDataPermission(e: BeforeDoCheckDataPermissionArgs): void {
    super.beforeCheckDataPermission(e);
    e.setCancel(true);
  }
}

let plugin = new PermissionPreparePlugin();
export { plugin };
```

## 注意事项

- 只有确实理解权限链路时再在这里加逻辑。
- 不要把权限缺失问题简单处理成“全部放行”。
- 传入的附加参数要和后续权限逻辑约定一致。
