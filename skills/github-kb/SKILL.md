---
name: github-kb
description: "GitHub 知识库技能。当用户提到 github、repo、仓库时触发。在本地 GitHub 目录查找并分析仓库；优先使用 gh CLI 搜索 issue/PR/repository，若 gh 不可用或未登录则用 curl 调用 GitHub API 代替；支持「下载一个 repo」时用 git 克隆到本地目录并更新 CLAUDE.md。"
---

# GitHub 知识库 (github-kb)

## 本地 GitHub 目录

**默认路径**：`/Users/rainyjiang/github`

- 若该目录**不存在**：询问用户正确的本地 GitHub 根目录路径，得到后在本 SKILL.md 的「本地 GitHub 目录」小节中更新为 `GITHUB_LOCAL_ROOT: <用户提供的路径>`，并据此执行后续操作。
- 所有「下载 repo」的克隆目标为此目录；`CLAUDE.md` 放在此目录根下，用于记录已克隆仓库列表与简要说明。

## 工作流

### 1. 用户说「下载一个 repo」或类似

1. 确认目标仓库（owner/name 或 URL）。
2. 在本地 GitHub 目录执行：`git clone <repo_url>`（若目录不存在则先按上文询问并更新 SKILL.md，再创建目录并克隆）。
3. 克隆完成后，更新本地 GitHub 目录根下的 `CLAUDE.md`：
   - 若文件不存在则创建，包含：本目录用途、当前已克隆仓库列表（名称、路径、克隆时间或简要说明）。
   - 若已存在，在「已克隆仓库」中追加新仓库条目。

### 2. 回答与 GitHub/仓库相关的问题

1. **优先本地**：若用户提到的仓库名/owner 能在本地 GitHub 目录下找到对应目录（且为 git 仓库），则优先基于本地文件分析（读 README、关键代码、目录结构等）回答问题。
2. **网络查询（gh 或 curl）**：需要最新动态、issue、PR、或本地没有该仓库时：
   - **优先使用 gh CLI**：检测 `gh` 命令是否可用且已登录
   - **降级使用 curl + GitHub API**：若 `gh` 不可用或未登录，使用 `curl` 调用 GitHub REST API
3. 回答时结合本地分析结果与查询结果，给出准确、可操作的结论。

## 网络查询流程

### 检测 gh 可用性

在执行网络查询前，按以下步骤检测：

```bash
# 检测 gh 命令是否存在
command -v gh >/dev/null 2>&1

# 若存在，检查登录状态
gh auth status
```

- 若 `gh` 存在且已登录 → 使用 `gh` 命令（见「gh 命令参考」）
- 若 `gh` 不存在 或 未登录 → 使用 curl + GitHub API（见「GitHub API 参考」）

### gh 命令参考（优先）

- 搜索仓库：`gh search repos <query> [--limit N]`
- 搜索 issue：`gh search issues <query> [--repo owner/repo] [--limit N]`
- 搜索 PR：`gh search prs <query> [--limit N]`
- 列出 issue：`gh issue list --repo owner/repo [--state open|closed] [--limit N]`
- 列出 PR：`gh pr list --repo owner/repo [--state open|closed] [--limit N]`
- 仓库信息：`gh repo view owner/repo`
- 单个 issue：`gh issue view <number> --repo owner/repo`
- 单个 PR：`gh pr view <number> --repo owner/repo`

### GitHub API 参考（降级方案）

GitHub REST API 基础 URL：`https://api.github.com`

无需认证的公开 API 调用示例：

#### 搜索仓库
```bash
curl -s "https://api.github.com/search/repositories?q=<query>&per_page=10"
```

#### 搜索 issue
```bash
# 全局搜索
curl -s "https://api.github.com/search/issues?q=<query>&per_page=10"

# 指定仓库搜索
curl -s "https://api.github.com/search/issues?q=repo:<owner>/<repo>+<query>&per_page=10"
```

#### 搜索 PR
```bash
curl -s "https://api.github.com/search/issues?q=repo:<owner>/<repo>+type:pr+<query>&per_page=10"
```

#### 获取仓库信息
```bash
curl -s "https://api.github.com/repos/<owner>/<repo>"
```

#### 列出仓库的 issue
```bash
# 开放状态
curl -s "https://api.github.com/repos/<owner>/<repo>/issues?state=open&per_page=10"

# 已关闭状态
curl -s "https://api.github.com/repos/<owner>/<repo>/issues?state=closed&per_page=10"
```

#### 列出仓库的 PR
```bash
curl -s "https://api.github.com/repos/<owner>/<repo>/pulls?state=open&per_page=10"
```

#### 获取单个 issue
```bash
curl -s "https://api.github.com/repos/<owner>/<repo>/issues/<number>"
```

#### 获取单个 PR
```bash
curl -s "https://api.github.com/repos/<owner>/<repo>/pulls/<number>"
```

#### API 响应美化（可选）
```bash
curl -s "https://api.github.com/search/repositories?q=<query>" | jq '.'
# 或使用 Python
curl -s "https://api.github.com/search/repositories?q=<query>" | python3 -m json.tool
```

### API 限制说明

- 无认证请求：每小时 60 次
- 若请求频繁，可提示用户提供 GitHub Personal Access Token 并使用 `-H "Authorization: token <TOKEN>"`

## 使用约定

- 搜索时尽量控制返回条数（`--limit N` 或 `per_page=N`），避免输出过长
- 引用 issue/PR 时优先给出链接，便于用户跳转
- 使用 curl 时 API 响应为 JSON，需解析后以易读格式呈现给用户
- **gh 速查**：见 [references/gh-commands.md](references/gh-commands.md)
- **GitHub API 文档**：https://docs.github.com/en/rest

## CLAUDE.md 格式建议

位于本地 GitHub 目录根下，建议结构：

```markdown
# 本地 GitHub 知识库

本目录用于存放克隆的 GitHub 仓库，供 github-kb 技能本地分析与检索。

## 已克隆仓库

| 仓库 | 本地路径 | 说明/克隆时间 |
|------|----------|----------------|
| owner/repo-name | ./repo-name | 简要说明 |
```

每次新克隆后追加一行到上表（或等效列表）。
