@echo off
chcp 65001 >nul

:: ============================================
:: Git 快速练习脚本 (Windows 版)
:: 运行这个脚本可以快速练习 Git 基本操作
:: ============================================

echo ============================================
echo   Git 快速练习
echo ============================================
echo.

:: 创建练习目录
set "TIMESTAMP=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%"
set "PRACTICE_DIR=git-practice-%TIMESTAMP%"
mkdir %PRACTICE_DIR%
cd %PRACTICE_DIR%

echo 📁 创建练习目录: %PRACTICE_DIR%
echo.

:: 1. 初始化仓库
echo Step 1: 初始化 Git 仓库
echo ------------------------
git init
echo.

:: 2. 配置用户信息
echo Step 2: 配置用户信息
echo ------------------------
git config user.name "练习用户"
git config user.email "practice@example.com"
echo ✅ 配置完成
echo.

:: 3. 创建第一个文件
echo Step 3: 创建第一个文件
echo ------------------------
echo Hello, Git! > readme.txt
type readme.txt
echo.

:: 4. 查看状态
echo Step 4: 查看 Git 状态
echo ------------------------
git status
echo.

:: 5. 添加到暂存区
echo Step 5: 添加到暂存区
echo ------------------------
git add readme.txt
git status
echo.

:: 6. 第一次提交
echo Step 6: 第一次提交
echo ------------------------
git commit -m "首次提交：添加 readme.txt"
echo.

:: 7. 修改文件
echo Step 7: 修改文件
echo ------------------------
echo 这是我的第一个 Git 项目 >> readme.txt
type readme.txt
echo.

:: 8. 查看差异
echo Step 8: 查看修改差异
echo ------------------------
git diff
echo.

:: 9. 提交修改
echo Step 9: 提交修改
echo ------------------------
git add readme.txt
git commit -m "更新 readme.txt：添加项目描述"
echo.

:: 10. 查看提交历史
echo Step 10: 查看提交历史
echo ------------------------
git log --oneline
echo.

:: 11. 创建分支
echo Step 11: 创建并切换到新分支
echo ------------------------
git checkout -b feature-branch
echo 功能代码 > feature.txt
git add feature.txt
git commit -m "添加功能文件"
git branch
echo.

:: 12. 切换回主分支
echo Step 12: 切换回主分支
echo ------------------------
git checkout main
git branch
echo.

:: 13. 合并分支
echo Step 13: 合并分支
echo ------------------------
git merge feature-branch
git log --oneline --graph
echo.

echo ============================================
echo   ✅ 练习完成！
echo ============================================
echo.
echo 练习目录: %cd%
echo.
echo 你可以继续在这个目录练习：
echo   - 创建更多文件并提交
echo   - 尝试版本回退
echo   - 练习解决冲突
echo.
echo 清理命令: rmdir /s /q "%cd%"

pause
