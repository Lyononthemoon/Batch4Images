# Batch4Images

简短说明
- Batch4Images：用于对图片批量处理并计算/筛选细胞/颗粒相关指标（基于 Cellpose + ImageJ 宏 + Python 过滤脚本）。
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
本仓库包含用于图像分割（Cellpose）、度量（ImageJ 宏）和���处理/筛选（Python）的脚本。典型流程：
1. 用 `CB3.sh` 批量运行 Cellpose 进行分割。
2. 用 ImageJ 宏计算面积/直径并添加比例尺。
3. 用 `batch_filter.py` 根据 roundness（或其它指标）筛选结果。

## Requirements
- Linux / macOS（脚本为 shell 脚本）
- Cellpose（https://www.cellpose.org/）
- ImageJ / Fiji（用于运行 `.ijm` 宏）
- Python 3.8+（用于 `batch_filter.py`）
- Python 依赖（建议提供 `requirements.txt`；示例：numpy, pandas, opencv-python）

## Installation
1. 安装 Cellpose：https://www.cellpose.org/
2. 下载并安装 Fiji/ImageJ：https://fiji.sc/
3. 安装 Python 依赖（示例）：

--- a/README.md
+++ b/README.md
@@ -1,34 +1,201 @@
-# Batch4Images
-## Usage [cellpose](http://www.cellpose.org/)
-
-Use the scrpit `CB3.sh` for batch process
-
-`chmod 777 CB3.sh`
-
-`./CB3.sh`
-
-## Usage ImageJ
-
-**set the scale**
-
-80X 8 μm 100 piex
-
-40X 16 μm 100 piex
-
-20X 32 μm 100 piex
-
-4.2X 153 μm 100 piex
-
-Use the script `cell_count_3.ijm` to calculate the diameters (from the area)
-
-**add scale bar**
-
-Use the script `scale_bar.ijm` to add scale bar
-
-## Select Round >=0.85
-
-Use the script `batch_filter.py` 
-
-python batch_filter.py "your_work_pwd"
+# Batch4Images
+
+简短说明
+- Batch4Images：用于对图片批量处理并计算/筛选细胞/颗粒相关指标（基于 Cellpose + ImageJ 宏 + Python 过滤脚本）。
+- 目标：提供一个从分割到测量再到筛选的自动化处理流程。
+
+## 目录
+- Overview
+- Requirements
+- Installation
+- Usage
+  - 使用 Cellpose 脚本（CB3.sh）
+  - 使用 ImageJ 宏（cell_count_3.ijm、scale_bar.ijm）
+  - 筛选脚本（batch_filter.py）
+- 示例目录结构
+- 示例命令
+- 输出说明
+- 常见问题
+- 许可证 & 联系方式
+
+---
+
+## Overview
+本仓库包含用于图像分割（Cellpose）、度量（ImageJ 宏）和后处理/筛选（Python）的脚本。典型流程：
+1. 用 `CB3.sh` 批量运行 Cellpose 进行分割。
+2. 用 ImageJ 宏计算面积/直径并添加比例尺。
+3. 用 `batch_filter.py` 根据 roundness（或其它指标）筛选结果。
+
+## Requirements
+- Linux / macOS（脚本为 shell 脚本）
+- Cellpose（https://www.cellpose.org/）
+- ImageJ / Fiji（用于运行 `.ijm` 宏）
+- Python 3.8+（用于 `batch_filter.py`）
+- Python 依赖（建议提供 `requirements.txt`；示例：numpy, pandas, opencv-python）
+
+## Installation
+1. 安装 Cellpose：https://www.cellpose.org/
+2. 下载并安装 Fiji/ImageJ：https://fiji.sc/
+3. 安装 Python 依赖（示例）：
+   ```
+   python3 -m pip install -r requirements.txt
+   ```
+
+## Usage
+
+### 使用 Cellpose（CB3.sh）
+仓库中原始说明：
+- Use the script `CB3.sh` for batch process
+- `chmod 777 CB3.sh`
+- `./CB3.sh`
+
+集成并改进后的建议用法：
+- 给脚本可执行权限（建议使用较安全的权限）：
+  ```
+  chmod +x CB3.sh
+  ```
+  （如果你确实需要 777，我可以按原文保留；但通常用 `+x` 即可）
+- 运行脚本：
+  ```
+  ./CB3.sh
+  ```
+- 说明：
+  - 脚本会在当前工作目录或脚本内部指定的目录查找输入图像并调用 Cellpose。
+  - 如果脚本接受参数（输入路径、模型、GPU/CPU 等），请在脚本顶部或 README 中补充示例参数。
+
+### 使用 ImageJ 宏
+原始说明中给出的比例尺与宏使用方法已整合如下：
+
+- 设置比例尺（示例）
+  - 80X → 8 μm = 100 pixels
+  - 40X → 16 μm = 100 pixels
+  - 20X → 32 μm = 100 pixels
+  - 4.2X → 153 μm = 100 pixels
+
+- 计算直径（由面积计算）
+  - 使用 `cell_count_3.ijm` 来计算直径（从面积换算）。
+  - 可在 ImageJ/Fiji 中打开并运行该宏，或使用 headless 模式：
+    ```
+    ImageJ --headless -macro cell_count_3.ijm "input=path/to/images output=path/to/out"
+    ```
+  - 请确认宏输出的 CSV/结果文件中列名（例如 area、diameter、roundness），以便后续脚本读取。
+
+- 添加比例尺
+  - 使用 `scale_bar.ijm` 宏为图片添加比例尺（根据上面设置的像素/μm 关系）。
+
+### 筛选（Select Round >= 0.85）
+原始说明：
+- Use the script `batch_filter.py`
+- `python batch_filter.py "your_work_pwd"`
+
+集成说明：
+- 基本命令：
+  ```
+  python3 batch_filter.py "your_work_pwd"
+  ```
+- 说明：
+  - `your_work_pwd` 为包含测量结果（CSV 等）的工作目录。
+  - 默认筛选条件为 roundness >= 0.85（请在脚本或 README 中明确 roundness 的计算方法以及对应 CSV 列名）。
+  - 建议为脚本添加命令行参数，支持自定义字段名与阈值（例如 `--field roundness --threshold 0.85`）。
+
+## 示例目录结构
+```
+project/
+├─ raw_images/
+├─ cellpose_output/
+├─ ij_results/
+│  └─ measurements.csv
+├─ filtered/
+└─ CB3.sh
+```
+
+## 输出说明
+- cellpose_output/: segmentation masks / overlays
+- ij_results/measurements.csv: 包含面积、直径、roundness 等字段
+- filtered/: 筛选后的图像或 CSV
+
+## Troubleshooting
+- 如果 `CB3.sh` 无法运行，检查 Cellpose 是否在 PATH 中或脚本中的 cellpose 路径是否正确。
+- 建议使用 `chmod +x` 而非 `chmod 777`。
+- 如果 ImageJ 宏未生成预期列，打开输出文件确认列名并修改 `batch_filter.py` 中对应字段。
+
+## Contributing
+欢迎提交 issue 或 PR。建议：
+- 提供运行环境与重现步骤。
+- 若修改脚本或 README，请在 PR 中包含测试步骤。
+
+## License
+请在此处添加许可证（例如 MIT、Apache-2.0 等），或在仓库中添加 LICENSE 文件。
+
+## Contact
+如有问题，请在仓库 Issues 中提问或联系仓库维护者。
