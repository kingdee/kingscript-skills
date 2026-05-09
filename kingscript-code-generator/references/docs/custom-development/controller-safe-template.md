# KWC Controller 保守稳定模板

推荐优先使用本模板作为脚本控制器默认起手式。

约束说明：

- 使用保守 ES 子集，不使用 `?.`、`??`
- 金额字段使用保守数值转换
- 顶层响应返回对象，列表字段使用 JSON 字符串或 `ArrayList`
- **response.ok 入参中，所有 JS 原生数据结构必须转为 Java 集合类型**：`[]` → `ArrayList`、`{}` → `HashMap`、`Set` → `HashSet`
- 禁止定义 `static` 方法和 `static` 变量
- 禁止对 `DynamicObjectCollection` 使用 `for-of`，只能用 `size()+get(i)` 或 `iterator`
- 异常信息获取统一用 `'' + e`，禁止 `e.message` / `e.getMessage()` / `String(e)`
- 分录字段查询必须带 `entryentity.` 前缀（前缀取决于分录标识，默认为 `entryentity`，多分录可能为 `entryentity1` 等）
- `QueryServiceHelper.query` 只有 4 参数签名，无 limit 位

## 工具函数

### toSafeNumber — 保守数值转换

```ts
private toSafeNumber(value: any): number {
  if (value === null || value === undefined || value === '') {
    return 0;
  }
  const text = `${value}`;
  const parsed = parseFloat(text);
  return isNaN(parsed) ? 0 : parsed;
}
```

### toJavaSafe — 递归转换为 Java 集合类型

将 JS 原生数据结构递归转为 Java 集合类型，确保 `response.ok` 序列化正确。

- `[]` → `new ArrayList()`
- `{}` → `new HashMap()`
- `Set` → `new HashSet()`
- 基本类型（string/number/boolean/null）保持不变

```ts
private toJavaSafe(obj: any): any {
  if (obj === null || obj === undefined) {
    return obj;
  }
  if (typeof obj === 'string' || typeof obj === 'number' || typeof obj === 'boolean') {
    return obj;
  }
  // JS Array → ArrayList
  if (Array.isArray(obj)) {
    const list = new ArrayList();
    for (let i = 0; i < obj.length; i++) {
      list.add(this.toJavaSafe(obj[i]));
    }
    return list;
  }
  // JS Set → HashSet
  if (obj instanceof Set) {
    const set = new HashSet();
    const entries = Array.from(obj);
    for (let i = 0; i < entries.length; i++) {
      set.add(this.toJavaSafe(entries[i]));
    }
    return set;
  }
  // JS Object → HashMap
  if (typeof obj === 'object') {
    const map = new HashMap();
    const keys = Object.keys(obj);
    for (let i = 0; i < keys.length; i++) {
      map.put(keys[i], this.toJavaSafe(obj[keys[i]]));
    }
    return map;
  }
  return obj;
}
```

### readString — 安全读取字段为字符串

```ts
private readString(row: any, fieldKey: string): string {
  const value = row.get(fieldKey);
  return value === null || value === undefined ? '' : `${value}`;
}
```

### readAmount — 安全读取金额/数值字段

```ts
private readAmount(row: any, fieldKey: string): number {
  return this.toSafeNumber(row.get(fieldKey));
}
```

### readDateStr — 安全读取日期字段为字符串

> 禁止直接使用 `row.getDate(field)`，某些字段类型会抛不可捕获异常导致 500。
> 正则仅为示例，实际格式取决于字段类型和运行时行为。

```ts
private readDateStr(row: any, fieldKey: string): string {
  return this.readString(row, fieldKey);
}

// 如需提取年月等部分，根据实际格式做正则解析
private readYearMonth(dateStr: string): { year: string; month: string } {
  const match = dateStr.match(/(\d{4})-(\d{1,2})/);
  return {
    year: match ? match[1] : '',
    month: match ? match[2] : ''
  };
}
```

## 完整模板示例

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

  private toJavaSafe(obj: any): any {
    if (obj === null || obj === undefined) {
      return obj;
    }
    if (typeof obj === 'string' || typeof obj === 'number' || typeof obj === 'boolean') {
      return obj;
    }
    if (Array.isArray(obj)) {
      const list = new ArrayList();
      for (let i = 0; i < obj.length; i++) {
        list.add(this.toJavaSafe(obj[i]));
      }
      return list;
    }
    if (obj instanceof Set) {
      const set = new HashSet();
      const entries = Array.from(obj);
      for (let i = 0; i < entries.length; i++) {
        set.add(this.toJavaSafe(entries[i]));
      }
      return set;
    }
    if (typeof obj === 'object') {
      const map = new HashMap();
      const keys = Object.keys(obj);
      for (let i = 0; i < keys.length; i++) {
        map.put(keys[i], this.toJavaSafe(obj[keys[i]]));
      }
      return map;
    }
    return obj;
  }

  private readString(row: any, fieldKey: string): string {
    const value = row.get(fieldKey);
    return value === null || value === undefined ? '' : `${value}`;
  }

  private readAmount(row: any, fieldKey: string): number {
    return this.toSafeNumber(row.get(fieldKey));
  }

  private readDateStr(row: any, fieldKey: string): string {
    return this.readString(row, fieldKey);
  }

  // 单头字段 + 分录字段查询示例
  // 单头字段直接写字段名，分录字段必须带分录标识前缀
  getData(request: any, response: any) {
    try {
      // 单头字段：field1, amountfield, bizdate
      // 分录字段：entryentity.kdtest_combofield, entryentity.kdtest_amountfield1
      const rows = QueryServiceHelper.query(
        'entity_name',
        'field1,amountfield,bizdate,entryentity.kdtest_combofield,entryentity.kdtest_amountfield1',
        [],
        ''
      );

      const items = new ArrayList();
      const iterator = rows.iterator();

      while (iterator.hasNext()) {
        const row = iterator.next();

        const item = new HashMap();
        item.put('name', this.readString(row, 'field1'));
        item.put('amount', this.readAmount(row, 'amountfield'));
        item.put('date', this.readDateStr(row, 'bizdate'));

        items.add(item);
      }

      response.ok(this.toJavaSafe({
        items: items
      }));
    } catch (e) {
      response.throwException('获取数据失败: ' + e, 500, 'GET_DATA_ERROR');
    }
  }
}

const kwcController = new DemoController();
export { kwcController };
```

### 遍历方式说明

`DynamicObjectCollection` 不支持 JS `for-of`，只能使用以下两种方式：

```ts
// 方式一：iterator 遍历（推荐）
const iterator = rows.iterator();
while (iterator.hasNext()) {
  const row = iterator.next();
}

// 方式二：size() + get(i) 索引遍历
for (let i = 0; i < rows.size(); i++) {
  const row = rows.get(i);
}

// 禁止：for-of 会抛不可捕获异常 → 500
// for (const row of rows) { ... }  // ← 禁止
```
