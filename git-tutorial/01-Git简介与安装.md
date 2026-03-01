# 第1节：Git简介与安装

## 📚 本节目标
- 了解什么是Git
- 安装Git并验证安装
- 了解Git的基本概念

---

## 1.1 什么是Git？

**Git** 是一个分布式版本控制系统，用于跟踪文件的更改。它可以帮助你：

- 📝 记录文件的每次修改
- 🔄 随时回退到历史版本
- 👥 多人协作开发
- 🌿 并行开发不同功能（分支）

### 版本控制的发展历程

```
本地版本控制 → 集中式版本控制（SVN） → 分布式版本控制（Git）
```

---

## 1.2 安装Git

### Windows 安装

**方法1：官方下载安装**
1. 访问 https://git-scm.com/download/win
2. 下载安装包
3. 双击安装，一路点击 "Next"（使用默认设置即可）

**方法2：使用 Winget（Windows 10/11）**

```powershell
# 打开 PowerShell 或 CMD，运行：
winget install --id Git.Git -e --source winget
```

### macOS 安装

```bash
# 使用 Homebrew 安装
brew install git

# 或者下载安装包
# https://git-scm.com/download/mac
```

### Linux 安装

```bash
# Ubuntu/Debian
sudo apt-get install git

# CentOS/RHEL
sudo yum install git

# Fedora
sudo dnf install git
```

---

## 1.3 验证安装

打开终端（Windows 使用 Git Bash 或 PowerShell），运行以下命令：

```bash
# 查看 Git 版本
git --version
```

### ✅ 预期输出

```
git version 2.43.0
```

> 💡 如果看到类似上面的版本信息，说明安装成功！

---

## 1.4 初次配置

安装完成后，需要配置你的身份信息：

```bash
# 配置用户名（用于标识谁提交了代码）
git config --global user.name "你的名字"

# 配置邮箱（用于标识你的身份）
git config --global user.email "your.email@example.com"

# 配置默认编辑器（可选，这里使用 VS Code）
git config --global core.editor "code --wait"
```

### 验证配置

```bash
# 查看所有配置
git config --list
```

### ✅ 预期输出

```
user.name=你的名字
user.email=your.email@example.com
core.editor=code --wait
```

---

## 1.5 获取帮助

Git 提供了详细的帮助文档：

```bash
# 查看 Git 帮助
git help

# 查看特定命令的帮助，例如 git config
git help config

# 或者使用简写
git config --help
```

---

## 1.6 本节小结

| 命令 | 作用 |
|------|------|
| `git --version` | 查看 Git 版本 |
| `git config --global user.name` | 设置用户名 |
| `git config --global user.email` | 设置邮箱 |
| `git config --list` | 查看配置列表 |

---

## 📝 课后练习

1. 安装 Git 并验证版本
2. 配置你的用户名和邮箱
3. 查看你的配置信息

---

## ➡️ 下一节预告

下一节我们将学习 **Git 基础配置** 和 **创建你的第一个仓库**！
