# 序列化边界与混用风险说明

## 风险说明

KingScript 运行时存在两套独立的序列化体系，混用会导致序列化结果异常或无法反序列化。

| 序列化体系 | 适用对象 | 核心方法 |
|-----------|---------|---------|
| JS 原生 | JS `[]`、`{}`、string、number | `JSON.stringify()` / `JSON.parse()` |
| Java 平台 | `ArrayList`、`HashMap`、`DynamicObject` | `SerializationUtils.toJsonString()` / `SerializationUtils.fromJsonString()` |

## 核心原则

**禁止混用**：JS 原生对象和 Java 对象不能跨体系序列化/反序列化。

### 高风险写法

```ts
// 错误：用 SerializationUtils 序列化 JS 原生对象
const list = [1, 2, 3];
SerializationUtils.toJsonString(list);
// 结果异常或抛不可捕获异常

// 错误：用 JSON.stringify 序列化 Java 对象
const map = new HashMap();
map.put("key", "value");
JSON.stringify(map);
// 结果不符合预期
```

### 正确写法

```ts
// JS 原生对象 → 用 JSON.stringify / JSON.parse
const jsonObj = { name: "jack" };
const jsonStr = JSON.stringify(jsonObj);
const parsed = JSON.parse(jsonStr);

// Java 对象 → 用 SerializationUtils
const map = new HashMap();
map.put("key", "value");
const jsonStr = SerializationUtils.toJsonString(map);
const restored = SerializationUtils.fromJsonString(jsonStr, HashMap);
```

### 跨体系传值

如果需要将 JS 原生数据存入 Java 对象（或反之），必须先经过对应序列化工具处理：

```ts
const map = new HashMap();
const jsonObj = { name: "jack" };

// 正确：先 JSON.stringify，再存入 HashMap
map.put("key", JSON.stringify(jsonObj));

const jsonStr = SerializationUtils.toJsonString(map);
// 结果：{"key":"{\"name\":\"jack\"}"}
```

## `response.ok` 的序列化约束

`response.ok` 内部使用 Java 平台序列化，因此入参中所有 JS 原生数据结构必须预先转为 Java 集合类型：

- `[]` → `new ArrayList()`
- `{}` → `new HashMap()`

### KWC 场景：`toJavaSafe` 实现

以下工具函数可递归将 JS 原生对象转为 Java 集合类型，确保 `response.ok` 序列化正确：

```ts
import { ArrayList, HashMap, HashSet } from "@cosmic/bos-script/java/util";

function toJavaSafe(obj: any): any {
  if (obj === null || obj === undefined) {
    return obj;
  }
  if (typeof obj === 'string' || typeof obj === 'number' || typeof obj === 'boolean') {
    return obj;
  }
  if (Array.isArray(obj)) {
    const list = new ArrayList();
    for (let i = 0; i < obj.length; i++) {
      list.add(toJavaSafe(obj[i]));
    }
    return list;
  }
  if (obj instanceof Set) {
    const set = new HashSet();
    const entries = Array.from(obj);
    for (let i = 0; i < entries.length; i++) {
      set.add(toJavaSafe(entries[i]));
    }
    return set;
  }
  if (typeof obj === 'object') {
    const map = new HashMap();
    const keys = Object.keys(obj);
    for (let i = 0; i < keys.length; i++) {
      map.put(keys[i], toJavaSafe(obj[keys[i]]));
    }
    return map;
  }
  return obj;
}

// 使用示例
response.ok(toJavaSafe({
  total: rows.size(),
  items: [{ id: 1, name: 'test' }]
}));
```

## 输出前自检

- 是否用 `JSON.stringify` 处理了 Java 对象？（应改用 `SerializationUtils`）
- 是否用 `SerializationUtils` 处理了 JS 原生对象？（应改用 `JSON.stringify`）
- `response.ok` 入参中是否还有未转换的 JS 原生 `[]` / `{}`？
- 嵌套结构中每一层是否都已转为对应体系的类型？
