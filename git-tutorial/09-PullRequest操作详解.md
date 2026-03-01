# 第9节：Pull Request 操作详解

## 📚 本节目标
- 理解什么是 Pull Request (PR)
- 掌握完整的 PR 工作流程
- 学会代码审查（Code Review）
- 了解 PR 最佳实践

---

## 9.1 什么是 Pull Request？

**Pull Request（合并请求）** 是团队协作开发的核心机制。它允许开发者：

- 📝 告诉团队："我的代码完成了，请 review 一下"
- 👀 团队成员可以查看、评论、建议修改
- ✅ 代码审查通过后，合并到主分支
- 📊 保留完整的代码审查历史

```
┌──────────────────────────────────────────────────────────────┐
│                      Pull Request 流程                        │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   开发者A                        代码审查者      仓库维护者   │
│      │                               │               │       │
│      │  1. 创建功能分支              │               │       │
│      ▼                               │               │       │
│   feature/login ◄────────────────────┼───────────────┤       │
│      │                               │               │       │
│      │  2. 推送代码                  │               │       │
│      ▼                               │               │       │
│   GitHub ──► 3. 创建 PR             │               │       │
│      │                               │               │       │
│      └─────────────► 4. Code Review │               │       │
│                          │           │               │       │
│                          ▼           │               │       │
│                   5. 评论/建议修改 ──┘               │       │
│                          │                           │       │
│                          ▼ (修改完成)                │       │
│                   6. 批准(Approve)                   │       │
│                          │                           │       │
│                          ▼                           │       │
│                   7. 合并(Merge) ◄───────────────────┘       │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 9.2 为什么要用 PR？

### 没有 PR 的问题

```
❌ 开发者A直接push到main
   main: A ── B ── C(有bug!) ── D
                
❌ 开发者B也直接push，代码冲突
   main: A ── B ── C ── E(冲突!) ── F
```

### 使用 PR 的好处

| 好处 | 说明 |
|------|------|
| **代码审查** | 别人帮你检查代码，发现潜在问题 |
| **知识共享** | 团队成员了解彼此的工作 |
| **质量保证** | 确保代码符合团队规范 |
| **历史记录** | 保留完整的讨论和决策过程 |
| **防止冲突** | 在合并前解决冲突 |
| **自动化检查** | 集成 CI/CD 自动测试 |

---

## 9.3 准备工作

### 场景设置

假设你在一个团队中开发一个网站项目：

```
项目: website
仓库: https://github.com/company/website
你的身份: 开发者
任务: 开发用户登录功能
```

### Fork 仓库（如果是外部贡献者）

如果你是外部贡献者，需要先 Fork 仓库：

```
公司仓库: company/website ──► 你的仓库: yourname/website
                     Fork
```

操作步骤：
1. 访问 `https://github.com/company/website`
2. 点击右上角 **Fork** 按钮
3. 等待 Fork 完成

### Clone 仓库

```bash
# 如果是团队成员（直接clone）
git clone https://github.com/company/website.git
cd website

# 如果是外部贡献者（clone自己的fork）
git clone https://github.com/yourname/website.git
cd website

# 添加上游仓库（外部贡献者需要）
git remote add upstream https://github.com/company/website.git
```

### 验证远程仓库

```bash
git remote -v
```

### ✅ 预期输出（团队成员）

```
origin  https://github.com/company/website.git (fetch)
origin  https://github.com/company/website.git (push)
```

### ✅ 预期输出（外部贡献者）

```
origin    https://github.com/yourname/website.git (fetch)
origin    https://github.com/yourname/website.git (push)
upstream  https://github.com/company/website.git (fetch)
upstream  https://github.com/company/website.git (push)
```

---

## 9.4 完整的 PR 工作流程

### 步骤1：同步主分支

确保你的本地 main 分支是最新的：

```bash
# 切换到主分支
git checkout main

# 拉取最新代码
git pull origin main

# 外部贡献者还需要同步上游
git fetch upstream
git merge upstream/main
```

### 步骤2：创建功能分支

```bash
# 创建并切换到功能分支
git checkout -b feature/user-login

# 或者使用新命令
git switch -c feature/user-login
```

> 💡 **分支命名规范**：
> - `feature/功能名` - 新功能
> - `bugfix/bug描述` - Bug 修复
> - `hotfix/紧急修复` - 紧急修复
> - `docs/文档更新` - 文档

### 步骤3：开发功能

编写你的代码，多次小提交：

```bash
# 开发过程中...
# 编辑文件

# 查看修改
git status
git diff

# 添加并提交（小步提交）
git add login.js
git commit -m "feat(login): 添加登录表单验证"

# 继续开发...
git add api.js
git commit -m "feat(login): 实现登录API调用"

# 添加样式
git add login.css
git commit -m "style(login): 添加登录页面样式"
```

### 步骤4：推送分支到远程

```bash
# 推送功能分支到远程
git push -u origin feature/user-login
```

### ✅ 预期输出

```
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 8 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 1.23 KiB | 1.23 MiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
remote: 
remote: Create a pull request for 'feature/user-login' on GitHub...
remote:      https://github.com/company/website/pull/new/feature/user-login
remote: 
To https://github.com/company/website.git
 * [new branch]      feature/user-login -> feature/user-login
branch 'feature/user-login' set up to track 'origin/feature/user-login'.
```

### 步骤5：在 GitHub 上创建 PR

**方法1：点击推送后的链接**

推送完成后，GitHub 会显示一个链接，直接点击：
```
https://github.com/company/website/pull/new/feature/user-login
```

**方法2：手动创建**

1. 访问仓库页面：`https://github.com/company/website`
2. 点击 **Pull requests** 标签
3. 点击 **New pull request** 按钮
4. 选择合并方向：
   - **base**: `main`（要合并到的分支）
   - **compare**: `feature/user-login`（你的分支）
5. 点击 **Create pull request**

### 步骤6：填写 PR 信息

好的 PR 描述能让审查者更容易理解：

```markdown
## 📋 功能描述
实现用户登录功能，包括前端表单和后端验证

## 🔧 改动内容
- ✅ 添加登录页面 `/login`
- ✅ 实现表单验证（邮箱+密码）
- ✅ 对接后端登录 API
- ✅ 添加登录状态管理
- ✅ 编写单元测试

## 📸 截图
![登录页面](https://example.com/screenshot.png)

## 🔗 相关 Issue
Closes #123

## ✅ 检查清单
- [x] 代码通过本地测试
- [x] 添加了单元测试
- [x] 更新了文档
- [x] 代码符合团队规范
```

### 步骤7：代码审查（Code Review）

PR 创建后，团队成员会进行审查：

#### 7.1 审查者视角

```bash
# 本地拉取 PR 进行测试（审查者）
git fetch origin pull/123/head:pr-123
git checkout pr-123

# 测试完成后清理
git checkout main
git branch -D pr-123
```

#### 7.2 常见的审查意见

| 类型 | 示例 | 处理方式 |
|------|------|----------|
| 问题 | "这里可能有空指针异常" | 修复代码 |
| 建议 | "建议用更简洁的写法" | 讨论后可接受或拒绝 |
| 疑问 | "这个参数是干什么用的？" | 解释或添加注释 |
| 赞赏 | "这段代码写得很优雅！" | 😊 |

#### 7.3 处理审查意见

当审查者提出修改建议：

```bash
# 1. 切换到功能分支
git checkout feature/user-login

# 2. 根据意见修改代码
# 编辑文件...

# 3. 提交修改
git add .
git commit -m "fix(login): 修复空指针异常问题"

# 4. 推送到远程（自动更新PR）
git push origin feature/user-login
```

> 💡 推送后，PR 会自动更新，审查者可以看到新的修改

### 步骤8：解决冲突（如有）

如果 main 分支有更新，可能需要解决冲突：

```bash
# 1. 切换到主分支并更新
git checkout main
git pull origin main

# 2. 切换回功能分支
git checkout feature/user-login

# 3. 合并主分支（或 rebase）
git merge main
# 或者
git rebase main

# 4. 解决冲突后推送
git push origin feature/user-login
```

### 步骤9：合并 PR

当代码审查通过，可以合并：

**方法1：在 GitHub 上合并**

1. 点击 **Merge pull request** 按钮
2. 选择合并方式：
   - **Create a merge commit** - 保留完整历史
   - **Squash and merge** - 压缩为单个提交
   - **Rebase and merge** - 线性历史
3. 点击确认

**方法2：本地合并（仓库维护者）**

```bash
# 1. 拉取 PR 分支
git fetch origin pull/123/head:pr-123

# 2. 切换到主分支
git checkout main

# 3. 合并
git merge --no-ff pr-123 -m "Merge pull request #123: 用户登录功能"

# 4. 推送
git push origin main

# 5. 清理
git branch -D pr-123
```

### 步骤10：清理分支

PR 合并后，清理本地和远程分支：

```bash
# 切换到主分支
git checkout main

# 拉取最新代码
git pull origin main

# 删除本地功能分支
git branch -d feature/user-login

# 删除远程功能分支
git push origin --delete feature/user-login
```

---

## 9.5 PR 的三种合并方式

| 方式 | 图示 | 适用场景 |
|------|------|----------|
| **Merge** | `main: A─B─C─D─E─F─G`<br>`feature:      \D─E/` | 保留完整分支历史 |
| **Squash** | `main: A─B─C─D─(DEF)` | 功能简单，提交较乱 |
| **Rebase** | `main: A─B─C─D─E─F` | 需要线性历史 |

### Merge（默认）

```
main:    A ── B ── C ── F(合并提交)
               \       /
feature:        D ── E
```

- ✅ 保留完整的历史记录
- ✅ 保留分支信息
- ❌ 历史可能较复杂

### Squash and Merge

```
main:    A ── B ── C ── D'(D+E压缩)
               
feature:        D ── E (丢弃)
```

- ✅ 主分支历史简洁
- ✅ 每个 PR 一个提交
- ❌ 丢失详细提交历史

### Rebase and Merge

```
main:    A ── B ── C ── D' ── E'
               
feature:        (D ── E 重放)
```

- ✅ 线性历史，非常干净
- ✅ 保留详细提交
- ❌ 修改了提交 hash

---

## 9.6 PR 最佳实践

### ✅ 应该做的

| 实践 | 说明 |
|------|------|
| **小步提交** | 一个 PR 只做一件事，方便审查 |
| **写清楚描述** | 说明做了什么、为什么做、如何测试 |
| **自测通过** | 提交前确保代码能跑通 |
| **关联 Issue** | 使用 `Closes #123` 自动关闭 Issue |
| **及时响应** | 快速回复审查者的评论 |
| **保持更新** | 定期同步主分支，减少冲突 |

### ❌ 不应该做的

| 反模式 | 说明 |
|--------|------|
**巨型 PR** | 几百行代码，审查者无从下手 |
| **无描述** | 只写 "修复bug"，不知所云 |
| **包含无关修改** | PR 里混入其他功能的代码 |
| **忽略审查意见** | 不回复、不修改 |
| **强制推送** | `git push -f` 会丢失历史 |

### 提交信息规范

```
feat(login): 添加用户登录功能

- 实现登录表单验证
- 对接后端登录API
- 添加登录状态管理

Closes #123
```

---

## 9.7 Draft PR（草稿 PR）

当你想提前分享代码，但还没完成：

```
创建 PR 时选择 "Create draft pull request"
```

- 明确表示"还在开发中"
- 可以获取早期反馈
- 完成后点击 "Ready for review"

---

## 9.8 PR 模板

在仓库根目录创建 `.github/pull_request_template.md`：

```markdown
## 📋 描述
<!-- 描述这个 PR 做了什么 -->

## 🔧 改动类型
- [ ] 🐛 Bug 修复
- [ ] ✨ 新功能
- [ ] 📝 文档更新
- [ ] 🔨 代码重构

## ✅ 检查清单
- [ ] 代码通过本地测试
- [ ] 添加了必要的测试
- [ ] 更新了文档
- [ ] 代码符合规范

## 🔗 相关 Issue
Fixes #(issue 编号)

## 📸 截图（如有 UI 改动）
```

---

## 9.9 常用命令速查表

| 命令 | 作用 |
|------|------|
| `git checkout -b feature/xxx` | 创建功能分支 |
| `git push -u origin feature/xxx` | 推送分支到远程 |
| `git fetch origin pull/123/head:pr-123` | 拉取 PR 到本地 |
| `git merge main` | 合并主分支到当前分支 |
| `git push origin --delete feature/xxx` | 删除远程分支 |
| `gh pr create` | 使用 GitHub CLI 创建 PR |
| `gh pr checkout 123` | 使用 GitHub CLI 检出 PR |

---

## 📝 课后练习

1. Fork 一个开源项目（或创建自己的仓库）
2. 创建一个功能分支，添加一些修改
3. 提交并推送到你的 Fork
4. 创建一个 Pull Request
5. 自己审查一遍 PR，练习写评论
6. 合并 PR 并清理分支

---

## 相关工具

- **GitHub CLI**: `gh pr create` 命令行创建 PR
- **VS Code GitHub Pull Requests**: 在编辑器内处理 PR
- **GitKraken**: 图形化 PR 管理

---

## ➡️ 至此，你已经掌握了完整的 Git 工作流程！

继续在实际项目中练习，你会越来越熟练！🎉
