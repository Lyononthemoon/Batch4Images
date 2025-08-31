
// 1) 准备路径与文件名（不含扩展名）
path = getDirectory("image");
name = File.nameWithoutExtension;

// 2) 阈值与掩膜（按你原逻辑）
run("8-bit");
setAutoThreshold("Default dark");
// run("Threshold..."); // 可省略对话框
setThreshold(255, 255);
setOption("BlackBackground", true);
run("Convert to Mask");

// 3) 生成 ROI 并保存为与原图同名的 .roi
run("Create Selection");
// 若需要外扩线条厚度，保留；否则可去掉
// run("Make Inverse"); // 如不需要可注释
run("Enlarge...", "enlarge=2");

run("ROI Manager...");
roiManager("Reset");        // 先清空，避免残留
roiManager("Add");
roiManager("Save", path + name + ".roi");

// 4) 新建与原图同尺寸的空白图
w = getWidth();
h = getHeight();
newImage(name + "_outline", "8-bit white", w, h, 1);
selectWindow(name + "_outline");

// 5) 重新载入 ROI，并**选中**为当前选区，再绘制
roiManager("Open", path + name + ".roi");
roiManager("Select", 0);    // 关键：把 ROI 变成当前选区
run("Line Width...", "line=2"); // 可调线宽
run("Draw");                // 只绘制边界线

// 6) 保存 PNG：与原图同路径同名
saveAs("PNG", path + name + "_outline.png");
close();
run("Close");
run("Close");