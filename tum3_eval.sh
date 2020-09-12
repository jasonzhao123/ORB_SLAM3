#!/bin/bash
dataset="/root/Dataset/TUM/freiburg3/"
result="`pwd`/data/raw/"

echo "Dataset: $dataset"
echo "Result path: $result"

if [ -d $result ]; then
    echo "$result"
else
    mkdir -p "$result"
fi

if [ -d "$result/fr3_walk_xyz/" ]; then
    echo "result/fr3_walk_xyz/"
else
    mkdir "$result/fr3_walk_xyz/"
fi

if [ -d "$result/fr3_walk_static/" ]; then
    echo "result/fr3_walk_static/"
else
    mkdir "$result/fr3_walk_static/"
fi

if [ -d "$result/fr3_walk_rpy/" ]; then
    echo "result/fr3_walk_rpy/"
else
    mkdir "$result/fr3_walk_rpy/"
fi

if [ -d "$result/fr3_walk_halfsphere/" ]; then
    echo "result/fr3_walk_halfsphere/"
else
    mkdir "$result/fr3_walk_halfsphere/"
fi

if [ -d "$result/fr3_sitting_static/" ]; then
    echo "$result/fr3_sitting_static/"
else
    mkdir "$result/fr3_sitting_static/"
fi

# Repeated number
COUNT=5
count=0

while (($count < $COUNT))
do
    echo "------------------- $count --------------------"
    echo "rgbd_dataset_freiburg3_walking_xyz"
    tmp="$result"/fr3_walk_xyz/
    echo $tmp
     ./Examples/RGB-D/rgbd_tum ./Vocabulary/ORBvoc.txt ./Examples/RGB-D/TUM3.yaml "$dataset"/rgbd_dataset_freiburg3_walking_xyz "$dataset"/rgbd_dataset_freiburg3_walking_xyz/associations.txt
    python ./evaluation/evaluate_ate.py ./evaluation/Ground_truth/TUM/fr3_walk_xyz.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_xyz_ate_"$count".png  --plot3D  "$tmp"/fr3_walk_xyz_ate_3d_"$count".png --verbose > "$tmp"/fr3_walk_xyz_ate_"$count".txt
    python ./evaluation/evaluate_rpe.py ./evaluation/Ground_truth/TUM/fr3_walk_xyz.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_xyz_rpe_"$count".png  --fixed_delta --verbose > "$tmp"/fr3_walk_xyz_rpe_"$count".txt
    mv KeyFrameTrajectory.txt  $tmp/KeyFrameTrajectory_"$count".txt
    mv CameraTrajectory.txt $tmp/CameraTrajectory_"$count".txt

    echo "-----------------------------------------------------------------"
    echo "rgbd_dataset_freiburg3_walking_static"
    tmp="$result"/fr3_walk_static/
     ./Examples/RGB-D/rgbd_tum ./Vocabulary/ORBvoc.txt ./Examples/RGB-D/TUM3.yaml "$dataset"/rgbd_dataset_freiburg3_walking_static "$dataset"/rgbd_dataset_freiburg3_walking_static/associations.txt
    python ./evaluation/evaluate_ate.py ./evaluation/Ground_truth/TUM/fr3_walk_static.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_static_ate_"$count".png  --plot3D  "$tmp"/fr3_walk_static_ate_3d_"$count".png --verbose > "$tmp"/fr3_walk_static_ate_"$count".txt
    python ./evaluation/evaluate_rpe.py ./evaluation/Ground_truth/TUM/fr3_walk_static.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_static_rpe_"$count".png  --fixed_delta  --verbose > "$tmp"/fr3_walk_static_rpe_"$count".txt
    mv KeyFrameTrajectory.txt  $tmp/KeyFrameTrajectory_"$count".txt
    mv CameraTrajectory.txt $tmp/CameraTrajectory_"$count".txt

    echo "-----------------------------------------------------------------"
    echo "rgbd_dataset_freiburg3_walking_rpy"
    tmp="$result"/fr3_walk_rpy/
     ./Examples/RGB-D/rgbd_tum ./Vocabulary/ORBvoc.txt ./Examples/RGB-D/TUM3.yaml "$dataset"/rgbd_dataset_freiburg3_walking_rpy "$dataset"/rgbd_dataset_freiburg3_walking_rpy/associations.txt
    python ./evaluation/evaluate_ate.py ./evaluation/Ground_truth/TUM/fr3_walk_rpy.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_rpy_ate_"$count".png  --plot3D  "$tmp"/fr3_walk_rpy_ate_3d_"$count".png --verbose > "$tmp"/fr3_walk_rpy_ate_"$count".txt
    python ./evaluation/evaluate_rpe.py ./evaluation/Ground_truth/TUM/fr3_walk_rpy.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_rpy_rpe_"$count".png  --fixed_delta  --verbose > "$tmp"/fr3_walk_rpy_rpe_"$count".txt
    mv KeyFrameTrajectory.txt  $tmp/KeyFrameTrajectory_"$count".txt
    mv CameraTrajectory.txt $tmp/CameraTrajectory_"$count".txt

    echo "-----------------------------------------------------------------"
    echo "rgbd_dataset_freiburg3_walking_halfsphere"
    tmp="$result"/fr3_walk_halfsphere/
     ./Examples/RGB-D/rgbd_tum ./Vocabulary/ORBvoc.txt ./Examples/RGB-D/TUM3.yaml "$dataset"/rgbd_dataset_freiburg3_walking_halfsphere "$dataset"/rgbd_dataset_freiburg3_walking_halfsphere/associations.txt
    python ./evaluation/evaluate_ate.py ./evaluation/Ground_truth/TUM/fr3_walk_halfsphere.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_halfsphere_ate_"$count".png  --plot3D  "$tmp"/fr3_walk_halfsphere_ate_3d_"$count".png --verbose > "$tmp"/fr3_walk_halfsphere_ate_"$count".txt
    python ./evaluation/evaluate_rpe.py ./evaluation/Ground_truth/TUM/fr3_walk_halfsphere.txt CameraTrajectory.txt --plot "$tmp"/fr3_walk_halfsphere_rpe_"$count".png  --fixed_delta --verbose > "$tmp"/fr3_walk_halfsphere_rpe_"$count".txt
    mv KeyFrameTrajectory.txt  $tmp/KeyFrameTrajectory_"$count".txt
    mv CameraTrajectory.txt $tmp/CameraTrajectory_"$count".txt

    echo "-----------------------------------------------------------------"
    echo "rgbd_dataset_freiburg3_sit_static"
    tmp="$result"/fr3_sitting_static/
     ./Examples/RGB-D/rgbd_tum ./Vocabulary/ORBvoc.txt ./Examples/RGB-D/TUM3.yaml "$dataset"/rgbd_dataset_freiburg3_sit_static "$dataset"/rgbd_dataset_freiburg3_sit_static/associations.txt
    python ./evaluation/evaluate_ate.py ./evaluation/Ground_truth/TUM/fr3_sitting_static.txt CameraTrajectory.txt --plot "$tmp"/fr3_sitting_static_ate_"$count".png  --plot3D  "$tmp"/fr3_sitting_static_ate_3d_"$count".png --verbose > "$tmp"/fr3_sitting_static_ate_"$count".txt
    python ./evaluation/evaluate_rpe.py ./evaluation/Ground_truth/TUM/fr3_sitting_static.txt CameraTrajectory.txt --plot "$tmp"/fr3_sitting_static_rpe_"$count".png  --fixed_delta --verbose > "$tmp"/fr3_sitting_static_rpe_"$count".txt
    mv KeyFrameTrajectory.txt  $tmp/KeyFrameTrajectory_"$count".txt
    mv CameraTrajectory.txt $tmp/CameraTrajectory_"$count".txt


    count=`expr $count + 1`
done

echo "============================================"
echo "calculate average value"
echo "fr3_walk_xyz"
./average.pl $result/fr3_walk_xyz/fr3_walk_xyz_ate_ $COUNT $result/fr3_walk_xyz/ate.txt
./average.pl $result/fr3_walk_xyz/fr3_walk_xyz_rpe_ $COUNT $result/fr3_walk_xyz/rpe.txt

echo "fr3_walk_rpy"
./average.pl $result/fr3_walk_rpy/fr3_walk_rpy_ate_ $COUNT $result/fr3_walk_rpy/ate.txt
./average.pl $result/fr3_walk_rpy/fr3_walk_rpy_rpe_ $COUNT $result/fr3_walk_rpy/rpe.txt

echo "fr3_walk_halfsphere"
./average.pl $result/fr3_walk_halfsphere/fr3_walk_halfsphere_ate_ $COUNT $result/fr3_walk_halfsphere/ate.txt
./average.pl $result/fr3_walk_halfsphere/fr3_walk_halfsphere_rpe_ $COUNT $result/fr3_walk_halfsphere/rpe.txt

echo "fr3_walk_static"
./average.pl $result/fr3_walk_static/fr3_walk_static_ate_ $COUNT $result/fr3_walk_static/ate.txt
./average.pl $result/fr3_walk_static/fr3_walk_static_rpe_ $COUNT $result/fr3_walk_static/rpe.txt

echo "fr3_sitting_static"
./average.pl $result/fr3_sitting_static/fr3_sitting_static_ate_ $COUNT $result/fr3_sitting_static/ate.txt
./average.pl $result/fr3_sitting_static/fr3_sitting_static_rpe_ $COUNT $result/fr3_sitting_static/rpe.txt
