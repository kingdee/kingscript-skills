# 引出插件模板

## 适用场景

- 需要快速创建一个用于导出扩展的插件骨架
- 先搭好导出插件骨架，再补充导出前筛选、格式控制或数据整理逻辑

## 基类

- `AbstractListPlugin`

## 模板代码

```typescript
import { AbstractListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";

class MyPlugin extends AbstractListPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于引出或导出扩展场景
- 按需补充导出前处理方法
- 需要具体导出过程示例时，优先参考 `../examples/` 中的引出插件示例
