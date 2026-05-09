# mini-spec-kit

[🇺🇸 English](README.md) | [🇨🇳 中文](README.zh-CN.md)

<div align="center">

![mini-spec-kit banner](https://img.shields.io/badge/AI%20规范驱动-更快交付%20更少返工-111827?style=for-the-badge)
![许可证](https://img.shields.io/github/license/zoomc/mini-spec-kit?style=for-the-badge)
![Star](https://img.shields.io/github/stars/zoomc/mini-spec-kit?style=for-the-badge)
![流程](https://img.shields.io/badge/工作流-6%20阶段-2563eb?style=for-the-badge)

### **别再“玄学写码”，开始“可证明交付”。**

</div>

**面向 AI 编码代理的规范驱动开发 —— 轻量、可溯源、省 token。**

`mini-spec-kit` 是一个极简 Spec-Driven Development（规范驱动开发）框架，专为使用 AI 编码代理的个人开发者和小团队设计。它用清晰的 6 阶段流程，帮你在保持速度的同时，避免代码变得脆弱、难追溯、难维护。

## About

> **像专业团队一样使用 AI：先锁需求，再控执行，最后可验证地交付。**

建议 GitHub About 文案：

> **AI 规范驱动工作流：更快交付，更少返工。**

## 为什么选择 mini-spec-kit？

AI 代理能力很强，但没有流程时经常会：

- 在真正理解需求前就开始写代码
- 引入回归问题，导致高成本返工
- 跨会话丢失上下文
- 生成难审计、难接手的改动

**mini-spec-kit 把混乱变成推进力**：

| 优势 | 如何实现 |
|------|----------|
| **稳定性** | 编码前冻结需求 |
| **可溯源** | 每次改动都可追到需求 ID |
| **省 token** | 只注入必要上下文 |
| **可移植** | 兼容 Claude、GPT、Copilot、Cursor 等 |
| **够简单** | 6 个阶段、门禁清晰、几乎零配置 |

## 流程图（可视化）

```mermaid
flowchart LR
    S[规格说明] --> P[规划]
    P --> C[检查清单]
    C --> A[分析]
    A --> I[实现]
    I --> R[对账]
    R -->|门禁通过| D[完成 ✅]
```

```text
规格说明 → 规划 → 检查清单 → 分析 → 实现 → 对账
```

任何会产生 `git diff` 的任务，都必须经过六个阶段。小任务可以写短文档，但**不能跳过纪律**。

## 防跳过门禁

通过物理文件检查避免“跳阶段”：

```text
spec.md 有 ## Requirements? → 进入 Plan
plan.md 有 ## Task List? → 进入 Checklist
checklist.md 存在且有验证项? → 进入 Analyze
Analyze 通过 + checklist 仅有 [ ] + gate 允许实现? → 进入 Implement
构建/测试通过 + 存在 git diff? → 进入 Reconcile
全部 [x]、spec 与代码一致、日志更新、final gate 通过? → 完成
```

优先使用强门禁脚本：

```bash
./scripts/minispec-gate.sh --phase before-implement --module <模块名> --project-root .
./scripts/minispec-gate.sh --phase final --module <模块名> --project-root .
```

**“完成”的定义是 final gate 通过**，而不是单纯存在 `spec.md` / `plan.md` / `checklist.md`。

兼容检查脚本仍可用：

```bash
./scripts/check-phase-prereqs.sh --phase 5 --module <模块名> --project-root .
```

两个脚本都会检查 `.mini-spec-kit/modules/<模块名>`。

## Gate 相关文件

- `gate.md`：流程状态与实现许可
- `checklist.md`：业务验证清单
- `verify.log`：验证命令结果
- `gate-history.log`：门禁流转记录

## 快速开始

```bash
git clone https://github.com/zoomc/mini-spec-kit.git
cd mini-spec-kit
./scripts/init-mini-speckit.sh /path/to/your/project
```

该命令会把 `.mini-spec-kit/`、`.github/copilot-instructions.md`、`.claude/commands/`、`.agents/skills/`、`AGENTS.md`、`CLAUDE.md` 以及 `scripts/` 门禁脚本复制到你的项目中。

## 适合谁？

- **AI 单兵开发者**：减少返工，持续稳定输出
- **小团队**：不引入重流程，也能有可追责交付链路
- **AI 代理**：在明确约束下表现更稳定

## 与官方 Spec Kit 对比

| | mini-spec-kit | 官方 Spec Kit |
|-|---------------|---------------|
| **上手成本** | 复制一个目录 | 完整 CLI + 模板 |
| **学习曲线** | 约 5 分钟 | 数小时 |
| **Token 开销** | 最小 | 更高 |
| **更适合** | 个人 / 小团队 | 企业 / 大团队 |

## 许可证

MIT
