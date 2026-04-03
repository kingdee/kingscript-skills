# /ks-generate

当用户想要生成新的 Kingscript 脚本或插件草稿时使用此命令。

## 优先阅读

1. `../../references/templates/README.md`
2. `../../references/templates/` 中最相关的模板
3. `../../references/examples/` 中最相关的文件
4. 如果涉及 SDK，再读 `../../references/sdk/`
5. 如果涉及语法限制，再读 `../../references/language/kingscript/README.md`

## 输出格式

- 目标
- 假设
- 代码
- 说明
- 风险

## 生成约束

- 输出代码前，必须检查所有非全局符号是否已显式 import
- 不要依赖 IDE、编辑器或运行环境自动补 import
- 如果使用了类、助手类、事件类、枚举、工具类但无法确认 import 路径，先回到 `../../references/sdk/` 或 `../../references/examples/` 查证
- 如果某个符号不需要 import，必须在说明中交代原因
