---
description: Phase 5 - 实现代码
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 前置 Gate

运行 `./scripts/minispec-gate.sh --phase before-implement --module <模块名> --project-root .`

如果 gate 失败，停止并提示先完成前序阶段。

## 执行

1. 读取 `.mini-spec-kit/modules/<模块名>/plan.md` 的 Task List
2. 按 Task List 顺序执行代码修改
3. 每完成一个任务，运行对应的 build/test 验证
4. 不允许勾选 checklist（这些在 Reconcile 阶段处理）

## 完成后

运行 gate：`./scripts/minispec-gate.sh --phase after-implement --module <模块名> --project-root .`

输出摘要：模块名、修改的文件列表、build/test 结果

下一步：`/reconcile <模块名>`
