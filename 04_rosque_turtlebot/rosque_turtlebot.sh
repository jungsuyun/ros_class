#!/bin/bash

echo ""
echo "[Note] Install rosserial_python"
echo "[Note] Catkin workspace   >>> /opt/ros/kinetic"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

mkdir -p $HOME/ros_catkin_ws
cd $HOME/ros_catkin_ws
rosinstall_generator rosserial_python --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
wstool init src kinetic-ros_comm-wet.rosinstall
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/kinetic

echo "[Install Turtlebot3 Package on your Raspberry Pi 4]"
cd $HOME/catkin_ws/src
git clone https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3.git

cd $HOME/catkin_ws/src/turtlebot3
rm -r turtlebot3_description/ turtlebot3_teleop/ turtlebot3_navigation/ turtlebot3_slam/ turtlebot3_example/
cd $HOME/catkin_ws && catkin_make -j1

echo "[Root Permission for your OPENCR]"
rosrun turtlebot3_bringup create_udev_rules

echo "[OpenCR Firmware Upload for Turtlebot3]"
export OPENCR_PORT=/dev/ttyACM0
export OPENCR_MODEL=burger
wget https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS1/latest/opencr_update.tar.bz2 && tar -xvf opencr_update.tar.bz2 && cd ./opencr_update && ./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr && cd ..

echo "[Complete!!!]"
exit 0