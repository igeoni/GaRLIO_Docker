# GaRLIO_Docker

Docker environment for running GaRLIO on Ubuntu 20.04 / ROS Noetic.

## Features

- Automatically clones GaRLIO
- Automatically clones livox_ros_driver
- Automatically builds the catkin workspace
- Ready to run in a container

## Requirements

- Docker
- X11 environment for RViz
- Ubuntu 20.04 recommended

## Build

```bash
git clone https://github.com/igeoni/GaRLIO_Docker.git
cd GaRLIO_Docker
sudo docker build -t garlio:noetic .
./run_garlio.sh

## Run
'''bash
source ~/catkin_ws/devel/setup.bash
roslaunch garlio ntu_loop2_mapping.launch
