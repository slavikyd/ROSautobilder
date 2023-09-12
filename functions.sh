#/bin/bash

function depepends(){
    sudo apt install git
    sudo apt install -y curl
    sudo apt-get update
}


function ros_install_and_build_20_18(){
    echo "Build ROS noetic for 20.04"

    read -p "Are you ready? (yes\no): " choice

    if [[ $choice == 'yes' ]] || [[ $choice == 'y' ]] || [[ $choice == 'да' ]] || [[ $choice == 'д' ]]
    then

        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

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

        mkdir -p ~/catkin_ws/src
        
        cd ~/catkin_ws
        
        catkin_make

        echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

        echo "Build ROS for Ubuntu 20.04 finished"
    elif [[ $choice != 'yes' ]] && [[ $choice != 'y' ]] && [[ $choice != 'да' ]] && [[ $choice != 'д' ]]
        then    
            echo "Build aborted"
            exit 8
    fi
}

function ros_install_and_build_22(){
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
        
        sudo apt install catkin

        ../ros_from_src/build.sh

        echo "Build ROS for 22.04 finished"
    else
        echo "Build aborted. Something went wrong"
        exit 8
    fi
}

function px4clover_install_build(){
    read -p "Are you ready for Clover installation? (yes\no): " choice

        if [[ $choice == 'yes' ]] || [[ $choice == 'y' ]] || [[ $choice == 'да' ]] || [[ $choice == 'д' ]]
        then
            echo "Starting"

            echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
            source ~/.bashrc
            echo "Clonning clover source"
            cd ~/catkin_ws/src
            git clone --depth 1 https://github.com/CopterExpress/clover
            git clone --depth 1 https://github.com/CopterExpress/ros_led
            git clone --depth 1 https://github.com/ethz-asl/mav_comm

            cd ~/catkin_ws
            sudo rosdep init
            rosdep update
            rosdep install --from-paths src --ignore-src -y

            sudo /usr/bin/python3 -m pip install -r ~/catkin_ws/src/clover/clover/requirements.txt

            echo "Installing PX4 source code"
            sleep 1 &
            git clone --recursive --depth 1 --branch v1.12.3 https://github.com/PX4/PX4-Autopilot.git ~/PX4-Autopilot
            ln -s ~/PX4-Autopilot ~/catkin_ws/src/
            ln -s ~/PX4-Autopilot/Tools/sitl_gazebo ~/catkin_ws/src/
            ln -s ~/PX4-Autopilot/mavlink ~/catkin_ws/src/

            echo "Dependencies for PX4"
            cd ~/catkin_ws/src/PX4-Autopilot/Tools/setup
            sudo ./ubuntu.sh

            echo "Additional Python packages"

            pip3 install --user toml

            echo "Geographic data installation"
            #sudo /opt/ros/noetic/lib/mavros/install_geographiclib_datasets.sh


            curl https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh -o install_geographiclib_datasets.sh
            chmod a+x ./install_geographiclib_datasets.sh
            sudo ./install_geographiclib_datasets.sh


            echo "Final steps"
            cd ~/catkin_ws
            catkin_make

            echo "Installation done. Enjoy your day)"
            exit 0

        else
            echo "Build aborted. Something went wrong"
            exit 8
        fi

}

### EXPERIMENTAL FEATURE
function ros2_install_and_build_test(){

    sudo apt update && sudo apt install curl gnupg2 lsb-release
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

    echo "Downloading core ROS2 packages"
    xdg-open https://github.com/ros2/ros2/releases/download/release-iron-20230912/ros2-iron-20230912-linux-jammy-amd64.tar.bz2
    echo "Done"
    mkdir -p ~/ros2_dashing
    cd ~/ros2_dashing
    tar xf ~/Downloads/ros2-dashing-linux-x86_64.tar.bz2

    sudo apt update
    sudo apt install -y python-rosdep
    sudo rosdep init
    rosdep update
    #rosdep dependencies
    rosdep install --from-paths ~/ros2_dashing/ros2-linux/share --ignore-src --rosdistro dashing -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 osrf_testing_tools_cpp poco_vendor rmw_connext_cpp rosidl_typesupport_connext_c rosidl_typesupport_connext_cpp rti-connext-dds-5.3.1 tinyxml_vendor tinyxml2_vendor urdfdom urdfdom_headers"

    sudo apt install -y libpython3-dev python3-pip
    pip3 install -U argcomplete

    . ~/ros2_dashing/ros2-linux/setup.bash

    echo "looks like it worked out after all..."
    exit 0
}