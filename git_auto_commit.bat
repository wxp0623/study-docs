@echo off
:: 获取当前日期（格式：2025年03月25日）
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do set commitMsg=%%a年%%b月%%c日上传

:: 切换到脚本所在目录（即 Git 仓库）
cd /d %~dp0

:: 添加所有更改
git add .

:: 提交更改
git commit -m "%commitMsg%"

:: 推送到远程仓库
git push origin master

echo ==============================
echo ✅ 代码已成功提交并推送！
echo 提交信息：%commitMsg%
echo ==============================
pause
