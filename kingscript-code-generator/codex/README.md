# kingscript-code-generator

用于在本地资料库基础上处理 Kingscript 二开任务，包括示例检索、SDK 映射、Java 样例抽取和脚本生成辅助。

## 使用前配置

这个 skill 不应该依赖某一台机器的固定路径。安装后，先配置本地资源路径。

### 推荐方式

1. 复制 `local-paths.example.json` 为 `local-paths.json`
2. 把里面的路径改成你自己机器上的目录

示例：

```json
{
  "workspace_root": "D:\\kingscript skills",
  "repo_root": "D:\\kingscript skills\\kingscript-code-generator",
  "references_root": "D:\\kingscript skills\\kingscript-code-generator\\references",
  "examples_root": "D:\\kingscript skills\\kingscript-code-generator\\references\\examples",
  "sdk_root": "D:\\kingscript skills\\kingscript-code-generator\\references\\sdk",
  "templates_root": "D:\\kingscript skills\\kingscript-code-generator\\references\\templates",
  "language_root": "D:\\kingscript skills\\kingscript-code-generator\\references\\language\\kingscript",
  "java_sample_jar": "D:\\kingscript skills\\bos-plugin-sample-7.0.jar"
}
```

## 路径发现顺序

这个 skill 会按下面顺序查找本地资源：

1. skill 目录下的 `local-paths.json`
2. 当前工作区 `AGENTS.md` 中声明的资源路径
3. 默认目录发现

如果你本地还挂了最全的外部 SDK 文档包或反编译知识库，建议把它写到 `bos_docs_path`。这层属于长尾扩展层，只在仓库内 `references/` 不够时再进入。
如果你还没有外部知识盘，可以使用仓库根目录提供的 `sdks.zip`，先解压，再把解压目录填到 `bos_docs_path`。

建议优先使用 `local-paths.json`，因为它最直接，也最适合不同机器单独配置。

## AGENTS.md 备用写法

如果你不想单独维护 `local-paths.json`，也可以在工作区 `AGENTS.md` 里增加一段：

```md
## Kingscript Local Resources

- `workspace_root`: `D:\kingscript skills`
- `repo_root`: `D:\kingscript skills\kingscript-code-generator`
- `references_root`: `D:\kingscript skills\kingscript-code-generator\references`
- `java_sample_jar`: `D:\kingscript skills\bos-plugin-sample-7.0.jar`
```

## 重装说明

如果你已经在安装目录里维护了 `local-paths.json`，重新执行安装脚本时会自动保留这份本地配置，不需要重复填写。

## 验证

配置完成后，至少确认这些路径真实存在：

- `references_root`
- `examples_root`
- `sdk_root`
- `templates_root`
- `language_root`
- `java_sample_jar`
- `bos_docs_path`
