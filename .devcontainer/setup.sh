#!/bin/bash
set -e

echo "=== 开始设置ARM64环境 ==="

# 显示系统信息
echo "1. 系统信息:"
uname -m
python --version

echo "2. 确保conda可用..."
if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
    source /opt/conda/etc/profile.d/conda.sh
fi

# 检查conda命令
if ! command -v conda &> /dev/null; then
    echo "Conda未找到，尝试安装..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O miniconda.sh
    bash miniconda.sh -b -p /opt/conda
    export PATH="/opt/conda/bin:$PATH"
fi

echo "3. 创建mattersim环境..."
conda create -n mattersim python=3.10 -y

echo "4. 激活环境..."
conda activate mattersim

echo "5. 设置pip镜像源（加速下载）..."
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip config set global.trusted-host pypi.tuna.tsinghua.edu.cn

echo "6. 安装numpy和torch..."
pip install numpy
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

echo "7. 安装mattersim..."
pip install mattersim

echo "8. 验证安装..."
python -c "
import sys
print(f'Python: {sys.version}')
try:
    import mattersim
    print('✓ mattersim导入成功')
    import torch
    print(f'✓ torch版本: {torch.__version__}')
    import numpy
    print(f'✓ numpy版本: {numpy.__version__}')
except Exception as e:
    print(f'✗ 错误: {e}')
"

echo "9. 打包环境..."
conda install -c conda-forge conda-pack -y
conda pack -n mattersim -o /workspaces/mattersim-arm64/mattersim_arm64.tar.gz

echo "=== 完成 ==="
echo "打包文件: mattersim_arm64.tar.gz"
echo "大小: $(du -h mattersim_arm64.tar.gz | cut -f1)"
