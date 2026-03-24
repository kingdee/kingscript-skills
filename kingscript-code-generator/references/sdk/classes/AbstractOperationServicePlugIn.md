# AbstractOperationServicePlugIn

## 基本信息

- 名称：`AbstractOperationServicePlugIn`
- Java 类名：`kd.bos.entity.plugin.AbstractOperationServicePlugIn`
- TS 导出名：`AbstractOperationServicePlugIn`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity`
- 命名空间：`kd.bos.entity.plugin`
- 类型：操作服务插件基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/entity/plugin.d.ts`
  - 相关示例：[操作插件.md](../../examples/plugins/插件示例/操作插件.md)
  - Javadoc：待补充

## 用途概述

用于承载保存、提交、审核等操作服务侧的定制化逻辑，是批量处理、事务控制、校验扩展的高频基类。

## 典型场景

- 保存、提交、审核前后插入校验或补充逻辑
- 在事务内批量处理数据实体
- 根据操作结果写日志、返回消息或做补偿处理
- 给操作增加自定义校验器

## 用户常见问法

- 保存插件怎么写
- 审核前后怎么加逻辑
- 操作插件里怎么拿数据实体
- 怎么在事务前后扩展操作

## 常见搭配

- `getDataEntities()`
  - 获取当前参与操作的数据实体
- `getOperationContext()`
  - 获取当前操作上下文
- `getOperationResult()`
  - 获取当前操作结果

## 高价值规则

- 先区分逻辑应该放在事务前、事务内还是事务后
- 批量操作场景下，默认按“多单据、多实体”思考，不要只写单条逻辑
- 需要字段值时，优先在预加载阶段准备字段，避免后面拿不到数据
- 回滚补偿、后处理、返回结果属于不同阶段，不要混在一个钩子里

## 典型生命周期

- `onPreparePropertys`
- `onAddValidators`
- `beforeExecuteOperationTransaction`
- `beginOperationTransaction`
- `endOperationTransaction`
- `rollbackOperation`
- `afterExecuteOperationTransaction`
- `onReturnOperation`

## 运行时注意事项

- 这是操作服务侧插件，不是表单交互插件
- 它面向的是操作链路和数据实体批处理，不适合写页面交互逻辑
- 不同钩子位于不同事务阶段，放错位置容易导致结果异常或补偿失效

## 常见错误

### 1. 逻辑写了但执行时机不对

高概率原因：
- 把事务前逻辑放到了事务后
- 把只读校验写成了数据修改逻辑

### 2. 插件绑定了但没有达到预期结果

高概率原因：
- 对操作插件生命周期理解不完整
- 没有获取到需要的字段或数据实体

## 相关文档

- [操作插件.md](../../examples/plugins/插件示例/操作插件.md)
- 4.4.5单据无法选择已有插件.md
- troubleshooting.md

## 关键词

- 中文关键词：操作插件、保存插件、审核插件、事务插件
- 英文关键词：`AbstractOperationServicePlugIn`
- 常见报错词：事务阶段不对、操作结果异常、取不到数据实体
