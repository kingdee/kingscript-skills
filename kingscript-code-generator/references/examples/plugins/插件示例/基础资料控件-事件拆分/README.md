# 基础资料控件事件拆分

本目录聚焦 F7、基础资料控件及快速新增相关事件，优先覆盖“选择前过滤”“选择后回填”“快速新增前校验”这几类高频问法。

## 事件目录

- [beforeF7Select.md](beforeF7Select.md)
- [afterF7Select.md](afterF7Select.md)
- [beforeFilterF7Select.md](beforeFilterF7Select.md)
- [beforeQuickAddNew.md](beforeQuickAddNew.md)

## 使用建议

- 需要限制可选范围时，优先看 `beforeF7Select` 和 `beforeFilterF7Select`。
- 需要选择后自动回填时，优先看 `afterF7Select`。
- 需要阻止不满足条件的快速新增时，优先看 `beforeQuickAddNew`。
