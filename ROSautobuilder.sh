#!/bin/bash

#Please do not use script if you are not sure about your system version or it's compatability with ROS noetic
#read -p "Enter your Ubuntu version(18, 20, 22): " ver

if [[ ! -n $1 ]]
then
    echo "No argument given. Check README before retrying"
    exit 1

ver=$1

if [[ $ver -eq 20 ]]
then
    echo "Build ROS noetic for 20.04"

    read -p "Are you ready? (yes\no): " choice

    if [[ $choice == 'yes' ]] || [[ $choice == 'y' ]] || [[ $choice == 'да' ]] || [[ $choice == 'д' ]]
    then

        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

        sudo apt install -y curl

        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

        sudo apt update

        sudo apt install -y ros-noetic-desktop-full

        apt search ros-noetic

        source /opt/ros/noetic/setup.bash

        echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

        source ~/.bashrc

        sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

        sudo apt install -y python3-rosdep

        sudo rosdep init

        rosdep update

        sudo mkdir catkin_ws

        cd catkin_ws/

        mkdir src

        catkin_make

        echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

        echo "Build for Ubuntu 20.04 finished"
        exit 0

    elif [[ $choice != 'yes' ]] && [[ $choice != 'y' ]] && [[ $choice != 'да' ]] && [[ $choice != 'д' ]]
        then    
            echo "Build aborted"
            exit 1
    fi

elif [[ $ver -eq 18 ]]
then
    echo "Build ROS noetic for 18.04"

    read -p "Are you ready? (yes\no): " choice

    if [[ $choice == 'yes' ]] || [[ $choice == 'y' ]] || [[ $choice == 'да' ]] || [[ $choice == 'д' ]]
    then
        echo "Starting"

        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

        sudo apt install -y curl

        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

        sudo apt update

        sudo apt install -y ros-noetic-desktop-full

        apt search ros-noetic

        source /opt/ros/noetic/setup.bash

        echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

        source ~/.bashrc

        sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

        sudo apt install -y python3-rosdep

        sudo rosdep init

        rosdep update

        sudo mkdir catkin_ws

        cd catkin_ws/

        mkdir src

        catkin_make

        echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

        echo "Build for Ubuntu 18.04 finished"

    else
        echo "Build aborted. Something went wrong"
        exit 1
    fi

elif [[ $ver -eq 22 ]]
then
    echo "Building ROS noetic for 22.04, may be unstable, look after installation logs"

    read -p "Are you ready? (yes\no): " choice

    if [[ $choice == 'yes' ]] || [[ $choice == 'y' ]] || [[ $choice == 'да' ]] || [[ $choice == 'д' ]]
    then
        echo "Starting"

        git clone https://github.com/lucasw/ros_from_src.git
        
        mkdir build
        
        cd build
        
        ROSCONSOLE=https://github.com/ros/rosconsole ../ros_from_src/git_clone.sh
        
        sudo ../ros_from_src/dependencies.sh
        
        ../ros_from_src/build.sh

        echo "Build for 22.04 finished"

    else
        echo "Build aborted. Something went wrong"
        exit 1
    fi
fi
