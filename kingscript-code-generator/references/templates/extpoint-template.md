# 业务扩展点模板

## 适用场景

- 干预标准产品的特定业务节点（如合同变更、订单审批、单据反写等）
- 在不修改源码的前提下增强标准业务逻辑
- 需要注册到特定业务领域扩展点接口的场景

## 保守约束

本模板遵循 `gotchas/` 中定义的保守约束：

- 不使用 `?.`、`??` 等现代语法（详见 `../gotchas/README.md` 坑 1）
- 金额/数值字段使用保守转换（详见 `../gotchas/README.md` 坑 2、`../gotchas/bigdecimal.md`）
- 禁止定义 `static` 方法和变量（详见 `../gotchas/README.md` 坑 3）
- 异常信息获取统一用 `'' + e`（详见 `../gotchas/README.md` 坑 4）
- 禁止对 `DynamicObjectCollection` 使用 `for-of`（详见 `../gotchas/README.md` 坑 5）
- 分录字段读取必须带 `entryentity.` 前缀（详见 `../gotchas/README.md` 坑 12）
- `DynamicObject` 字段读取禁止 `row.getDate()`（详见 `../gotchas/dynamicobject.md`）

## 脚本代码模板

```typescript
// TODO: 根据实际业务场景替换为对应的扩展点接口
import { IYourExtensionPoint } from '@constellation/xxx/extpoint';

let ext: IYourExtensionPoint = {
  // TODO: 替换为实际接口定义的方法名和签名
  yourMethod(args: any): boolean {
    // 实现业务逻辑
  }

};

export { ext };
```

## 下一步

- 需要完整的扩展点开发说明 → `../docs/业务扩展点开发指南.md`
- 需要保守转换、数值/日期处理等运行时约束 → `../gotchas/`
- 需要 SDK 类、方法声明 → `../sdk/`
