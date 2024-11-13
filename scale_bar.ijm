run("Window/Level...");
run("Enhance Contrast", "saturated=0");
run("Scale Bar...", "width=20 height=20 thickness=20 bold hide overlay");
dir_saving = getDirectory("image");
saveAs("png", dir_saving + getTitle);
close()