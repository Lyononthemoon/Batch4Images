# Batch4Images

简短说明
- Batch4Images：用于对图片批量处理并计算/筛选细胞/颗粒相关指标（基于 Cellpose + ImageJ 脚本 + Python 过滤脚本）。
- 目标：提供一个从分割到测量再到筛选的自动化处理流程。

## 目录
- Overview
- Requirements
- Installation
- Usage
  - 使用 Cellpose 脚本（CB3.sh）
  - 使用 ImageJ 宏（cell_count_3.ijm、scale_bar.ijm）
  - 筛选脚本（batch_filter.py）
- 示例目录结构
- 示例命令
- 输出说明
- 常见问题
- 许可证 & 联系方式

---

## Overview
本仓库包含用于图像分割（Cellpose）、度量（ImageJ 宏）和后处理/筛选（Python）的脚本。典型流程：
1. 用 CB3.sh 批量运行 Cellpose 进行分割。
2. 用 ImageJ 宏计算面积/直径并添加比例尺。
3. 用 batch_filter.py 根据 roundness（或其它指标）筛选结果。

## Requirements
- Linux / macOS（脚本为 shell 脚本）
- Cellpose（https://www.cellpose.org/）
- ImageJ / Fiji（用于运行 `.ijm` 宏）
- Python 3.8+（用于 `batch_filter.py`）
- Python 依赖（建议提供 `requirements.txt`；请根据脚本补充，例如：numpy, pandas, opencv-python 等）

## Installation
1. 安装 Cellpose：https://www.cellpose.org/
2. 下载并安装 Fiji/ImageJ：https://fiji.sc/
3. 安装 Python 依赖（示例）：

