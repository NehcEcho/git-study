# 第8节：Git 高级技巧

## 📚 本节目标
- 掌握 stash 暂存
- 学习 cherry-pick
- 理解 rebase
- 使用子模块

---

## 8.1 Stash 暂存

当你正在开发一个功能，突然需要切换分支处理紧急任务，但当前修改还没完成不想提交：

### 保存当前进度

```bash
# 查看当前状态（有未提交的修改）
git status
```

### ✅ 预期输出

```
On branch feature-new
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
        modified:   main.js
```

### 使用 stash 暂存

```bash
# 暂存当前修改
git stash

# 或者添加描述
git stash push -m "实现登录功能中"
```

### ✅ 预期输出

```
Saved working directory and index state WIP on feature-new: abc1234 上次提交
```

### 查看 stash 列表

```bash
git stash list
```

### ✅ 预期输出

```
stash@{0}: WIP on feature-new: abc1234 上次提交
stash@{1}: On feature-old: 修复bug中
```

### 恢复 stash

```bash
# 恢复最新的 stash（并从列表中删除）
git stash pop

# 恢复但不删除
git stash apply

# 恢复指定的 stash
git stash apply stash@{1}
```

### 删除 stash

```bash
# 删除最新的 stash
git stash drop

# 删除指定的 stash
git stash drop stash@{1}

# 清空所有 stash
git stash clear
```

### 查看 stash 内容

```bash
# 查看 stash 的详细修改
git stash show

# 查看完整 diff
git stash show -p
```

---

## 8.2 Cherry-pick

将某个分支的特定提交应用到当前分支：

```
main:    A ── B ── C ── D ── E
               ↑
feature:       └─ F ── G ── H
                    ↑
                  只想拿这个提交
```

### 使用 cherry-pick

```bash
# 切换到 main 分支
git checkout main

# 将 feature 分支的 G 提交应用到 main
git cherry-pick G的commitID
```

### 处理冲突

如果 cherry-pick 产生冲突：

```bash
# 解决冲突后
git add .
git cherry-pick --continue

# 或者放弃
git cherry-pick --abort
```

---

## 8.3 Rebase 变基

Rebase 可以整理提交历史，使其更线性：

### 普通 rebase

```bash
# 在 feature 分支上执行
git checkout feature
git rebase main
```

效果对比：

```
# 合并前（merge）
main:    A ── B ── C ── D ── E ── F
               ↑              ↑
feature:       └── X ── Y ────┘

# rebase 后
main:    A ── B ── C ── D ── E ── F
                                    ↑
feature:                            X' ── Y'
```

### 交互式 rebase（整理提交）

```bash
# 整理最近 3 个提交
git rebase -i HEAD~3
```

### 会打开编辑器，显示：

```
pick abc1234 第一次提交
pick def5678 第二次提交
pick ghi9012 第三次提交

# Rebase abc1234..ghi9012 onto abc1234 (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# d, drop <commit> = remove commit
```

### 常用操作

```bash
# 合并多个提交为一个
pick abc1234 第一次提交
squash def5678 第二次提交
squash ghi9012 第三次提交

# 修改提交信息
reword abc1234 第一次提交

# 删除提交
drop def5678 第二次提交
```

### Rebase 冲突处理

```bash
# 解决冲突后
git add .
git rebase --continue

# 或者跳过当前提交
git rebase --skip

# 或者放弃 rebase
git rebase --abort
```

---

## 8.4 子模块（Submodule）

当项目依赖其他 Git 仓库时，可以使用子模块：

```
my-project/
├── src/
├── docs/
└── lib/              # 子模块
    └── external-lib/ # 另一个 Git 仓库
```

### 添加子模块

```bash
# 添加子模块
git submodule add https://github.com/user/external-lib.git lib/external-lib

# 查看状态
git status
```

### ✅ 预期输出

```
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   .gitmodules
        new file:   lib/external-lib
```

### 克隆带子模块的项目

```bash
# 方法1：递归克隆
git clone --recursive https://github.com/user/my-project.git

# 方法2：普通克隆后初始化子模块
git clone https://github.com/user/my-project.git
cd my-project
git submodule init
git submodule update

# 或者简写
git submodule update --init --recursive
```

### 更新子模块

```bash
# 拉取子模块更新
git submodule update --remote

# 或者进入子模块目录
cd lib/external-lib
git pull origin main
cd ../..
git add lib/external-lib
git commit -m "更新子模块"
```

---

## 8.5 Bisect 二分查找

当你知道某个功能之前是好的，现在坏了，可以用 bisect 快速定位问题提交：

```bash
# 开始二分查找
git bisect start

# 标记当前版本有问题
git bisect bad

# 标记某个旧版本是好的
git bisect good v1.0.0

# Git 会自动切换到中间的提交，测试后标记
git bisect good   # 或者 git bisect bad

# 重复直到找到问题提交

# 结束二分查找
git bisect reset
```

---

## 8.6 其他实用技巧

### 只查看文件名

```bash
# 查看修改了哪些文件
git diff --name-only

# 查看某次提交修改的文件
git show --name-only abc1234
```

### 统计代码行数

```bash
# 统计每个人的提交行数
git log --author="用户名" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added: %s, removed: %s, total: %s\n", add, subs, loc }'
```

### 查找删除的代码

```bash
# 搜索某段代码什么时候被删除
git log -S "被删除的代码" --pretty=format:'%h %s'
```

### 打包项目

```bash
# 导出项目为 zip（不包含 .git）
git archive --format=zip --output=project.zip HEAD

# 包含子目录
git archive --format=zip --output=project.zip HEAD:subdir/
```

### 清理仓库

```bash
# 查看哪些文件会被清理
git clean -n

# 清理未跟踪的文件（危险！）
git clean -f

# 清理未跟踪的文件和目录
git clean -fd

# 同时清理忽略的文件
git clean -fdx
```

---

## 8.7 常用命令速查表

| 命令 | 作用 |
|------|------|
| `git stash` | 暂存当前修改 |
| `git stash pop` | 恢复并删除最新 stash |
| `git stash list` | 查看 stash 列表 |
| `git cherry-pick <commit>` | 挑选提交 |
| `git rebase <branch>` | 变基到某分支 |
| `git rebase -i HEAD~n` | 交互式整理提交 |
| `git submodule add <url>` | 添加子模块 |
| `git bisect start` | 开始二分查找 |
| `git clean -fd` | 清理未跟踪文件 |

---

## 📝 课后练习

1. 修改文件后使用 `git stash` 暂存，切换分支后再恢复
2. 创建一个分支，提交 3 次，使用 `git rebase -i` 合并为 1 次
3. 使用 `git cherry-pick` 将一个提交应用到另一个分支
4. 使用 `git log -S` 搜索某段代码的历史

---

## 🎉 恭喜你完成了所有课程！

现在你已经掌握了 Git 的核心知识和高级技巧。继续练习，Git 会成为你最得力的开发工具！

### 推荐学习资源

- [Pro Git 中文版](https://git-scm.com/book/zh/v2)
- [GitHub Learning Lab](https://lab.github.com/)
- [Oh Shit, Git!?!](https://ohshitgit.com/)
