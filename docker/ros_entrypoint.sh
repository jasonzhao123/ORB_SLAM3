#!/bin/bash
set -e

# setup ros environment
echo "ROS workspace: /root/catkin_ws"
source "/opt/ros/melodic/setup.bash"
source "/root/catkin_ws/devel/setup.bash"

cd /root/catkin_ws/src/ORB_SLAM3
bash build.sh

cd ../..
catkin_make

exec "$@"

