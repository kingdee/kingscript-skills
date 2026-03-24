# createNewData - 创建数据包事件

来源：从 [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | IDataModelListener |
| 触发时机 | 新建单据时数据包创建阶段触发，早于 afterCreateNewData |
| 方法签名 | `createNewData(e: any): void` |

## 说明

在新建单据时，数据包创建阶段触发此事件。通过 `e.getDataEntity()` 直接操作底层数据包进行初始化赋值，适合做底层数据的预处理。此方法比 `afterCreateNewData` 更早触发。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | any | 事件参数对象 |
| e.getDataEntity() | Object | 获取当前正在创建的数据包对象，通过 `set(key, value)` 赋值 |

## 业务场景

在新建付款申请单时，需要根据当前登录人所属的部门规则自动生成单据编号前缀。例如：财务部前缀为"FIN-"，采购部前缀为"PUR-"，其他部门前缀为"GEN-"，再拼接日期和序号，形成完整的单据编号。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { RequestContext } from "@cosmic/bos-core/kd/bos/context";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

/**
 * 付款申请单表单插件 - 新建时按部门规则自动生成单据编号前缀
 */
class ApPayApplyBillNoPlugin extends AbstractBillPlugIn {

  createNewData(e: any): void {
    super.createNewData(e);

    const dataEntity = e.getDataEntity();

    const currUserId = RequestContext.get().getCurrUserId();

    const userInfo = QueryServiceHelper.queryOne(
      "bos_user",
      "dpt.id as deptid,dpt.number as deptnumber,dpt.name as deptname",
      [new QFilter("id", "=", currUserId)]
    );

    if (userInfo == null) {
      return;
    }

    const deptNumber = userInfo.get("deptnumber") as string;
    const deptId = userInfo.get("deptid");

    let billNoPrefix = "GEN-";
    if (deptNumber != null) {
      if (deptNumber.startsWith("FIN")) {
        billNoPrefix = "FIN-";
      } else if (deptNumber.startsWith("PUR")) {
        billNoPrefix = "PUR-";
      } else if (deptNumber.startsWith("SAL")) {
        billNoPrefix = "SAL-";
      }
    }

    const now = new Date();
    const year = String(now.getFullYear());
    const month = String(now.getMonth() + 1).padStart(2, "0");
    const day = String(now.getDate()).padStart(2, "0");
    const dateStr = year + month + day;

    const seqStr = String(now.getTime()).slice(-4);
    const billNo = billNoPrefix + dateStr + "-" + seqStr;

    dataEntity.set("billno", billNo);

    if (deptId != null) {
      dataEntity.set("applydept", deptId);
    }

    dataEntity.set("applier", currUserId);
    dataEntity.set("applydate", new Date());
  }
}

let plugin = new ApPayApplyBillNoPlugin();
export { plugin };
```

## 注意事项

- `createNewData` 直接操作数据包（`e.getDataEntity()`），使用 `dataEntity.set(key, value)` 赋值，不能使用 `this.getModel().setValue()`
- 此方法比 `afterCreateNewData` 更早触发，适合做底层数据初始化
- 仅在新建单据时触发，编辑已有单据时不触发
- 在此方法中界面模型尚未完全就绪，不建议调用 `this.getView()` 相关方法
- 必须调用 `super.createNewData(e)` 以确保父类逻辑正常执行
- 插件类不能定义类属性，所有变量应在方法内部声明
