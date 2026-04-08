# 二开示例.动态创建View 模拟界面操作并保存单据

## 适用场景

需要在操作插件、后台任务插件、API 插件等非前端交互场景下，模拟打开页面、触发表单插件事件和业务规则，再执行保存。

## 原文链接

- 社区原文: <https://vip.kingdee.com/knowledge/715865765693522688?specialId=570177930110532864&productLineId=40&isKnowledge=2&lang=zh-CN>

## 核心思路

1. 先按业务对象标识动态创建一个 `IFormView`。
2. 通过 `view.getModel()` 创建新数据、赋值。
3. 调用 `view.invokeOperation("save")` 走页面保存链路。
4. 用完后释放 view，并清理 session，避免内存泄露。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
## 实现前提

- 业务对象标识示例: `crk6_demo003`
- 头字段标识示例: `billno`
- 适用于“必须走页面保存逻辑”的场景，不适合单纯做批量数据库更新

## Kingscript 实现

下面这版是根据原文 Java 逻辑转成的 Kingscript 推荐写法。

- `BillShowParameter`、`MetadataServiceHelper`、`SessionManager`、`IFormView` 已在本地 skill 资料中确认存在
- `FormConfigFactory` 当前还没有沉淀到本地知识卡，因此这里通过 Java bridge `$.kd.bos.mvc.FormConfigFactory` 调用
- 这部分属于“Java 逻辑转 KS + 本地资料校对 + 推断补全”

```ts
import { BillShowParameter } from "@cosmic/bos-core/kd/bos/bill";
import { IFormView } from "@cosmic/bos-core/kd/bos/form";
import { MetadataServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";

class FormViewUtils {

  static createViewByFormId(formId: string): IFormView {
    const entityType = MetadataServiceHelper.getDataEntityType(formId);
    const appId = entityType.getAppId();

    const showParam = new BillShowParameter();
    showParam.setFormId(formId);
    showParam.setAppId(appId);

    const FormConfigFactory = $.kd.bos.mvc.FormConfigFactory;
    const SessionManager = $.kd.bos.mvc.SessionManager;

    FormConfigFactory.createConfigInCurrentAppService(showParam);

    const view = SessionManager.getCurrent().getView(showParam.getPageId()) as IFormView;
    if (view == null) {
      throw new Error("业务对象 " + formId + " 创建 view 失败");
    }

    return view;
  }

  static releaseView(view: IFormView): void {
    const SessionManager = $.kd.bos.mvc.SessionManager;
    const IFormController = $.kd.bos.mvc.form.IFormController;
    const HashMap = $.java.util.HashMap;

    const pageId = view.getPageId();
    SessionManager.getCurrent().clearPageSession(pageId, pageId);

    const controller = view.getService(IFormController);
    controller.release(new HashMap());
  }
}

try {
  const view = FormViewUtils.createViewByFormId("crk6_demo003");
  const model = view.getModel();

  model.createNewData();
  model.setValue("billno", String(Date.now()));

  view.invokeOperation("save");
  FormViewUtils.releaseView(view);
} finally {
  $.kd.bos.mvc.SessionManager.reset();
}
```

## 关键步骤说明

- `MetadataServiceHelper.getDataEntityType(formId)` 用来取业务对象对应的 `appId`。
- `createConfigInCurrentAppService(...)` 对应原文 Java 的动态创建配置过程。
- `invokeOperation("save")` 的意义是走页面保存链路，从而触发表单插件与规则。
- `clearPageSession(...) + controller.release(...) + SessionManager.reset()` 是避免 OOM 的关键收尾动作。

## Java -> KS 映射说明

- `BillShowParameter`、`IFormView`、`MetadataServiceHelper` 保持原思路不变。
- `SessionManager`、`IFormController`、`FormConfigFactory` 通过 Java bridge 调用，避免在本地 SDK 索引缺口下硬写不存在的 TS 导出路径。
- `KDException` 这里改成标准 `Error`，更适合在 skill 案例里表达“创建失败”。

## 注意事项 / 风险点

- 这篇最重要的风险不是保存，而是释放。`view.close()` 不能替代 `releaseView(...)`。
- `FormConfigFactory` 这一段目前来自原文 Java 包名映射，建议你先在本地运行环境验证一次。
- 非 UI 场景里如果没有清理 session，长时间批量执行很容易堆积内存。

风险等级：`推断版，建议先验证`

## 验证建议

1. 先在测试环境只创建 1 张单据，确认能正常触发表单插件和保存规则。
2. 连续循环执行 20 次以上，观察是否出现 session 堆积或内存上涨。
3. 故意注释掉 `releaseView(...)` 再对比一次，确认收尾逻辑的必要性。

## 来源说明

- `L3 Java 逻辑转 KS`
- `L4 本地资料校对`
- `L5 推断补全`

原文只提供了 Java 代码。这里的 Kingscript 实现保持原文逻辑主线，并把本地索引尚未沉淀的部分显式标成 Java bridge 调用。
