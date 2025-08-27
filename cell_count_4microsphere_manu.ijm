run("Set Scale...", "distance=100 known=153 unit=µm");
roiManager("Measure");
Table.applyMacro("Diameter=sqrt(4 * Area/PI); ");
dir_saving = getDirectory("image");
saveAs("Results", dir_saving + getTitle() + ".csv");
close("Results");
close("ROI Manager")
close()