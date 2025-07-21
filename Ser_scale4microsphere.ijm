// 调整图像对比度
run("Window/Level...");
run("Enhance Contrast", "saturated=0.01");

// 转换为 8-bit 灰度
run("8-bit");

// 添加比例尺条，宽度 20 µm
run("Scale Bar...", "width=20 height=20 thickness=40 bold hide overlay");

// 保存为 PNG，路径同图像
dir_saving = getDirectory("image");
saveAs("png", dir_saving + getTitle);

// 关闭图像
close();