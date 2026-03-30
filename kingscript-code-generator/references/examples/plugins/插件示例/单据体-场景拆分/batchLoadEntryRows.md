# batchLoadEntryRows - 按页批量装载大分录

## 场景

单据体需要承载成百上千行数据，但页面首屏不希望一次性把全部分录都塞进来。更常见的做法是按页批量装载当前窗口需要的行，再把总行数、起始行、页大小这些状态单独维护起来。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.entrygrid.bizcase.BatchLoadEntryRowsSample`

这个 Java 样例的重点有两层：

- 新建数据后只灌入当前页分录，而不是一次性灌满 10000 行
- 同时维护总行数、页大小和起始行，让后续翻页控件仍然知道自己在处理“大分录”

## 适用入口

- `afterCreateNewData(e: $.java.util.EventObject): void`
- 自定义翻页或按钮回调里复用 `loadEntryPage(startIndex)`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";

class BatchLoadEntryRowsPlugin extends AbstractFormPlugin {

  private entryKey = "entryentity";
  private totalRowCount = 10000;
  private pageSize = 200;

  afterCreateNewData(e: $.java.util.EventObject): void {
    super.afterCreateNewData(e);
    this.loadEntryPage(0);
  }

  loadNextPage(): void {
    let startIndex = this.getModel().getValue("entrystartindex") as number;
    let nextIndex = (startIndex == null ? 0 : startIndex) + this.pageSize;

    if (nextIndex >= this.totalRowCount) {
      this.getView().showTipNotification("已经加载到最后一页。");
      return;
    }

    this.loadEntryPage(nextIndex);
  }

  private loadEntryPage(startIndex: number): void {
    this.getModel().deleteEntryData(this.entryKey);

    let rowCount = Math.min(this.pageSize, this.totalRowCount - startIndex);
    let newRows = this.getModel().batchCreateNewEntryRow(this.entryKey, rowCount);

    for (let i = 0; i < newRows.length; i++) {
      let rowIndex = newRows[i];
      let seq = startIndex + i + 1;

      this.getModel().setValue("seq", seq, rowIndex);
      this.getModel().setValue("textfield1", "这是第" + seq + "行的文本字段值", rowIndex);
      this.getModel().setValue("qty", i + 1, rowIndex);
    }

    this.getModel().setValue("entrytotalcount", this.totalRowCount);
    this.getModel().setValue("entrypagesize", this.pageSize);
    this.getModel().setValue("entrystartindex", startIndex);
    this.getView().updateView(this.entryKey);
  }
}

let plugin = new BatchLoadEntryRowsPlugin();
export { plugin };
```

## 映射说明

- Java 样例把“分录实际装载量”和“总行数”拆开管理，这里同样只创建当前页行数，同时把 `entrytotalcount`、`entrypagesize`、`entrystartindex` 单独存起来。
- Java 中每行都会补 `seq` 和示例文本字段，这里保留了同样的填充方式，方便看清“当前页索引”和“真实业务序号”之间的关系。
- Java 还进一步通过 `onGetControl` 替换自定义分页控件；这篇 Kingscript 案例先把最常复用的“按页清空再装载”主干抽出来，方便直接套到按钮翻页或查询回调里。

## 注意事项

- 先清空再批量装载时，要确认当前页数据是否允许被直接覆盖，否则翻页前要先做保存或脏数据提醒。
- `batchCreateNewEntryRow` 返回的是本次新建出来的行索引数组，补值时不要误用循环变量 `i` 当成真实行索引。
- 如果分页状态最终要和控件分页条联动，建议把 `entrytotalcount`、`entrypagesize` 这些字段固定成页面模型的一部分，不要只放在临时变量里。
