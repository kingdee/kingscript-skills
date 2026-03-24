# 报错分析模板

适用于“已有脚本报错、运行异常、调试失败、声明存在但调用不通”的场景。

## 推荐输出结构

### 1. 现象

- 报错文本
- 触发步骤
- 所属插件类型、事件、业务对象
- 编辑期、运行期还是部署后出现

### 2. 可能根因

1. 上下文或插件类型不匹配
2. 声明存在但运行时能力未开放
3. Java 类型与 JS 类型不匹配
4. 权限、租户、账套、组织边界不满足

### 3. 排查顺序

1. 先确认场景和事件
2. 再确认当前调用的 SDK 是否已开放
3. 再确认参数类型和返回值类型
4. 最后验证环境、权限和版本

### 4. 修复建议

- 给出最小改动方案
- 必要时附一段修正后的代码

### 5. 回归验证

- 验证原问题是否消失
- 验证相邻场景是否被误伤

## 已填充示例

下面给出一个真实高频问题示例：`QFilter` 在 `in` 查询里报类型转换错误。

### 现象

- 使用 `BusinessDataServiceHelper.load` 查询币别
- 过滤条件使用 `QCP.in`
- 运行时报类型转换异常

### 可能根因

1. 把单个 `QFilter` 内部的值集合写成了普通 TS 数组
2. 误以为 `.d.ts` 里参数能通过，运行时也会自动兼容
3. 混淆了“外层 filters 是数组”和“内层 in 参数要用 Java 集合”这两个层次

### 排查顺序

1. 先看报错发生在哪个过滤条件
2. 检查 `QCP.in` 对应的第三个参数是不是 Java 集合类型
3. 检查外层 `filters` 是否仍然是 TS 数组
4. 再确认实体名、字段名和查询条件本身是否正确

### 修复建议

单个 `QFilter` 内部改用 `ArrayList`，多个 `QFilter` 之间仍然使用 TS 数组。

```kingscript
let filters = [];
let list = new ArrayList();
list.add("CNY");
list.add("USD");
filters.push(new QFilter("number", QCP.in, list));
let datas = BusinessDataServiceHelper.load("bd_currency", "name", filters);
```

### 回归验证

- `load` 调用不再报类型转换异常
- 查询结果能正确返回 `CNY`、`USD`
- 相同模式下的其他 `in` 查询也能正常运行
