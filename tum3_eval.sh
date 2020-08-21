#!/bin/bash
dataset="/home/yubao/data/Dataset/TUM/freiburg3/"
result="/tmp/orbslam/"

# mkdir -p "$result"
# mkdir "$result"/fr3_walk_xyz/

# Repeated number
COUNT=2
count=0

while (($count < $COUNT))
do
    echo "------------------- $count --------------------"
    echo "rgbd_dataset_freiburg3_walking_xyz"
    tmp="$result"/fr3_walk_xyz/
     ./Examples/RGB-D/rgbd_tum ./Vocabulary/ORBvoc.txt ./Examples/RGB-D/TUM3.yaml "$dataset"/rgbd_dataset_freiburg3_walking_xyz "$dataset"/rgbd_dataset_freiburg3_walking_xyz/associations.txt

    python ./evaluation/evaluate_ate.py ./evaluation/Ground_truth/TUM/fr3_walk_xyz.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_xyz_ate_"$count".png  --plot3D  "$tmp"/fr3_walk_xyz_ate_3d_"$count".png --verbose > "$tmp"/fr3_walk_xyz_ate_"$count".txt

    mv KeyFrameTrajectory.txt  $tmp/KeyFrameTrajectory_"$count".txt
    mv CameraTrajectory.txt $tmp/CameraTrajectory_"$count".txt

    count=`expr $count + 1`
done

echo "============================================"
echo "calculate average value"
./average.pl $result/fr3_walk_xyz/fr3_walk_xyz_ate_ $COUNT $result/fr3_walk_xyz/final_result.txt

