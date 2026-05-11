# KWC 脚本控制器安全模板

推荐优先使用本模板作为脚本控制器默认起手式。

## 适用场景

- 快速创建 RESTful API 接口
- 简单的 CRUD 数据查询与返回
- 第三方系统集成接口
- 需要频繁修改的业务规则接口

## 保守约束

本模板遵循 `gotchas/` 中定义的保守约束。生成代码前必须确认：

- 不使用 `?.`、`??` 等现代语法（详见 `../gotchas/README.md` 坑 1）
- 金额/数值字段使用保守转换（详见 `../gotchas/bigdecimal.md`）
- 顶层响应必须返回对象，禁止直接返回数组（详见 `../gotchas/README.md` 坑 7）
- `response.ok` 入参中 JS 原生数据结构必须转为 Java 集合类型（详见 `../gotchas/README.md` 坑 7、8、`../gotchas/serialization.md`）
- 禁止定义 `static` 方法和变量（详见 `../gotchas/README.md` 坑 3）
- 禁止对 `DynamicObjectCollection` 使用 `for-of`（详见 `../gotchas/README.md` 坑 5）
- 异常信息获取统一用 `'' + e`（详见 `../gotchas/README.md` 坑 4）
- 分录字段查询必须带 `entryentity.` 前缀（详见 `../gotchas/README.md` 坑 12）
- `QueryServiceHelper.query` 只有 4 参数签名（详见 `../gotchas/README.md` 坑 13）

> 如需了解症状、原因和更多错误示例，直接阅读 `../gotchas/README.md` 对应坑位。

## XML 配置示例

创建与脚本同名的 `.xml` 文件：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Controller>
    <name>DemoScriptController</name>
    <isv>kingdee</isv>
    <app>dev</app>
    <version>1</version>
    <url>/kd/dev/sample/demo</url>
    <scriptFile>DemoScriptController.ts</scriptFile>
    <methods>
        <method>
            <name>getData</name>
            <url>/data</url>
            <httpMethod>GET</httpMethod>
            <permission>
                <permission>
                    <permitAll>false</permitAll>
                    <entityNumber>your_entity_number</entityNumber>
                    <permItemId>your_perm_item_id</permItemId>
                    <checkRightApp>dev</checkRightApp>
                </permission>
            </permission>
        </method>
    </methods>
</Controller>
```

## 脚本代码模板

```typescript
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { ArrayList, HashMap, HashSet } from "@cosmic/bos-script/java/util";

class DemoScriptController {

  // === 保守数值转换 ===
  private toSafeNumber(value: any): number {
    if (value === null || value === undefined || value === '') {
      return 0;
    }
    const text = `${value}`;
    const parsed = parseFloat(text);
    return isNaN(parsed) ? 0 : parsed;
  }

  // === 递归转为 Java 集合类型（确保 response.ok 序列化正确） ===
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

  // === 安全读取字段 ===
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

  // === 接口方法示例 ===
  getData(request: any, response: any) {
    try {
      // 获取查询参数
      const keyword = request.getStringQueryParam('keyword');

      // 查询数据（分录字段必须带 entryentity. 前缀）
      const rows = QueryServiceHelper.query(
        'entity_name',
        'field1,amountfield,bizdate,entryentity.kdtest_combofield',
        [],
        ''
      );

      // 遍历结果（禁止使用 for-of，使用 iterator）
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

      // 返回结果（必须用 toJavaSafe 包装，确保序列化正确）
      response.ok(this.toJavaSafe({
        total: rows.size(),
        items: items
      }));
    } catch (e) {
      response.throwException('获取数据失败: ' + e, 500, 'GET_DATA_ERROR');
    }
  }
}

const kwcController = new DemoScriptController();
export { kwcController };
```

## 遍历方式说明

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

## 常用 request API

| 方法 | 说明 |
|------|------|
| `request.getHttpMethod()` | 获取 HTTP 方法 |
| `request.getPathVariable('id')` | 获取路径参数（string） |
| `request.getLongPathVariable('id')` | 获取路径参数（long） |
| `request.getStringQueryParam('name')` | 获取查询参数（string） |
| `request.getIntQueryParam('age')` | 获取查询参数（int） |
| `request.getBooleanQueryParam('active')` | 获取查询参数（boolean） |
| `request.getHeader('Authorization')` | 获取请求头 |
| `request.getMapBody()` | 获取请求体（Map） |
| `request.getStringBody()` | 获取请求体（string） |

## 常用 response API

| 方法 | 说明 |
|------|------|
| `response.ok(data)` | 成功响应（data 必须为对象，内部数组需为 ArrayList） |
| `response.throwException(msg, httpStatus, bizCode)` | 抛出业务异常 |

## 下一步

- 需要完整的请求/响应 API 说明 → `../docs/脚本控制器开发指南.md`
- 需要保守转换、数值/日期处理等运行时约束 → `../gotchas/`
- 需要 SDK 类、方法声明 → `../sdk/`
