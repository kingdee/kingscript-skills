# SDK 废弃索引

用于回答"某个类/方法/写法是否已经废弃"以及"老版本写法迁移到当前 Cosmic V8.0.1 时应该看哪里"。

## 当前状态

仓库暂未沉淀成体系的废弃 API 清单，本文件先作为检索路由保留。

## 推荐检索顺序

1. 先看 [keyword-index.md](keyword-index.md) · [methods-hot.md](methods-hot.md) 或 `../classes/<ClassName>.md` 确认目标名称是否还存在。
2. 再看对应的 `../classes/<ClassName>.md` 知识卡，查看是否已标记替代入口。
3. 仍无结论时，回退到本地 `.d.ts` 声明和在线 Javadoc 核对 `@deprecated` 标记。

## 条目建议格式

补条目时建议包含：废弃对象、废弃原因、推荐替代方案、影响范围、版本信息。
