# 二开示例.基础资料.多选基础资料创建

        ## 适用场景

        在基础资料或业务对象中，需要给“多选基础资料字段”准备数据并一次性赋值，而不是让用户逐个选择。

        ## 原文链接

        - 社区原文: <https://vip.kingdee.com/knowledge/675284215226719488?specialId=570177930110532864&productLineId=40&isKnowledge=2&lang=zh-CN>

        ## 核心思路

        1. 多选基础资料底层通常是一个集合，要先准备好多选对象列表。
2. 如果是新建基础资料对象，也可以先 `newDynamicObject(...)`，再把多个对象组装进集合字段。
3. 实际项目里常见场景包括物料标签、多组织、多角色等多选字段回填。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
        ## 实现前提

        - 多选字段示例：`kdec_multi_material`
- 基础资料对象示例：`bd_material` 或 `bd_materialcommon`

        ## Kingscript 实现

        ```ts
        import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { ItemClickEvent } from "@cosmic/bos-core/kd/bos/form/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class MultiBasedataFillPlugin extends AbstractFormPlugin {

  itemClick(e: ItemClickEvent): void {
    super.itemClick(e);
    if (e.getItemKey() !== "btn_fill_multi_basedata") {
      return;
    }

    const materialList = new $.java.util.ArrayList();
    const numbers = ["M-001", "M-002", "M-003"];

    for (let i = 0; i < numbers.length; i++) {
      const material = QueryServiceHelper.queryOne(
        "bd_material",
        "id,number,name",
        [new QFilter("number", "=", numbers[i])]
      );
      if (material != null) {
        materialList.add(material);
      }
    }

    this.getModel().setValue("kdec_multi_material", materialList);
    this.getView().updateView("kdec_multi_material");
  }
}

let plugin = new MultiBasedataFillPlugin();
export { plugin };
        ```

        ## 关键步骤说明

        1. 先确定多选字段底层要求的是对象集合还是仅主键集合。
2. 按编号、名称或其他条件查出需要回填的基础资料对象。
3. 把对象集合整体写回多选字段。

        ## 转写说明

        原文演示了“多选基础资料创建”的思路，这里改写成表单端更常见的“按条件查询后一次性回填多选字段”模板。

        ## 注意事项 / 风险点

        - 不同字段的底层类型不完全一致，有的接受对象集合，有的只接受主键集合，需要按真实字段试一次。
- 查询字段建议只取必要列，减少无意义开销。
- 如果查询不到任何对象，最好给用户提示而不是静默失败。

        风险等级：`改字段标识后可用`

        ## 验证建议

        1. 点击按钮后确认多选基础资料字段一次性出现多条值。
2. 更换查询条件后再次执行，确认字段能正确更新。
3. 当列表为空时，确认不会报错。

        ## 来源说明

        - L3 Java 逻辑转 KS
- L4 本地资料校对
- L5 推断补全

        - 原文更偏创建对象，这里转成前台更常用的回填写法。
