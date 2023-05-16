#!/bin/bash

#Please do not use script if you are not sure about your system version or it's compatability with ROS noetic
#read -p "Enter your Ubuntu version(18, 20, 22): " ver
source functions.sh
if [[ ! -n $1 ]]
then
    echo "No argument given. Check README before retrying"
    exit 1
fi
ver=$1
wait || { echo "Something failed: $?" >&2; exit 1;}
#for 20.04
if [[ $ver -eq 20 ]]
then
    ros_install_and_build_20_18

    px4clover_install_build
    
#for 18.04 - pretty simillar to 20.04 but may be a bit more unstable
elif [[ $ver -eq 18 ]]
then
    ros_install_and_build_20_18

    px4clover_install_build
#for 22.04 - can be very unstable because of incompatiability of ROS and this version of ubuntu. But somehow works.
elif [[ $ver -eq 22 ]]
then
    ros_install_and_build_22

    px4clover_install_build
fi
