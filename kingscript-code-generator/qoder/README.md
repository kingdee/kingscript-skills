# kingscript-code-generator

用于在本地资料库基础上处理 Kingscript 二开任务，包括示例检索、SDK 映射、Java 样例抽取和脚本生成辅助。

## 使用前配置

这个 skill 不应该依赖某一台机器的固定路径。安装后，先配置本地资源路径。

### 推荐方式

1. 复制 `local-paths.example.json` 为 `local-paths.json`
2. 把里面的路径改成你自己机器上的目录

## 路径发现顺序

这个 skill 会按下面顺序查找本地资源：

1. skill 目录下的 `local-paths.json`
2. 当前工作区说明文件中声明的资源路径
3. 默认目录发现

如果你本地还挂了最全的外部 SDK 文档包或反编译知识库，建议把它写到 `bos_docs_path`。这层属于长尾扩展层，只在仓库内 `references/` 不够时再进入。

## 验证

配置完成后，至少确认这些路径真实存在：

- `references_root`
- `examples_root`
- `sdk_root`
- `templates_root`
- `language_root`
- `java_sample_jar`
- `bos_docs_path`
