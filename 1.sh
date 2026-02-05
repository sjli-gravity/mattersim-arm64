# create_files_simple.sh
#!/bin/bash

# 创建所有文件
mkdir -p .devcontainer .github/codespaces

# devcontainer.json
cat > .devcontainer/devcontainer.json << 'END'
{
  "name": "ARM64 Python",
  "image": "mcr.microsoft.com/devcontainers/python:1-3.10",
  "hostRequirements": {"arch": "arm64"},
  "features": {"ghcr.io/devcontainers/features/conda:1": {}},
  "postCreateCommand": "uname -m && python --version"
}
END

# setup.sh  
cat > .devcontainer/setup.sh << 'END'
#!/bin/bash
conda create -n mattersim python=3.10 -y
conda activate mattersim
pip install numpy torch mattersim
conda pack -n mattersim -o mattersim_arm64.tar.gz
END
chmod +x .devcontainer/setup.sh

# machines.json
cat > .github/codespaces/machines.json << 'END'
{"machines": [{"arch": "arm64"}]}
END

# .gitignore
echo "__pycache__/" > .gitignore
echo "*.tar.gz" >> .gitignore

# README.md
cat > README.md << 'END'
# ARM64 Mattersim
在GitHub Codespaces上构建ARM64环境。
END

echo "文件创建完成！"
