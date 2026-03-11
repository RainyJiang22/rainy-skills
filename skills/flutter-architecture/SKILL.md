---
name: flutter-architecture
description: |
  基于《Flutter 通用项目架构 — 标准需求提示词》的 Flutter 企业级架构技能。在以下场景使用：按分层与最新最优方案设计或实现 Flutter 项目、搭建/改造网络/存储/UI/状态/路由、做架构合规检查或生成架构图与目录示例。

  触发场景：
  - 用户要求按「flutter 架构」「企业级架构」「分层架构」设计或实现项目
  - 用户引用或提到 flutter-architecture-requirements、通用项目架构、标准需求提示词
  - 用户要求实现网络层、本地存储、UI 规范、状态管理、路由且需与规范一致
  - 用户要求对现有 Flutter 项目做架构合规检查或输出改造建议
  - 用户要求生成 Flutter 架构图、目录结构或各层示例代码

  不触发：与架构无关的单一 Bug 修复、纯 UI 样式调整、非 Flutter 项目。
---

# Flutter 企业级架构技能

本技能依据项目内的 **flutter-architecture-requirements** 规范（通常位于 `docs/ai-context/flutter-architecture-requirements.md`），在设计与实现 Flutter 项目时按分层与各层最新最优方案执行；需要细节时加载对应 reference。

## 工作流总览

1. **确定范围**：新建项目 / 现有项目改造 / 单模块实现 / 架构合规检查。
2. **分层与目录**：按「表现层 → 领域层（可选）→ 数据层 → 核心层」划分；目录与 [references/layering.md](references/layering.md) 一致。
3. **按需实现**：网络、存储、UI、状态、路由等按规范实现；细节见下方「何时读哪些 reference」。
4. **输出**：代码/目录/架构图/合规报告；若为合规检查，只输出建议与优先级，不直接改代码（除非用户明确要求）。

## 何时读哪些 reference

| 任务 | 读取 |
|------|------|
| 设计分层、目录结构、各层职责与禁止项 | [references/layering.md](references/layering.md) |
| UI 主题、页面结构、加载/空/错误态、响应式、无障碍、性能 | [references/ui.md](references/ui.md) |
| 网络层封装、高可用、安全、错误与可观测 | [references/network.md](references/network.md) |
| 本地存储抽象、KV/DB、迁移、安全 | [references/storage.md](references/storage.md) |
| 动画、状态管理、路由 | [references/state-routing-animation.md](references/state-routing-animation.md) |
| 工程规范、第三方库原则、可交付物 | [references/engineering.md](references/engineering.md) |

若项目根目录存在 `docs/ai-context/flutter-architecture-requirements.md`，可优先以该文档为权威来源；本技能 references 为其精简与拆分，便于按模块加载。

## 核心原则（必守）

- **依赖方向**：表现层 → 领域层 → 数据层 → 核心层；不反向、不跨层直调。
- **可测试**：核心逻辑可单测；网络/存储通过接口抽象，便于 Mock。
- **封装**：业务不直接依赖 Dio/Hive 等具体类型；依赖接口与 DTO/Entity。
- **生产可用**：UI 具备统一 Loading/Empty/Error、主题与无障碍；网络具备超时、重试、错误统一。

## 脚本

- **scripts/list_lib_modules.sh**：在项目根执行，列出 `lib/` 下一级目录（候选模块），便于规划 feature 或评审计划。用法：`bash scripts/list_lib_modules.sh` 或传入 `lib` 路径。

## 合规检查时

对现有项目做架构合规检查时：按「分层 → UI → 网络 → 存储 → 状态/路由 → 工程」顺序，逐项对照 references 与 requirements 文档，输出「不符合项 + 建议位置 + 最优解方案 + 优先级（P0/P1/P2）」，不自动修改代码除非用户明确要求。
