---
description: Phase 2 - 创建技术实现计划
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 执行

1. 检查 `.mini-spec-kit/modules/<模块名>/spec.md` 存在且包含 `## Requirements`。如果不存在，停止并提示先运行 `/specify`
2. 读取 `.mini-spec-kit/modules/<模块名>/spec.md`
3. 读取 `.mini-spec-kit/project-constraints.md` 了解架构约束
4. 生成或更新 `.mini-spec-kit/modules/<模块名>/plan.md`：
   - `## Task List`：每个任务关联 REQ-XXX ID
   - `## Change Type`：Bug Fix / Requirement Change / Enhancement / Refactoring
   - 每个任务包含：文件路径、依赖关系、成功标准
   - 不允许在此阶段修改代码

## 完成后

运行 gate：`./scripts/minispec-gate.sh --phase plan --module <模块名> --project-root .`

输出摘要：模块名、plan 路径、任务数量

下一步：`/checklist <模块名>`
