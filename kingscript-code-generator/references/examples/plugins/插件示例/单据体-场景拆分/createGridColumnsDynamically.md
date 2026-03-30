# createGridColumnsDynamically - 动态重建单据体列

## 场景

同一个单据体在不同模式下要显示不同列数和列类型，例如基础模式只看文本列，增强模式再补数值列和日期列。这时仅靠隐藏列往往不够，更实用的是在页面绑定后按参数重新生成列结构和当前页数据。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.entrygrid.bizcase.CreateGridColumnsSample`

这个 Java 样例围绕“列结构跟着参数变”做了 3 件事：

- 监听 `gridcols` 参数变化后重建列定义
- 通过 `EntryGridBindDataEvent` 给当前页回填对应列数的数据
- 用客户端代理方法触发 `createGridColumns`，而不是只改字段值

## 适用入口

- `registerListener(e: $.java.util.EventObject): void`
- `afterBindData(e: $.java.util.EventObject): void`
- `propertyChanged(e: $.kd.bos.dataentity.event.PropertyChangedArgs): void`
- `entryGridBindData(e: EntryGridBindDataEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { EntryGridBindDataEvent } from "@cosmic/bos-core/kd/bos/form/control/events";

class CreateGridColumnsDynamicallyPlugin extends AbstractFormPlugin {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    let grid = this.getView().getControl("entryentity") as any;
    grid.addDataBindListener(this);
  }

  afterBindData(e: $.java.util.EventObject): void {
    super.afterBindData(e);
    this.rebuildGridCols();
  }

  propertyChanged(e: $.kd.bos.dataentity.event.PropertyChangedArgs): void {
    super.propertyChanged(e);

    if (e.getProperty().getName() === "gridcols") {
      this.rebuildGridCols();
    }
  }

  entryGridBindData(e: EntryGridBindDataEvent): void {
    let grid = this.getView().getControl("entryentity") as any;
    let pageIndex = grid.getEntryState().getCurrentPageIndex();
    let colCount = this.readColumnCount();
    e.setData(this.createGridPageData(pageIndex, colCount));
  }

  private rebuildGridCols(): void {
    let colCount = this.readColumnCount();
    let gridColumns = this.createGridColumns(colCount);
    let clientViewProxy = (this.getView() as any).getService($.kd.bos.mvc.client.IClientViewProxy);

    clientViewProxy.preInvokeControlMethod("entryentity", "createGridColumns", [gridColumns]);
    this.getModel().setEntryProperty(
      "entryentity",
      "data",
      this.createGridPageData(1, colCount)
    );
    this.getView().updateView("entryentity");
  }

  private readColumnCount(): number {
    let value = this.getModel().getValue("gridcols") as string;
    if (value == null || value === "") {
      return 1;
    }
    return Number(value);
  }

  private createGridColumns(colCount: number): any {
    let columns: any[] = [
      {
        entity: "entryentity",
        dataIndex: "seq",
        coltype: "text",
        header: "序号",
        vi: 1,
        w: 80,
        "text-align": "center",
        editor: false
      },
      {
        entity: "entryentity",
        dataIndex: "textfield1",
        coltype: "text",
        header: "文本列",
        vi: 2,
        w: 180,
        editor: true
      }
    ];

    if (colCount > 1) {
      columns.push({
        entity: "entryentity",
        dataIndex: "decimalfield1",
        coltype: "decimal",
        header: "数值列",
        vi: 3,
        w: 120,
        editor: true
      });
    }

    if (colCount > 2) {
      columns.push({
        entity: "entryentity",
        dataIndex: "datefield1",
        coltype: "date",
        header: "日期列",
        vi: 4,
        w: 140,
        editor: true
      });
    }

    return {
      rk: "entryentity",
      seq: "seq",
      columns: columns,
      vi: 1,
      type: "grid"
    };
  }

  private createGridPageData(pageIndex: number, colCount: number): any {
    let rows = this.createRowsData(pageIndex, colCount);
    return {
      rowcount: 20,
      rows: rows,
      pagerows: 10,
      pageindex: pageIndex,
      isSplitPage: true,
      pagecount: 2,
      datacount: 20,
      dataindex: (pageIndex - 1) * 10
    };
  }

  private createRowsData(pageIndex: number, colCount: number): any[] {
    let rows: any[] = [];
    let start = (pageIndex - 1) * 10;

    for (let i = 0; i < 10; i++) {
      let seq = start + i + 1;
      let row: any = {
        seq: seq,
        textfield1: "第 " + seq + " 行文本"
      };

      if (colCount > 1) {
        row.decimalfield1 = seq * 10;
      }

      if (colCount > 2) {
        row.datefield1 = "2026-03-27";
      }

      rows.push(row);
    }

    return rows;
  }
}

let plugin = new CreateGridColumnsDynamicallyPlugin();
export { plugin };
```

## 映射说明

- Java 的 `afterBindData`、`propertyChanged` 都会收敛到同一个 `rebuildGridCols()`，这里保留同样的组织方式，让“首次绑定”和“参数切换”走同一条重建链路。
- Java 用 `preInvokeControlMethod("entryentity", "createGridColumns", ...)` 重建列定义，这里也沿用同一调用点，强调这不是普通的 `setValue` 能替代的场景。
- Java 里的 `entryGridBindData` 会按当前页序号动态回填页数据，这里用 `createGridPageData(pageIndex, colCount)` 复刻了同样的职责分工。

## 注意事项

- 动态列场景里，“列结构”和“页数据”必须同步变化；只改列、不改数据，页面很容易出现空白列或字段错位。
- `gridcols` 这类配置字段最好限制合法值范围，例如只允许 `1`、`2`、`3`，避免前端收到无法解释的列数。
- 这类案例依赖客户端代理和单据体自定义数据结构，真正落业务前建议先在你的表单元数据里确认 `entryentity` 的列键与示例一致。
