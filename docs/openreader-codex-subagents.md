# OpenReader 的 Codex 子代理配置

本目录提供六个 OpenReader 专用的 Codex 子代理角色：

| 文件 | 作用 |
| --- | --- |
| `.codex/agents/or-planner.toml` | 架构规划与任务拆解，只读 |
| `.codex/agents/or-explorer.toml` | 代码探索、依赖和入口定位，只读 |
| `.codex/agents/or-developer.toml` | 有边界的功能开发与修复 |
| `.codex/agents/or-tester.toml` | 测试、回归及验收 |
| `.codex/agents/or-reviewer.toml` | 独立代码审查，只读 |
| `.codex/agents/or-security.toml` | 安全、隐私及权限审查，只读 |

这些 TOML 文件不包含具体模型 ID。请在 Magpie 中选择自己实际可用的模型，或按 Codex 当前支持的方式配置模型。不要在 GitHub 上传 API key、`.env`、Token、个人配置备份及项目私有文档。

## 导入方式

1. 在 Magpie 的 **资源库 → 子代理 → 添加子代理** 中填入本仓库 URL，检查预览是否能识别 `or-*` 角色。Magpie 的仓库扫描行为可能因版本而异，未实际在用户的 Magpie 安装上测试。
2. 勾选目标 Agent **Codex**，设置每个角色的模型。若 Magpie Agent 页面强制统一子代理模型，可能会覆盖单独的角色模型。
3. 如果 Magpie 的仓库导入没有识别 TOML，可将 `.codex/agents/or-*.toml` 复制进你的 OpenReader 项目目录 `/Users/yuchangsheng/Documents/OpenReader-dev/.codex/agents/`，注意不要覆盖同名文件，或直接在 Magpie 中按文件内容创建角色。
4. 不要同时让 Magpie 的全局同步和项目手动配置在同名角色上互相覆盖。

角色提示词内的只读约束只是行为指导，不是系统权限隔离。多个可写 Agent 并行时仍应使用 Git Worktree 和文件所有权约束。

参考： https://usemagpie.ai/docs/library
