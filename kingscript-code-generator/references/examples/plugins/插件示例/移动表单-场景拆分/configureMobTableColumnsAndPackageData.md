# configureMobTableColumnsAndPackageData - 配置 MobTable 列并打包数据

## 场景

移动端列表用的是 `MobTable`，默认列和展示格式不够用。业务希望在初始化时调整日期列编辑器、插入额外的文本列和数值列，并且在数据真正返回给前端前，把页面数据重新打包成更适合移动端渲染的结构。

## Java 来源

- `kd.bos.plugin.test.mobile.mobtable.MobTablePluginSample`

## 适用入口

- `initialize(): void`
- `beforeCreateMobTableColumns(event: BeforeCreateMobTableColumnsEvent): void`
- `createMobTablePackageDataHandler(event: MobTablePackageDataHandlerEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { LocaleString } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { MobTable } from "@cosmic/bos-core/kd/bos/form/mcontrol";
import { IMobTablePackageDataHandler } from "@cosmic/bos-core/kd/bos/form/mcontrol/mobtable";
import {
  BeforeCreateMobTableColumnsEvent,
  MobTableHandleResult,
  MobTablePackageDataHandlerArgs,
  MobTablePackageDataHandlerEvent
} from "@cosmic/bos-core/kd/bos/form/mcontrol/mobtable/events";
import { MobTableColumn } from "@cosmic/bos-core/kd/bos/form/mcontrol/mobtable/tablecolumn";
import {
  DateTimeField,
  IntegerField,
  TextField
} from "@cosmic/bos-core/kd/bos/metadata/entity/commonfield";
import { HashMap } from "@cosmic/bos-script/java/util";

class SalesMobTablePackageHandler implements IMobTablePackageDataHandler {

  handleData(args: MobTablePackageDataHandlerArgs): MobTableHandleResult {
    let result = new MobTableHandleResult();
    let rowDataList = result.getMobTableRowDataList();
    let pageData = args.getPageData();

    for (let i = 0; i < pageData.size(); i++) {
      let row = pageData.get(i);
      let displayRow = new HashMap();

      displayRow.put("ktext", row.getString("billno"));
      displayRow.put("kinteger", row.getInt("seq"));
      displayRow.put("datemobtablecolumnap", row.get("bizdate"));
      displayRow.put("amountDisplay", row.get("totalamount"));

      rowDataList.add(displayRow);
    }

    let fmtInfo = result.getFmtInfo();
    fmtInfo.put("kinteger", "#,##0");
    return result;
  }
}

class ConfigureMobTableColumnsAndPackageDataPlugin extends AbstractFormPlugin {

  initialize(): void {
    super.initialize();

    let mobTable = this.getView().getControl("mobtableap") as MobTable;
    mobTable.addBeforeCreateMobTableColumnsListener(this);
    mobTable.addMobTablePackageDataHandlerListener(this);
  }

  beforeCreateMobTableColumns(event: BeforeCreateMobTableColumnsEvent): void {
    let originalColumns = event.getMobTableColumns();

    for (let i = 0; i < originalColumns.size(); i++) {
      let column = originalColumns.get(i) as MobTableColumn;
      if (column.getKey() !== "datemobtablecolumnap") {
        continue;
      }

      let dateField = new DateTimeField();
      let editor = dateField.createEditor();
      editor.put("df", "YYYY年MM月DD日");
      column.setCustomEditor(editor);
    }

    let rebuiltColumns = new $.java.util.ArrayList();

    let textField = new TextField();
    textField.setMustInput(true);

    let textColumn = new MobTableColumn();
    textColumn.setFieldKey("ktext");
    textColumn.setMobTableField("ktext");
    textColumn.setKey("ktext");
    textColumn.setCaption(new LocaleString("文本列"));
    textColumn.setForeColor("#99d92b");
    textColumn.setCustomEditor(textField.createEditor());
    rebuiltColumns.add(textColumn);

    let integerField = new IntegerField();
    integerField.setScale(2);

    let integerColumn = new MobTableColumn();
    integerColumn.setFieldKey("kinteger");
    integerColumn.setMobTableField("kinteger");
    integerColumn.setKey("kinteger");
    integerColumn.setCaption(new LocaleString("整数列"));
    integerColumn.setCustomEditor(integerField.createEditor());
    rebuiltColumns.add(integerColumn);

    rebuiltColumns.addAll(originalColumns);
    originalColumns.clear();
    originalColumns.addAll(rebuiltColumns);
  }

  createMobTablePackageDataHandler(event: MobTablePackageDataHandlerEvent): void {
    event.setMobTablePackageDataHandler(new SalesMobTablePackageHandler());
  }
}

let plugin = new ConfigureMobTableColumnsAndPackageDataPlugin();
export { plugin };
```

## 映射说明

- Java 样例的 `initialize` 做了两件事：注册列创建监听、注册数据打包监听。这里完整保留了这两个注册动作。
- `beforeCreateMobTableColumns` 的核心不是“改某一个列”，而是先处理已有日期列，再额外插入文本列、整数列，最后重排整个列集合。这一点和字节码逻辑一致。
- Java 里数据打包监听实际是通过内部类设置一个 `MyMobTablePackageDataHandler`。Kingscript 里把它显式写成 `SalesMobTablePackageHandler`，更容易复用和修改。

## 注意事项

- `MobTable` 的列定义和数据打包是两层能力：前者决定怎么展示，后者决定实际返回什么数据，不要只改其一。
- 自定义列时要同时设置 `fieldKey`、`mobTableField`、`key`，否则前端绑定关系容易不完整。
- 数据打包结果应该和列定义对应；如果你增加了 `ktext`、`kinteger` 这种列，返回结果里也要提供同名字段。
