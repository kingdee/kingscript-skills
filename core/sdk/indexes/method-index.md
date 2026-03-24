# SDK 方法级索引（第一版）

本文件同时承担两件事：

- 定义方法级索引的建设方式
- 说明如何使用已经生成的 `core/sdk/manifests/methods.json`

## 当前状态

第一版方法清单已经从本地 `.d.ts` 扫描生成，落在：

- `core/sdk/manifests/methods.json`
- `core/sdk/indexes/methods-by-name.md`
- `core/sdk/indexes/methods-hot.md`
- `core/sdk/indexes/methods-lifecycle.md`

当前已接入的结构化字段包括：

- `module`
- `file`
- `package`
- `namespace`
- `namespace_path`
- `class_name`
- `target`
- `owner_declaration`
- `owner_kind`
- `method_name`
- `signature`
- `parameters`
- `parameter_count`
- `return_type`
- `optional`
- `line`
- `source_file`
- `doc_source`
- `summary`
- `method_kind`
- `keywords`
- `scenarios`
- `overload_index`

当前清单规模：

- 方法记录数：`46344`
- 静态方法：`5601`
- 实例方法：`35875`
- 构造方法：`4868`
- 生命周期方法：`409`
- 事件方法：`113`

## 第一版可读入口

### 1. 按方法名字母序检索

- 入口文件：`core/sdk/indexes/methods-by-name.md`
- 适用问题：
  - 我知道方法名，但不知道它属于哪个类
  - 我想先按名字快速缩小范围

### 2. 按高频方法检索

- 入口文件：`core/sdk/indexes/methods-hot.md`
- 适用问题：
  - 我想按二开任务快速找到高价值方法
  - 我不知道该先看查询、视图还是生命周期

### 3. 按生命周期方法检索

- 入口文件：`core/sdk/indexes/methods-lifecycle.md`
- 适用问题：
  - 我想确认某个钩子写在哪
  - 我想先看真实检出的生命周期方法

## 为什么要有方法级索引

现在的全量索引已经能做到：

- 模块级定位
- 包级定位
- 类级定位

但还缺一层：

- 方法级定位

也就是用户问：

- `loadSingle` 怎么用
- `queryOne` 和 `load` 的区别是什么
- `beforePropertyChanged` 应该放在哪个基类
- `onAddValidators` 什么时候触发

这类问题只靠类索引还不够。

## 第一版目标

方法级索引先解决 4 件事：

1. 方法属于哪个类
2. 方法的名字是什么
3. 方法大致用于什么场景
4. 方法应该跳到哪个知识卡或示例

## 推荐产物

### 1. 结构化清单

放置位置：

- `core/sdk/manifests/methods.json`

当前字段：

- `module`
- `package`
- `namespace`
- `class_name`
- `method_name`
- `signature`
- `source_file`
- `doc_source`
- `method_kind`
  - 实例方法
  - 静态方法
  - 构造方法
  - 生命周期方法
  - 事件方法
- `keywords`
- `scenarios`
- `overload_index`

### 2. 可读索引

放置位置：

- `core/sdk/indexes/method-index.md`

第一版建议按 4 个入口继续增强：

- 按类看方法
- 按方法名看归属
- 按场景看常用方法
- 按插件生命周期看事件方法

### 3. 方法知识卡

不是所有方法都要单独成卡。

只给这两类方法做方法卡：

- 高风险方法
- 高频生命周期方法

放置位置建议：

- `core/sdk/methods/`

## 第一版优先收录的方法类型

### 高频服务方法

- `load`
- `loadSingle`
- `queryOne`

### 高频插件生命周期方法

- `propertyChanged`
- `beforePropertyChanged`
- `afterLoadData`
- `onAddValidators`
- `beforeExecuteOperationTransaction`
- `afterExecuteOperationTransaction`

### 高频页面与视图方法

- `getView`
- `getModel`
- `updateView`
- `setEnable`

## 方法级索引的生成策略

### 第一步：从 `.d.ts` 提取签名

目标：

- 提取类中的方法名与签名
- 关联所属模块、包、类、命名空间

### 第二步：从 Javadoc 补语义

目标：

- 补参数说明
- 补返回值说明
- 补废弃信息
- 补版本或使用限制

### 第三步：从示例和 FAQ 补场景

目标：

- 补用户真实问法
- 补典型场景
- 补常见坑

## 第一版索引展示建议

### 1. 按类查看

| 类 | 高频方法 | 入口文档 |
|----|----------|----------|
| `BusinessDataServiceHelper` | `load`、`loadSingle` | 类知识卡 |
| `QueryServiceHelper` | `queryOne` | 类知识卡 |
| `AbstractBillPlugIn` | `propertyChanged`、`afterLoadData` | 类知识卡 |
| `AbstractOperationServicePlugIn` | `onAddValidators`、`beforeExecuteOperationTransaction` | 类知识卡 |

### 2. 按方法查看

| 方法 | 所属类 | 场景 | 风险 |
|------|--------|------|------|
| `loadSingle` | `BusinessDataServiceHelper` | 单条加载 | 类型与过滤条件 |
| `queryOne` | `QueryServiceHelper` | 只读查询 | 查询为空与上下文 |
| `onAddValidators` | `AbstractOperationServicePlugIn` | 操作前校验 | 字段预加载 |

## 当前使用方式

当用户已知方法名时，建议按下面顺序检索：

1. 先读 `core/sdk/indexes/method-index.md`
2. 再按问题类型进入 `methods-by-name.md`、`methods-hot.md` 或 `methods-lifecycle.md`
3. 然后在 `core/sdk/manifests/methods.json` 里定位目标方法
4. 根据 `target` 跳转到类知识卡或类索引
5. 如果需要语义补充，再回退到本地 `.d.ts` 或在线 Javadoc

## 建设边界

- 第一版已经完成“自动扫描生成 methods.json”
- 下一步优先补“按方法名、按类名、按场景”的可读方法索引
- 再下一步给高频方法补方法卡和 Javadoc 语义

## 相关文档

- [strategy.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/strategy.md)
- [class-index.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/indexes/class-index.md)
- [sdk-method-template.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/templates/sdk-method-template.md)
