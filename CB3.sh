#!/bin/bash

# �����ļ��е�·��
CP_DIR="/home/yang/Documents/lyon/Cellpose241105/"

# �����ļ����е���Ŀ¼
for subdir in "$CP_DIR"/*; do
    if [ -d "$subdir" ]; then
        # �����Ŀ¼���ڣ�������Ŀ¼��ִ�� cellpose ����
        subdir_name=$(basename "$subdir")
        echo "������Ŀ¼: $subdir_name"
        
        # ����Ŀ¼��ִ�� cellpose ����
        python -m cellpose --use_gpu --dir "$subdir" --diameter 0. --flow_threshold 3. --pretrained_model cyto3 --save_rois --verbose
        
        echo "��ɴ�����Ŀ¼: $subdir_name"
    fi
done
