// 准备路径与文件名（不含扩展名）
path = getDirectory("image");
name = File.nameWithoutExtension;

// 阈值与掩膜
run("8-bit");
setAutoThreshold("Default dark");
// run("Threshold..."); // 可省略对话框
setThreshold(255, 255);
setOption("BlackBackground", true);
run("Convert to Mask");

// 生成 ROI 并保存为与原图同名的 .roi
run("Create Selection");
// 若需要外扩线条厚度，保留；否则可去掉
// run("Make Inverse"); // 如不需要可注释
run("Enlarge...", "enlarge=2");

run("ROI Manager...");
roiManager("Reset");        // 先清空，避免残留
roiManager("Add");
roiManager("Save", path + name + ".roi");

// 新建与原图同尺寸的空白图（白底）
w = getWidth();
h = getHeight();
newImage(name + "_outline", "8-bit white", w, h, 1);
selectWindow(name + "_outline");

// 重新载入 ROI，并**选中**为当前选区，再绘制
roiManager("Open", path + name + ".roi");
roiManager("Select", 0);    // 关键：把 ROI 变成当前选区

// 设置黑色线条，提高辨识度
setForegroundColor(0, 0, 0);   // RGB(0,0,0) = 黑色
run("Line Width...", "line=2"); // 可调线宽
run("Draw");                    // 只绘制边界线

// 保存 PNG：与原图同路径同名
saveAs("PNG", path + name + "_outline.png");

// 清理窗口
close();
run("Close");
run("Close");

// 重新打开轮廓图进行面积分析
open(path + name + "_outline.png");
outlineImage = getTitle();

// 获取当前活动图像的标题和路径
imageTitle = getTitle();
imagePath = getDirectory("image");
imageName = File.nameWithoutExtension;

// 检查是否已打开图像
if (lengthOf(imageTitle) == 0) {
    exit("No image is open. Please open an image first.");
}

// 确保图像是二值图（如果不是，转换为二值图）
if (bitDepth != 8) {
    run("8-bit");
}
// 设置阈值以确保正确识别轮廓
setAutoThreshold("Default");
setOption("BlackBackground", true);
run("Convert to Mask");

// 分析颗粒（轮廓）- 使用0-Infinity确保所有轮廓都被检测
roiManager("Reset");
run("Analyze Particles...", "size=0-Infinity show=Nothing include add");

// 获取轮廓数量
nContours = roiManager("count");

// 创建输出CSV文件
outputFile = imagePath + imageName + "_areas.csv";
File.append("Image_Name,Contour_Number,Area\n", outputFile);

// 设置测量选项 - 只测量面积
run("Set Measurements...", "area redirect=None decimal=3");

// 测量每个轮廓的面积
for (i = 0; i < nContours; i++) {
    roiManager("Select", i);
    run("Measure");
    
    // 获取面积值
    area = getResult("Area", nResults-1);
    
    // 将结果写入CSV文件
    File.append(imageName + "," + (i+1) + "," + area + "\n", outputFile);
}

// 可选：在图像上绘制轮廓以便可视化
// 创建一个新图像窗口显示轮廓
newWidth = getWidth();
newHeight = getHeight();
newImage(imageName + "_outlines", "8-bit white", newWidth, newHeight, 1);
setForegroundColor(0, 0, 0);
run("Line Width...", "line=2");

for (i = 0; i < nContours; i++) {
    roiManager("Select", i);
    run("Draw");
}

// 清理
roiManager("Reset");
run("Clear Results");

close();
run("Close");
