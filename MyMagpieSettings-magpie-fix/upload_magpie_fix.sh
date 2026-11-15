#!/usr/bin/env bash
# Add Magpie-importable Markdown subagents to existing MyMagpieSettings.
# Does not overwrite existing files; no force push, reset, or clean.
set -euo pipefail

REPO_URL="https://github.com/changshengyu/MyMagpieSettings.git"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

for cmd in git mktemp cp; do
  command -v "$cmd" >/dev/null || { echo "找不到命令: $cmd" >&2; exit 1; }
done

TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/magpie-subagents-fix.XXXXXX")"
REPO_DIR="$TEMP_ROOT/MyMagpieSettings"
printf '正在克隆仓库到：%s\n' "$REPO_DIR"
git clone "$REPO_URL" "$REPO_DIR"
cd "$REPO_DIR"

# Match the exact folder URL used in Magpie. Keep existing TOML untouched.
mkdir -p .codex/agents
for src in "$SCRIPT_DIR"/.codex/agents/or-*.md; do
  filename="$(basename "$src")"
  dest=".codex/agents/$filename"
  if [[ -e "$dest" ]]; then
    printf '为避免覆盖，已停止：%s 已存在。\n' "$dest" >&2
    printf '本地仓库副本：%s\n' "$REPO_DIR" >&2
    exit 1
  fi
  cp "$src" "$dest"
done

git add -- .codex/agents/or-*.md
git diff --cached --check
printf '\n以下 6 个 Markdown 子代理将添加到 GitHub：\n'
git diff --cached --stat
printf '\n不会删除或更改现有 TOML 文件。\n'
read -r -p "检查无误后输入 yes 才提交和推送： " reply
if [[ "$reply" != "yes" ]]; then
  printf '已取消。临时工作目录保留在：%s\n' "$REPO_DIR"
  exit 0
fi

git commit -m "Add Magpie-importable OpenReader subagents"
branch="$(git branch --show-current)"
if [[ -z "$branch" ]]; then
  echo '无法确定当前分支，未执行推送。' >&2
  exit 1
fi
git push origin "$branch"
printf '\n已推送。请在 Magpie 里搜索：\nhttps://github.com/changshengyu/MyMagpieSettings/tree/%s/.codex/agents\n' "$branch"
