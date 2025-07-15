# Batch4Images
## Usage [cellpose](http://www.cellpose.org/)

Use the scrpit `CB3.sh` for batch process

`chmod 777 CB3.sh`

`./CB3.sh`


## Usage ImageJ

**set the scale**

80X 8 μm 100 piex

40X 16 μm 100 piex

20X 32 μm 100 piex

4.2X 153 μm 100 piex

Use the script `cell_count_2.ijm` to calculate the diameters (from the area)

**add scale bar**

Use the script `scale_bar.ijm` to add scale bar

## Select Round >=0.85

Use the script `batch_filter.py` 

python batch_filter.py "your_work_pwd"
