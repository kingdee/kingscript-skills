# OperateOption

## 基本信息

- 名称: `OperateOption`
- Java 类名: `kd.bos.dataentity.OperateOption`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/dataentity`
- 类型: 操作选项对象

## 用途概览

`OperateOption` 是操作链路里最常见的“附加参数容器”。很多保存、提交、下推、服务端操作都会把扩展参数塞到这里。

## 高频用法

| 方法 | 作用 |
|------|------|
| `create()` | 创建空选项 |
| `setVariableValue(name, value)` | 写入扩展变量 |
| `getVariableValue(name, defaultValue)` | 读取变量 |
| `containsVariable(name)` | 判断变量是否存在 |
| `copy()` / `merge(...)` | 复制或合并选项 |

## 运行时注意事项

- 它更像键值容器，不要把它误当成强类型 DTO。
- 变量名建议固定并统一大小写习惯，避免跨插件取不到值。
- 复杂操作链路里最好明确约定“谁写入、谁读取”。

## 常见搭配

- 操作对象: [FormOperate.md](FormOperate.md)
- 转换插件: [AbstractConvertPlugIn.md](AbstractConvertPlugIn.md)

## 关键词

- 中文: 操作选项, 扩展参数, 操作变量
- 英文: `OperateOption`
