# beforeDoCheckDataPermission - 数据权限校验前置处理

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 执行数据权限校验前触发 |
| 方法签名 | `beforeDoCheckDataPermission(e: BeforeDoCheckDataPermissionArgs): void` |

## 说明

这个事件适合在权限校验前补充上下文、决定是否跳过某些临时场景，或者给权限服务附加识别信息。它不是通用的“绕过权限”入口，应谨慎使用。

## 业务场景

共享查询看板允许管理员切换查看组织数据。插件在校验前先写入当前选中组织，保证权限校验使用正确的组织上下文。

## 完整示例代码

```typescript
import { AbstractFormPlugIn } from "@cosmic/bos-core/kd/bos/form/plugin";
import { BeforeDoCheckDataPermissionArgs } from "@cosmic/bos-core/kd/bos/form/events";

class PermissionPreparePlugin extends AbstractFormPlugIn {

  beforeDoCheckDataPermission(e: BeforeDoCheckDataPermissionArgs): void {
    super.beforeDoCheckDataPermission(e);

    const selectedOrg = this.getModel().getValue("fqueryorg");
    const isAdminView = this.getModel().getValue("fisadminview") === true;

    e.put("queryOrg", selectedOrg);

    if (isAdminView) {
      e.put("viewMode", "admin");
    }
  }
}

let plugin = new PermissionPreparePlugin();
export { plugin };
```

## 注意事项

- 只有确实理解权限链路时再在这里加逻辑。
- 不要把权限缺失问题简单处理成“全部放行”。
- 传入的附加参数要和后续权限逻辑约定一致。
