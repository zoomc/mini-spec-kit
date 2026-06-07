---
description: Phase 3 - 创建验证清单
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 执行

1. 检查 `.mini-spec-kit/modules/<模块名>/plan.md` 存在且包含 `## Task List`。如果不存在，停止并提示先运行 `/plan`
2. 读取 `.mini-spec-kit/modules/<模块名>/plan.md`
3. 生成或更新 `.mini-spec-kit/modules/<模块名>/checklist.md`：
   - 按 REQ-XXX 分组
   - 每项以 `- [ ]` 开头（全部未勾选）
   - 每项包含：
     - `### Implementation`：具体实现步骤
     - `### Verification`：验证命令（可执行的 shell 命令）
   - 不允许在此阶段修改代码

## 完成后

运行 gate：`./scripts/minispec-gate.sh --phase checklist --module <模块名> --project-root .`

输出摘要：模块名、checklist 路径、验证项数量

下一步：`/analyze <模块名>`
