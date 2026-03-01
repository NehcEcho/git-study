# 第5节：远程仓库与 GitHub

## 📚 本节目标
- 理解远程仓库的概念
- 连接 GitHub 远程仓库
- 推送、拉取代码
- 克隆远程仓库

---

## 5.1 什么是远程仓库？

远程仓库是托管在服务器上的 Git 仓库，常见的有：

- **GitHub** - 最流行的代码托管平台
- **GitLab** - 企业常用，可自建
- **Gitee (码云)** - 国内平台，速度快
- **Bitbucket** - Atlassian 出品

### 本地与远程的关系

```
┌─────────────┐         push         ┌─────────────┐
│   本地仓库   │  ─────────────────>  │   远程仓库   │
│  (Local)    │                      │  (Remote)   │
│             │  <─────────────────  │             │
└─────────────┘         pull         └─────────────┘
```

---

## 5.2 创建 GitHub 仓库

### 步骤：

1. 访问 https://github.com
2. 登录你的账号（没有就注册一个）
3. 点击右上角 `+` → `New repository`
4. 填写信息：
   - Repository name: `my-git-project`
   - Description: `我的第一个 Git 项目`
   - 选择 `Public`（公开）或 `Private`（私有）
   - 不勾选初始化选项（我们有本地仓库了）
5. 点击 `Create repository`

---

## 5.3 连接远程仓库

### 查看远程仓库

```bash
# 查看已配置的远程仓库
git remote -v
```

### ✅ 预期输出（空）

```
# 没有任何输出，表示还没有配置远程仓库
```

### 添加远程仓库

```bash
# 添加远程仓库（将 URL 替换为你的仓库地址）
git remote add origin https://github.com/你的用户名/my-git-project.git
```

> 💡 `origin` 是远程仓库的默认别名，可以自定义

### 验证添加成功

```bash
git remote -v
```

### ✅ 预期输出

```
origin  https://github.com/你的用户名/my-git-project.git (fetch)
origin  https://github.com/你的用户名/my-git-project.git (push)
```

---

## 5.4 推送到远程仓库

### 首次推送

```bash
# 将 main 分支推送到远程仓库
git push -u origin main
```

> 💡 `-u` 参数是 `--set-upstream` 的简写，建立追踪关系

### ✅ 预期输出

```
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 8 threads
Compressing objects: 100% (10/10), done.
Writing objects: 100% (15/15), 1.25 KiB | 1.25 MiB/s, done.
Total 15 (delta 3), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (3/3), done.
To https://github.com/你的用户名/my-git-project.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```

### 后续推送

```bash
# 之后可以直接使用
git push
```

---

## 5.5 从远程拉取

### 场景1：其他人推送了更新

```bash
# 拉取远程更新并合并到当前分支
git pull

# 等同于
git fetch origin
git merge origin/main
```

### ✅ 预期输出

```
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0
Unpacking objects: 100% (3/3), 716 bytes | 102.00 KiB/s, done.
From https://github.com/你的用户名/my-git-project
   a1b2c3d..e4f5g6h  main       -> origin/main
Updating a1b2c3d..e4f5g6h
Fast-forward
 README.md | 1 +
 1 file changed, 1 insertion(+)
```

### 场景2：只查看更新，不合并

```bash
# 获取远程更新但不合并
git fetch

# 查看远程分支的状态
git log --oneline main..origin/main
```

---

## 5.6 克隆远程仓库

如果你想在另一台电脑上下载项目：

```bash
# 克隆远程仓库到本地
git clone https://github.com/你的用户名/my-git-project.git

# 克隆并指定文件夹名
git clone https://github.com/你的用户名/my-git-project.git my-project

# 克隆特定分支
git clone -b develop https://github.com/你的用户名/my-git-project.git
```

### ✅ 预期输出

```
Cloning into 'my-git-project'...
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (15/15), done.
remote: Compressing objects: 100% (10/10), done.
remote: Total 15 (delta 3), reused 15 (delta 3), pack-reused 0
Receiving objects: 100% (15/15), done.
Resolving deltas: 100% (3/3), done.
```

---

## 5.7 分支与远程

### 推送本地分支到远程

```bash
# 创建并切换到新分支
git checkout -b feature-api

# 做一些修改并提交...
echo "API code" > api.js
git add api.js
git commit -m "添加 API 功能"

# 推送新分支到远程
git push -u origin feature-api
```

### 查看远程分支

```bash
# 查看所有远程分支
git branch -r

# 查看所有分支（本地+远程）
git branch -a
```

### ✅ 预期输出

```
  origin/HEAD -> origin/main
  origin/feature-api
  origin/main
```

### 删除远程分支

```bash
# 删除远程分支
git push origin --delete feature-api

# 或者使用简写
git push origin :feature-api
```

---

## 5.8 常用工作流程

### 日常开发流程

```bash
# 1. 开始工作前，先拉取最新代码
git pull

# 2. 创建功能分支
git checkout -b feature-login

# 3. 开发功能，提交代码
# ... 编写代码 ...
git add .
git commit -m "实现登录功能"

# 4. 推送到远程
git push -u origin feature-login

# 5. 创建 Pull Request（在 GitHub 网站上操作）

# 6. 代码审查通过后，合并到 main

# 7. 删除本地和远程分支
git checkout main
git pull
git branch -d feature-login
git push origin --delete feature-login
```

---

## 5.9 SSH 免密登录（推荐）

每次输入密码很麻烦，可以配置 SSH 密钥：

### 生成 SSH 密钥

```bash
# 生成密钥对
ssh-keygen -t ed25519 -C "your.email@example.com"

# 按三次回车使用默认设置
```

### 复制公钥

```bash
# Windows
cat ~/.ssh/id_ed25519.pub | clip

# macOS
pbcopy < ~/.ssh/id_ed25519.pub

# Linux
xclip -sel clip < ~/.ssh/id_ed25519.pub
```

### 添加到 GitHub

1. 访问 GitHub → Settings → SSH and GPG keys
2. 点击 "New SSH key"
3. 粘贴公钥，保存

### 测试连接

```bash
ssh -T git@github.com
```

### ✅ 预期输出

```
Hi 用户名! You've successfully authenticated, but GitHub does not provide shell access.
```

### 使用 SSH 地址

```bash
# 修改远程地址为 SSH
git remote set-url origin git@github.com:你的用户名/my-git-project.git
```

---

## 5.10 常用命令速查表

| 命令 | 作用 |
|------|------|
| `git remote -v` | 查看远程仓库 |
| `git remote add <name> <url>` | 添加远程仓库 |
| `git push` | 推送到远程 |
| `git push -u origin <branch>` | 首次推送分支 |
| `git pull` | 拉取远程更新 |
| `git fetch` | 获取远程更新（不合并） |
| `git clone <url>` | 克隆远程仓库 |
| `git push origin --delete <branch>` | 删除远程分支 |

---

## 📝 课后练习

1. 注册 GitHub 账号，创建一个远程仓库
2. 将本地仓库推送到 GitHub
3. 在 GitHub 上编辑一个文件
4. 在本地拉取更新
5. 创建一个分支，推送到远程
6. 删除远程分支

---

## ➡️ 下一节预告

下一节我们将学习 **撤销操作与标签管理**！
