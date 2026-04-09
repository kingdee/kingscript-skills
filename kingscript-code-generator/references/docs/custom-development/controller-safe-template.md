# KWC Controller 保守稳定模板

推荐优先使用本模板作为脚本控制器默认起手式。

约束说明：

- 使用保守 ES 子集，不使用 `?.`、`??`
- 金额字段使用保守数值转换
- 顶层响应返回对象，列表字段使用 JSON 字符串
- 禁止定义 `static` 方法和 `static` 变量

```ts
class DemoController {
  private toSafeNumber(value: any): number {
    if (value === null || value === undefined || value === '') {
      return 0;
    }
    const text = `${value}`;
    const parsed = parseFloat(text);
    return isNaN(parsed) ? 0 : parsed;
  }

  getData(request: any, response: any) {
    try {
      const rows = QueryServiceHelper.query(
        'entity_name',
        'field1,field2,amountfield,bizdate',
        [],
        ''
      );

      const items: any[] = [];
      const iterator = rows.iterator();

      while (iterator.hasNext()) {
        const row = iterator.next();

        const nameValue = row.get('field1');
        const amountValue = row.get('amountfield');
        const dateValue = row.get('bizdate');

        const amount = this.toSafeNumber(amountValue);

        items.push({
          name: nameValue === null || nameValue === undefined ? '' : `${nameValue}`,
          amount,
          date: dateValue === null || dateValue === undefined ? '' : `${dateValue}`
        });
      }

      response.ok({
        itemsJson: JSON.stringify(items)
      });
    } catch (error) {
      response.throwException(`获取数据失败: ${error}`, 500, 'GET_DATA_ERROR');
    }
  }
}

const kwcController = new DemoController();
export { kwcController };
```
