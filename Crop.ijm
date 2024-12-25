makeRectangle(1968, 1152, 1696, 1696);
run("Crop");
dir_saving = getDirectory("image");
saveAs("tif", dir_saving + getTitle);
close()