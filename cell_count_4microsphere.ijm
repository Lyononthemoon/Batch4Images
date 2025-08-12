// BatchMeasureFixedScale.ijm
// 统一使用固定标尺：53 μm/100 pixel
dir = getDirectory("选择包含图像和ROI的文件夹");

// 定义统一标尺：153 μm/100 pixel = 1.53 μm/pixel
fixedScale = 53.0/100.0; // 0.53 µm/px

// 读取并过滤出图像文件
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

print("=== 发现 " + count + " 个图像 ===");

// 批处理所有图像
for (i = 0; i < count; i++) {
    name = imageList[i];
    print("处理图像 " + (i+1) + "/" + count + ": " + name);
    open(dir + name);
    
    // 设置统一标尺
    run("Set Scale...", "distance=1 known=" + fixedScale + " unit=µm global");
    
    // 加载同名 ROI ZIP
    dot    = lastIndexOf(name, ".");
    base   = substring(name, 0, dot);
    roiZip = dir + base + "_rois.zip";
    
    roiManager("Reset");
    if (File.exists(roiZip)) {
        roiManager("Open", roiZip);
        nROIs = roiManager("count");
        print("  加载 " + nROIs + " 个ROI");
    } else {
        print("警告: 缺失ROI文件: " + roiZip);
    }
    
    // 测量并计算直径
    if (nROIs > 0) {
        roiManager("Measure");
        Table.applyMacro("Diameter = sqrt(4 * Area / PI);");
        
        // 保存结果
        saveAs("Results", dir + base + ".csv");
        print("  结果保存至: " + base + ".csv");
    }
    
    // 清理
    close("Results");
    close();
}

print("批处理完成! 共处理 " + count + " 个图像");