# Magpie 子代理导入格式修复

本包为现有 `changshengyu/MyMagpieSettings` 仓库的 `.codex/agents/` **新增**六个 Markdown 定义文件，以修复 Magpie 报错：

> no subagents there: a subagent is a Markdown file whose front matter has its name and description

## 为什么有 .toml 仍不行？

- Magpie 的「添加子代理」导入器搜索带 YAML front matter (`name`, `description`) 的 Markdown 文件。
- Magpie 内部导入完成后，可将这些子代理转换为 Codex 使用的 TOML 角色文件。已有的 `.toml` 不是给这个导入器使用的。

## 上传

1. 解压本 ZIP 包到 Mac 下载目录。
2. 运行 `bash ~/Downloads/MyMagpieSettings-magpie-fix/upload_magpie_fix.sh`。
3. 查看脚本显示的文件清单，确认后输入 `yes`。
4. 在 Magpie「资源库 → 子代理」输入：
   `https://github.com/changshengyu/MyMagpieSettings/tree/main/.codex/agents`
   若脚本最终显示的分支不是 `main`，使用脚本输出的 URL。
5. 勾选需要的子代理，并给 Codex 开启。回到 Magpie 的「Agent」页面，将统一子代理模型保留为 `Lead's pick`，然后为每个子代理选具体模型。

**注意**：该脚本不会覆盖任何同名 `.md`、已有 TOML 或现有仓库文件。需要本机 GitHub 推送权限。添加 Markdown 到 GitHub 不会自动激活 Codex 子代理，仍需 Magpie 导入/同步。

## 文件

- `or-planner.md`  任务拆解（只读）
- `or-explorer.md`  仓库探索（只读）
- `or-developer.md` 功能开发
- `or-tester.md` QA / 回归测试
- `or-reviewer.md` 独立审查（只读）
- `or-security.md` 安全审查（只读）

“只读”描述是指令约束，不是底层文件系统权限沙箱。敏感任务仍需按 Codex 授权策略限制工具操作。
