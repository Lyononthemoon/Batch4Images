// BatchMeasureSameDir.ijm
// 1. 选择包含图片和 ROI ZIP 的同一文件夹
dir = getDirectory("Choose Directory");

// 获取该文件夹下所有文件名
fileList = getFileList(dir);

for (i = 0; i < fileList.length; i++) {
    name = fileList[i];
    // 只处理常见图像格式
    if (endsWith(name, ".tif") || endsWith(name, ".tiff") ||
        endsWith(name, ".jpg") || endsWith(name, ".jpeg") ||
        endsWith(name, ".png") || endsWith(name, ".bmp")) {
        
        // 打开图像
        open(dir + name);
        
        // 构造对应的 ROI ZIP 文件名：去掉扩展名 + "_rois.zip"
        dot = lastIndexOf(name, ".");
        baseName = substring(name, 0, dot);
        roiZip = dir + baseName + "_rois.zip";
        
        // 如果 ROI ZIP 存在，则加载
        if (File.exists(roiZip)) {
            roiManager("Reset");
            roiManager("Open", roiZip);
        } else {
            print("Warning: ROI file not found: " + roiZip);
        }
        
        // 测量并计算直径
        roiManager("Measure");
        Table.applyMacro("Diameter = sqrt(4 * Area / PI);");
        
        // 保存结果到同一文件夹，文件名同图片名但后缀为 .csv
        saveAs("Results", dir + baseName + ".csv");
        
        // 关闭 Results 窗口和当前图像
        close("Results");
        close();
    }
}

print("Batch processing in same directory done!");
