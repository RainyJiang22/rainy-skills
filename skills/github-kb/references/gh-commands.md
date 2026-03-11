# gh CLI 常用命令参考

需要查 issue、PR、仓库时按需查阅。

## 认证与状态

- `gh auth status` — 检查是否已登录
- `gh auth login` — 用户需在未登录时执行

## 仓库

- `gh repo view [owner/repo]` — 查看仓库信息
- `gh repo clone owner/repo [dir]` — 克隆（也可用 `git clone` 到本地 GitHub 目录）
- `gh search repos <query> [--limit N]` — 搜索仓库

## Issue

- `gh search issues <query> [--repo owner/repo] [--limit N]` — 搜索 issue
- `gh issue list --repo owner/repo [--state open|closed] [--limit N]` — 列出 issue
- `gh issue view <number> --repo owner/repo` — 查看单个 issue

## Pull Request

- `gh pr list --repo owner/repo [--state open|closed] [--limit N]` — 列出 PR
- `gh pr view <number> --repo owner/repo` — 查看单个 PR
- `gh search prs <query> [--limit N]` — 搜索 PR

## 其他

- `gh api <endpoint>` — 直接调用 GitHub API（高级）

搜索时建议加 `--limit 10` 或类似值，避免输出过长。
