// BatchMeasureFixedOrder2.ijm
// 1. 选择同一文件夹（含 .tif 图像 和 _rois.zip）
dir = getDirectory("Choose Directory");

// 定义 µm/pixel
scale20 = 32.0/100.0; // 0.32 µm/px
scale40 = 16.0/100.0; // 0.16 µm/px
scale80 =  8.0/100.0; // 0.08 µm/px

// 读取并过滤出图像文件（保持 getFileList 的顺序）
allFiles = getFileList(dir);
imageList = newArray(); 
count = 0;
for (i = 0; i < allFiles.length; i++) {
    name = allFiles[i];
    if (endsWith(name, ".tif") || endsWith(name, ".tiff") ||
        endsWith(name, ".jpg") || endsWith(name, ".jpeg") ||
        endsWith(name, ".png") || endsWith(name, ".bmp")) {
        imageList[count] = name;
        count++;
    }
}

// 可选：在 Console 打印出来，确认顺序
print("=== Image list (0–" + (count-1) + ") ===");
for (i = 0; i < count; i++)
    print(i + ": " + imageList[i]);

// 批处理：严格按 imageList 的索引映射到 20×/40×/80×
for (i = 0; i < count; i++) {
    name = imageList[i];
    open(dir + name);
    
    // 根据索引设置标尺
    if (i <= 4) {
        run("Set Scale...", "distance=1 known=" + scale20 + " unit=µm global");
    } else if (i <= 9) {
        run("Set Scale...", "distance=1 known=" + scale40 + " unit=µm global");
    } else {
        run("Set Scale...", "distance=1 known=" + scale80 + " unit=µm global");
    }
    
    // 加载同名 ROI ZIP
    dot    = lastIndexOf(name, ".");
    base   = substring(name, 0, dot);
    roiZip = dir + base + "_rois.zip";
    roiManager("Reset");
    if (File.exists(roiZip)) {
        roiManager("Open", roiZip);
    } else {
        print("Warning: missing ROI: " + roiZip);
    }
    
    // 测量并计算直径
    roiManager("Measure");
    Table.applyMacro("Diameter = sqrt(4 * Area / PI);");
    
    // 保存结果
    saveAs("Results", dir + base + ".csv");
    
    // 关闭
    close("Results");
    close();
}

print("Batch processing complete!");

