# SerializationUtils

## 基本信息

- 名称：`SerializationUtils`
- Java 类名：`kd.bos.dataentity.serialization.SerializationUtils`
- TS 导出名：`SerializationUtils`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/dataentity`
- 命名空间：`kd.bos.dataentity.serialization`
- 类型：序列化与反序列化工具类
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-dataentity.d.ts`
  - Javadoc：待补充

## 用途概述

用于处理 Java 运行时对象、动态对象和结构化数据在脚本中的序列化、反序列化或传输转换问题，是“对象怎么过桥、怎么落地”的重要工具类。

## 典型场景

- 动态对象转字符串或结构化结果
- 字符串恢复成运行时对象
- 接口入参、回调参数、缓存值的格式转换
- 排查“声明看起来正常、序列化后运行时报错”的问题

## 用户常见问法

- 对象怎么转 JSON
- 字符串怎么还原成对象
- 为什么序列化后类型不对
- 为什么序列化前能用、序列化后方法没了

## 常见搭配

- `RequestContext`
  - 上下文对象传递或日志排查
- `BusinessDataServiceHelper`
  - 查询结果转成可展示或可传递的数据
- `Date`
  - 日期字段序列化时经常需要注意类型变化

## 高价值规则

- 先区分“为了传输而序列化”还是“为了展示而转字符串”
- 序列化前后的对象语义可能一致，但运行时类型未必一致
- 只要问题涉及日期、大整数、动态对象集合，就要提高对序列化边界的警惕

## 运行时注意事项

- 序列化后的结果是否还能保留原对象方法，不能想当然
- 如果序列化后再传回插件逻辑，优先先检查字段结构和运行时类型
- 只靠 TS 声明无法完全解释序列化后的运行时表现

## 常见错误

### 1. 序列化之后把结果继续当原 Java 对象使用

高概率原因：
- 把“值相同”误认为“类型也没变”
- 忽略了桥接后对象能力已经丢失

## 相关文档

- [RequestContext.md](RequestContext.md)
- troubleshooting.md
- 4.4常见问题

## 关键词

- 中文关键词：序列化、反序列化、对象转字符串、JSON 转换
- 英文关键词：`SerializationUtils`
- 常见报错词：序列化失败、反序列化失败、类型丢失
