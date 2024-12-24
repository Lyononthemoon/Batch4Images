run("Window/Level...");
run("Enhance Contrast", "saturated=0.15");
run("8-bit");
run("Scale Bar...", "width=20 height=20 thickness=40 bold hide overlay");
dir_saving = getDirectory("image");
saveAs("png", dir_saving + getTitle);
close()
