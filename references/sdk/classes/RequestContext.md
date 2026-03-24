# RequestContext

## 基本信息

- 名称：`RequestContext`
- Java 类名：`kd.bos.context.RequestContext`
- TS 导出名：`RequestContext`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.context`
- 类型：请求上下文与会话上下文对象
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-framework.d.ts`
  - Javadoc：待补充

## 用途概述

用于获取当前登录用户、组织、租户、语言和请求上下文信息，是脚本读取“当前是谁、处于哪个租户和组织”时最核心的入口之一。

## 典型场景

- 获取当前用户 ID、当前组织、登录组织
- 判断租户、账套、语言环境
- 在需要复制上下文的新线程或异步场景中传递上下文
- 排查“本地能跑、线上上下文为空”这类问题

## 用户常见问法

- 怎么取当前登录用户
- 怎么取当前组织
- 怎么判断租户
- `RequestContext.get()` 和 `getOrCreate()` 有什么区别

## 常见搭配

- `BusinessDataServiceHelper`
  - 结合当前用户或组织做条件查询
- `AbstractBillPlugIn`
  - 在插件事件中读取上下文
- `AbstractFormPlugin`
  - 在表单逻辑中读取当前登录信息

## 高频方法

- `get()`
- `create()`
- `getOrCreate()`
- `copy()`
- `copyAndSet()`
- `set()`
- `getCurrUserId()`
- `getTenantCode()`
- `getOrgId()`
- `getLang()`
- `getLoginOrg()`

## 高价值规则

- 取“当前用户、组织、租户”时，优先从 `RequestContext` 读，不要自己猜测页面参数
- `get()` 更适合读取当前线程上下文，`getOrCreate()` 更适合兜底获取上下文对象
- `copy()`、`copyAndSet()` 更偏底层上下文传递，不是普通表单脚本的高频入口

## 运行时注意事项

- 上下文值是否可用，和当前插件类型、调用时机、是否跨线程密切相关
- 即使声明存在，也不能默认任意场景下都能读到完整登录信息
- 如果问题涉及权限、租户、组织隔离，要同时结合运行环境和接口约束判断

## 常见错误

### 1. 上下文不为空，但字段取不到

高概率原因：
- 当前时机不对，登录上下文尚未建立
- 运行在跨线程或异步场景，但没有正确复制上下文
- 把页面参数当成了请求上下文

## 相关文档

- [AbstractBillPlugIn.md](AbstractBillPlugIn.md)
- [AbstractFormPlugin.md](AbstractFormPlugin.md)
- troubleshooting.md

## 关键词

- 中文关键词：当前用户、当前组织、登录组织、租户、上下文、会话上下文
- 英文关键词：`RequestContext`
- 常见报错词：上下文为空、用户为空、组织为空
