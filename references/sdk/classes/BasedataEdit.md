# BasedataEdit

## 基本信息

- 名称：`BasedataEdit`
- Java 类名：`kd.bos.form.field.BasedataEdit`
- TS 导出名：`BasedataEdit`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form`
- 命名空间：`kd.bos.form.field`
- 类型：基础资料/F7 控件对象
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-form-metadata.d.ts`
  - Javadoc：待补充

## 用途概述

用于处理基础资料字段、F7 选择、模糊搜索、资料回填等场景，是页面二开里最常见、最容易踩坑的控件对象之一。

## 典型场景

- 打开 F7 选择资料
- 给 F7 增加过滤条件
- 根据编码或主键回填资料
- 处理模糊搜索、快速新增、查看详情

## 用户常见问法

- F7 过滤条件怎么加
- 基础资料控件怎么按编码赋值
- 怎么拿 F7 选中的主键
- 怎么控制是否多选、是否只显示已审核

## 常见搭配

- `QFilter`
  - 作为搜索过滤条件对象
- `FormShowParameter`
  - 打开资料列表或详情页面时配合使用
- `AbstractFormPlugin`
  - 在表单插件里处理 F7 事件

## 高频方法

- `getSearchFilter()`
- `getQFilter()`
- `setQFilter(...)`
- `setQFilters(...)`
- `setItemByNumber(...)`
- `getPkIds()`
- `getPkId(...)`
- `addBeforeF7SelectListener(...)`
- `addAfterF7SelectListener(...)`
- `addBeforeF7ViewDetailListener(...)`
- `setShowOnlyAudited(...)`
- `setF7MultipleSelect(...)`

## 高价值规则

- `BasedataEdit` 的核心不是“能不能打开 F7”，而是“怎么安全控制过滤、回填和回调”
- 过滤条件优先通过 `QFilter` 组织，再交给控件或列表参数
- 赋值方式要区分“按编码回填”和“按主键回填”

## 运行时注意事项

- F7 相关问题通常同时涉及控件、过滤条件、回调事件和页面展示参数
- 多选、已审核、模糊搜索这些行为，不是所有资料控件默认都一致
- 只看控件声明往往不够，最好结合插件事件和示例一起判断

## 常见错误

### 1. F7 能打开，但过滤条件不生效

高概率原因：
- 过滤条件挂错位置
- `QFilter` 参数类型不对
- 事件时机不对，过滤条件被后续逻辑覆盖

### 2. 按编码赋值后没有回填预期结果

高概率原因：
- 编码值、主键值、显示值的层次没分清
- 忽略了控件当前行或当前实体上下文

## 相关文档

- [QFilter.md](QFilter.md)
- [FormShowParameter.md](FormShowParameter.md)
- [AbstractFormPlugin.md](AbstractFormPlugin.md)
- 4.4常见问题

## 关键词

- 中文关键词：F7、基础资料控件、资料选择、模糊搜索、资料回填
- 英文关键词：`BasedataEdit`
- 常见报错词：F7 过滤不生效、资料回填失败
