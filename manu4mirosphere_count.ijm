
run("Set Scale...", "distance=100 known=153 unit=µm"); // 100 像素 = 153 µm

run("8-bit");

run("Threshold...");

setThreshold(0, 216);

setOption("BlackBackground", true);

run("Convert to Mask");

run("Watershed");

run("Analyze Particles...", "size=1000-Infinity circularity=0.70-1.00 show=Outlines display summarize");

Table.applyMacro("Diameter = sqrt(4 * Area / PI);");