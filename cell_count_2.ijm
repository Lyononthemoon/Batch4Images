roiManager("Measure");
Table.applyMacro("Sin=sin(row*0.1); Cos=cos(row*0.1); Diameter = sqrt(4 * Area/PI); ");
dir_saving = getDirectory("image");
saveAs("Results", dir_saving + getTitle() + ".csv");
close("Results");
close("ROI Manager")
close()