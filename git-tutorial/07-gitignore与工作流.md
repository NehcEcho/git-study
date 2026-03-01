# 第7节：.gitignore 与 Git 工作流

## 📚 本节目标
- 掌握 .gitignore 的使用
- 理解 Git 工作流
- 学习团队协作规范

---

## 7.1 什么是 .gitignore？

`.gitignore` 文件告诉 Git 哪些文件不应该被跟踪：

- 🗂️ 临时文件（.tmp, .log）
- 🔐 敏感信息（密码、密钥）
- 📦 依赖目录（node_modules/）
- 🏗️ 编译输出（dist/, build/）
- ⚙️ IDE 配置（.idea/, .vscode/）

---

## 7.2 创建 .gitignore

### 基本用法

```bash
# 创建 .gitignore 文件
touch .gitignore

# 编辑文件
notepad .gitignore  # Windows
# code .gitignore   # VS Code
```

### 示例 .gitignore 文件

```gitignore
# 忽略所有 .log 文件
*.log

# 忽略 node_modules 目录
node_modules/

# 忽略编译输出
dist/
build/

# 忽略环境变量文件（包含敏感信息）
.env
.env.local

# 忽略 IDE 配置
.idea/
.vscode/
*.swp
*.swo
*~

# 忽略操作系统文件
.DS_Store
Thumbs.db

# 忽略依赖锁文件（可选）
package-lock.json
yarn.lock
```

---

## 7.3 .gitignore 语法详解

### 基本规则

```gitignore
# 1. 以 # 开头的是注释
# 这是注释

# 2. 以 / 开头表示从项目根目录开始匹配
/build          # 只忽略根目录的 build 文件夹
build           # 忽略所有 build 文件夹

# 3. 以 / 结尾表示只匹配目录
temp/           # 只忽略 temp 目录，不忽略 temp 文件

# 4. 使用 * 通配符
*.txt           # 忽略所有 .txt 文件
doc/*.txt       # 忽略 doc 目录下的 .txt 文件

# 5. 使用 ** 匹配任意层目录
**/*.log        # 忽略所有目录下的 .log 文件
node_modules/**/package.json  # 忽略所有 node_modules 子目录下的 package.json
```

### 取反规则（!）

```gitignore
# 忽略所有 .txt 文件
*.txt

# 但不忽略 important.txt
!important.txt

# 忽略 build 目录
build/

# 但不忽略 build/assets
!build/assets/
```

### 示例详解

```gitignore
# ========== 操作系统 ==========
.DS_Store       # macOS
Thumbs.db       # Windows
*.stackdump     # Windows

# ========== 编辑器 ==========
.vscode/
.idea/
*.sublime-*

# ========== 依赖目录 ==========
node_modules/
vendor/
__pycache__/
*.pyc

# ========== 编译输出 ==========
dist/
build/
out/
*.exe
*.dll

# ========== 日志文件 ==========
*.log
logs/
npm-debug.log*

# ========== 测试覆盖报告 ==========
coverage/
.nyc_output/

# ========== 环境变量 ==========
.env
.env.*
!.env.example   # 保留示例文件

# ========== 临时文件 ==========
tmp/
temp/
*.tmp
*.cache
```

---

## 7.4 验证 .gitignore

### 检查文件是否被忽略

```bash
# 检查某个文件是否被忽略
git check-ignore -v debug.log
```

### ✅ 预期输出

```
.gitignore:5:*.log    debug.log
```

> 表示 `debug.log` 被 `.gitignore` 第 5 行的规则忽略

### 查看被忽略的文件

```bash
# 查看所有被忽略的文件
git status --ignored
```

---

## 7.5 已经跟踪的文件如何忽略

如果文件已经被 Git 跟踪，直接添加到 .gitignore 不会生效：

```bash
# 1. 先从 Git 中移除（但保留本地文件）
git rm --cached debug.log

# 2. 添加到 .gitignore
echo "debug.log" >> .gitignore

# 3. 提交更改
git add .gitignore
git commit -m "添加 .gitignore，停止跟踪 debug.log"
```

---

## 7.6 常用 .gitignore 模板

GitHub 提供了各种项目的 .gitignore 模板：

- **Python**: https://github.com/github/gitignore/blob/main/Python.gitignore
- **Node**: https://github.com/github/gitignore/blob/main/Node.gitignore
- **Java**: https://github.com/github/gitignore/blob/main/Java.gitignore
- **Go**: https://github.com/github/gitignore/blob/main/Go.gitignore

### Python 项目 .gitignore

```gitignore
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# Environments
.env
.venv
env/
venv/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo
```

### Node.js 项目 .gitignore

```gitignore
# Dependencies
node_modules/

# Build
dist/
build/

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/

# Environment variables
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db
```

---

## 7.7 Git 工作流

### 集中式工作流

最简单的模式，所有人直接向 main 分支推送：

```
开发者A:  main  A → B → C
                ↑
开发者B:        └──── D
```

适合：小团队、简单项目

### 功能分支工作流

每个功能都在独立分支开发：

```
main:    A ─────────────────────────────────── H
          ↑                                     ↑
feature1: └─ B ── C ── D ─┘                   │
                          │                   │
feature2:                 └─ E ── F ── G ─────┘
```

适合：中小团队、需要代码审查

### Git Flow 工作流

经典的分支模型：

```
main:       A ─────────────────────────────────────
            ↑                                     ↑
develop:    └──────── B ─── C ─── D ─── E ─── F ─┘
                        ↑           ↑
feature/login:          └── X ── Y ─┘
                        ↑
feature/payment:        └── M ── N ── O
```

分支说明：
- `main`: 稳定版本
- `develop`: 开发分支
- `feature/*`: 功能分支
- `release/*`: 发布分支
- `hotfix/*`: 紧急修复

适合：大型项目、版本发布

---

## 7.8 团队协作规范

### 提交信息规范

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type 类型：**
- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式（不影响代码运行）
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

**示例：**

```
feat(login): 添加用户登录功能

实现基于 JWT 的用户认证，包括：
- 登录表单验证
- Token 生成与验证
- 登录状态持久化

Closes #123
```

### 分支命名规范

```
feature/user-login      # 新功能
bugfix/login-error      # Bug 修复
hotfix/security-patch   # 紧急修复
release/v1.2.0          # 版本发布
docs/api-reference      # 文档更新
```

### 工作流程示例

```bash
# 1. 同步主分支
git checkout main
git pull origin main

# 2. 创建功能分支
git checkout -b feature/user-profile

# 3. 开发并提交（多次小提交）
git add .
git commit -m "feat(profile): 添加用户资料页面"

git add .
git commit -m "feat(profile): 实现头像上传功能"

# 4. 同步主分支（解决冲突）
git checkout main
git pull origin main
git checkout feature/user-profile
git rebase main

# 5. 推送到远程
git push -u origin feature/user-profile

# 6. 创建 Pull Request（代码审查）
# ... 在 GitHub/GitLab 上操作 ...

# 7. 合并后清理
git checkout main
git pull origin main
git branch -d feature/user-profile
```

---

## 7.9 常用命令速查表

| 命令 | 作用 |
|------|------|
| `git check-ignore -v <file>` | 检查文件是否被忽略 |
| `git status --ignored` | 显示被忽略的文件 |
| `git rm --cached <file>` | 停止跟踪文件但保留本地 |

---

## 📝 课后练习

1. 创建一个 Python 项目的 .gitignore
2. 创建一个文件并提交，然后将其添加到 .gitignore 并停止跟踪
3. 按照 Git Flow 创建一个功能分支，完成开发后合并
4. 按照提交信息规范写 3 个提交

---

## ➡️ 下一节预告

下一节我们将学习 **Git 高级技巧**！
