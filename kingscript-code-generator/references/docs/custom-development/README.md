# 定制开发专题

这个目录存放不完全属于 `examples / templates / sdk / language` 四类的定制开发专题资料。

适合优先放这里的内容：

- 某一类扩展能力的完整开发指南
- 配置规则、部署规则、权限规则较多的专题
- 既包含示例代码，也包含实现边界和适用场景说明的文档

## 当前文档

- `脚本控制器开发指南.md`
  - 面向 KWC（Kingdee Web Controller）脚本控制器开发
  - 包含控制器 XML 配置、URL 规则、权限配置、请求处理 API、响应处理 API
- `controller-safe-template.md`
  - KWC 控制器保守模板，默认可直接复用的稳定起手式
  - 覆盖 `QueryServiceHelper.query`、`DynamicObject` 读取、安全数值转换与对象化响应
- `runtime-bigdecimal.md`
  - BigDecimal/金额字段运行时处理约束
  - 约束 `Number()/toFixed()/Number.isFinite()` 禁用与安全替代写法
- `runtime-date-bridge.md`
  - Java Date 与 JS Date 桥接风险说明
  - 约束日期运算与 QFilter 日期入参的保守处理方式
- `runtime-dynamicobject.md`
  - `DynamicObject` 读取规范
  - 约束 `row.get('fieldKey')` 的标准读取姿势和后置转换顺序
- `faq-runtime-pitfalls.md`
  - 常见运行时坑位 FAQ（症状、原因、错误写法、正确写法）
  - 重点覆盖 optional chaining、BigDecimal、顶层数组响应、adapterApi 配置、QFilter 日期问题、`static` 禁用

## 使用建议

- 用户提到 `KWC`、`脚本控制器`、`controller`、`REST API`、`Web API` 时，优先阅读本目录
- 默认先读 `脚本控制器开发指南.md` + `controller-safe-template.md`
- 涉及金额/日期/DynamicObject 时，再读对应 `runtime-*.md`
- 排查线上异常时，再补读 `faq-runtime-pitfalls.md`
- 如果还需要具体类、方法或声明，再回到 `references/sdk/`
- 如果还需要更贴近业务的代码写法，可继续补查 `references/examples/`
