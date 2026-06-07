---
description: Phase 6 - 验证并关闭清单
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 执行

1. 检查代码是否已被修改（`git diff --quiet` 返回非零）。如果代码未被修改，停止并提示先运行 `/implement`
2. 读取 `.mini-spec-kit/modules/<模块名>/checklist.md`
3. 运行每个 `- [ ]` 项的 `### Verification` 命令
4. 验证通过的项，将 `- [ ]` 改为 `- [x]`
5. 检查 spec.md 是否与实际代码一致，如有偏差则更新 spec.md
6. 更新 `.mini-spec-kit/modules/<模块名>/verify.log` 和 `gate-history.log`（如存在）
7. 更新 `.mini-spec-kit/modules/<模块名>/gate.md` 的 Final Result（如存在）
8. 创建或更新 `.mini-spec-kit/modules/<模块名>/changelog.md`：
   - 记录本次变更
   - 关联 REQ-XXX ID
   - 记录变更类型和影响

## 完成后

运行 gate：`./scripts/minispec-gate.sh --phase final --module <模块名> --project-root .`

输出摘要：模块名、通过的验证项数量、changelog 路径

任务完成，所有阶段已关闭。
