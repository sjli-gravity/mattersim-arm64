# 1. 查看文件内容
cat .devcontainer/devcontainer.json
cat .devcontainer/setup.sh
cat .github/codespaces/machines.json

# 2. 初始化git仓库（如果还没做）
git init

# 3. 添加所有文件到git
git add .

# 4. 提交
git commit -m "添加ARM64环境配置"

# 5. 在GitHub上创建仓库（需要先在网页操作）
echo "请在浏览器中访问: https://github.com/new"
echo "创建名为 'mattersim-arm64' 的仓库"
echo "不要初始化README（因为我们已经有了）"

# 6. 连接远程仓库（替换YOUR-USERNAME）
# git remote add origin https://github.com/YOUR-USERNAME/mattersim-arm64.git
# git branch -M main
# git push -u origin main
