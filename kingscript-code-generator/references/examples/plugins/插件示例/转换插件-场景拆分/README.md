# 转换插件-场景拆分

这个目录聚焦“源单下推到目标单以后还要怎么加工”的问题，优先沉淀最常见的两类动作：修改转换结果，以及在下推前控制可推数据和建链行为。

## 案例列表

- [`splitTargetRowsAfterConvert.md`](./splitTargetRowsAfterConvert.md): 读取来源行信息，并在转换后按数量拆分目标数据
- [`appendPushFiltersAndLinkControl.md`](./appendPushFiltersAndLinkControl.md): 下推前追加过滤条件，并按业务规则控制是否建立源目标关联

## 使用建议

- 如果你处理的是单据下推、字段映射、目标单补写，优先看这里。
- 如果问题发生在普通表单点击或操作校验，不要误用转换插件，应回到表单或操作插件目录。
