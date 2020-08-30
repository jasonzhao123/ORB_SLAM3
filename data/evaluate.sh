#!/bin/bash

# dir of evaluate directory
# EVALUATE_ROOT=$1
EVALUATE_ROOT="/home/yubao/data/project/Evaluation"

# repeate cout
# REPEATE=$2
REPEATE=1

cd fr3_walk_xyz
TRAJECTORY_DIR=`pwd`

$EVALUATE_ROOT/TUM/ate_rpe_evaluate.sh $TRAJECTORY_DIR $REPEATE


