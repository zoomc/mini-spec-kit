---
description: Phase 1 - 创建模块规格说明
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>: <需求描述>`，例如 `news-page: 修复新闻标题英文未翻译问题`

## 执行

1. 读取 `.mini-spec-kit/project-constraints.md`（必须存在，不存在则停止）
2. 解析用户输入，提取模块名和需求描述
3. 如果模块目录 `.mini-spec-kit/modules/<模块名>/` 不存在，创建它
4. 读取 `.mini-spec-kit/project-constraints.md` 了解项目约束
5. 如果模块下已有 `spec.md`，读取并在现有基础上更新
6. 生成或更新 `.mini-spec-kit/modules/<模块名>/spec.md`：
   - 为每个需求分配 REQ-XXX ID（从 REQ-001 开始递增）
   - 新需求标记 `[NEW]`，修改的需求标记 `[CHANGED]`
   - 确保包含 `## Requirements` 章节
   - 每个需求必须是可测试的

## 完成后

运行 gate：`./scripts/minispec-gate.sh --phase specify --module <模块名> --project-root .`

输出摘要：模块名、spec 路径、需求数量

下一步：`/plan <模块名>`
