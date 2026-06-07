---
description: Phase 4 - 一致性检查（只读）
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 执行（不修改代码；只更新分析报告）

1. 检查 spec.md、plan.md、checklist.md 都存在。如果任何文件缺失，停止并提示先运行前序命令
2. 读取三份文件
3. 检查一致性：
   - 每个 REQ-XXX 在 spec.md 中有定义
   - 每个 REQ-XXX 在 plan.md 的 Task List 中有对应任务
   - 每个任务在 checklist.md 中有对应的验证项
   - 无术语漂移（同一概念在三份文件中名称一致）
4. 在 plan.md 末尾追加 `## Analysis Report` 章节：
   - 需求覆盖情况
   - 任务覆盖情况
   - 发现的问题（如果有）
   - 结论：PASS 或 FAIL（附 CRITICAL 问题列表）

## 完成后

运行 gate：`./scripts/minispec-gate.sh --phase analyze --module <模块名> --project-root .`

输出摘要：模块名、分析结论（PASS/FAIL）、问题数量

- 如果 PASS：下一步 `/implement <模块名>`
- 如果 FAIL：列出 CRITICAL 问题，修复后重新运行 `/analyze`
