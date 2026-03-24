# Kingscript Cases

这个目录存放真实二开案例，重点沉淀“业务目标 -> 方案 -> 代码 -> 坑点 -> 可复用结论”。

## 一个案例建议包含

- 背景和业务目标
- 触发点和上下文
- 关键代码
- 调用的 SDK 或开放能力
- 踩坑记录
- 最终结论

## 命名建议

- `sales-order-before-save.md`
- `expense-form-button-submit.md`
- `metadata-rowmeta-bridge.md`

## 当前案例

- [purchase-order-supplier-fill.md](purchase-order-supplier-fill.md)
  - 场景：采购订单选择供应商后自动回填联系人、电话、地址和银行信息
  - 价值：可复用为“子页面选择 -> 回调返回 -> 查主数据 -> 回填当前单据”的通用范式
