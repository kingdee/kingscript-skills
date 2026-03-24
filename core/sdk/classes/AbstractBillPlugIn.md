# AbstractBillPlugIn

## 基本信息

- 名称：`AbstractBillPlugIn`
- Java 类名：`kd.bos.bill.AbstractBillPlugIn`
- TS 导出名：`AbstractBillPlugIn`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.bill`
- 类型：单据插件基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/bill.d.ts`
  - 相关示例：[4.3.2.12单据插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.12%E5%8D%95%E6%8D%AE%E6%8F%92%E4%BB%B6.md)
  - 相关案例：[2.2.2.1单据插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.2%E5%8D%95%E6%8D%AE%E6%8F%92%E4%BB%B6/2.2.2.1%E5%8D%95%E6%8D%AE%E6%8F%92%E4%BB%B6.md)
  - Javadoc：待补充

## 用途概述

用于单据页面的交互、联动、校验和界面控制，是 Kingscript 二开里最核心的高频基类之一。

## 典型场景

- 字段值变化联动计算
- 单据加载后补数据或控制界面
- 新增分录前后校验与默认值填充
- 按钮或页面事件处理

## 用户常见问法

- 单据插件应该继承哪个基类
- 字段联动应该写在哪个事件
- 分录行新增前后怎么处理
- 单据打开后怎么做界面控制

## 常见搭配

- `this.getModel()`
  - 读取和设置单据数据
- `this.getView()`
  - 处理界面提示和控件状态
- `PropertyChangedArgs`
  - 常见于字段变更事件
- `QueryServiceHelper`
  - 查询外部数据做联动

## 高价值规则

- 单据场景优先使用 `AbstractBillPlugIn`，不要误用 `AbstractFormPlugin`
- 字段联动优先放 `propertyChanged`
- 初始化阶段和交互阶段要区分，如 `initPropertyChanged` 与 `propertyChanged`
- 插件类不要定义类属性，变量优先在方法内部定义
- 调用父类方法是高频刚性约束

## 高频事件

- `beforePropertyChanged`
- `propertyChanged`
- `initPropertyChanged`
- `beforeAddRow`
- `afterAddRow`
- `afterLoadData`

## 运行时注意事项

- 单据插件更偏业务单据交互，不是通用动态表单的全部能力集合
- 在事件中修改模型值要考虑是否引起再次触发，避免联动死循环
- 某些事件在新增、编辑、下推、引入等不同场景下触发时机不同

## 常见错误

### 1. 单据场景选不到脚本插件

高概率原因：
- 基类写成了 `AbstractFormPlugin`

### 2. 联动逻辑异常或反复触发

高概率原因：
- 事件选择不当
- 在字段联动里形成循环赋值

## 相关文档

- [4.3.2.12单据插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.12%E5%8D%95%E6%8D%AE%E6%8F%92%E4%BB%B6.md)
- [2.2.2.1单据插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.2%E5%8D%95%E6%8D%AE%E6%8F%92%E4%BB%B6/2.2.2.1%E5%8D%95%E6%8D%AE%E6%8F%92%E4%BB%B6.md)
- [4.4.5单据无法选择已有插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/common-issues/4.4%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98/4.4.5%E5%8D%95%E6%8D%AE%E6%97%A0%E6%B3%95%E9%80%89%E6%8B%A9%E5%B7%B2%E6%9C%89%E6%8F%92%E4%BB%B6.md)
- [troubleshooting.md](/E:/kingscript%20skills/kingscript-skill/core/docs/troubleshooting.md)

## 关键词

- 中文关键词：单据插件、单据联动、字段变更、分录处理
- 英文关键词：`AbstractBillPlugIn`
- 常见报错词：单据选不到插件、联动死循环、事件不触发
