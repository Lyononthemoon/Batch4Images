// 设置比例尺

run("Set Scale...", "distance=100 known=153 unit=µm"); // 100 像素 = 153 µm

// 调整图像对比度
run("Window/Level...");
run("Enhance Contrast", "saturated=0.01");

// 转换为 8-bit 灰度
run("8-bit");

// 添加比例尺条，宽度 500 µm
run("Scale Bar...", "width=500 height=20 thickness=40 bold hide overlay");

// 保存为 PNG，路径同图像
dir_saving = getDirectory("image");
saveAs("png", dir_saving + getTitle);

// 关闭图像
close();

