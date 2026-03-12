#!/bin/bash

xhost +local:root

CONTAINER_NAME="garlio_noetic"

sudo docker run -it --rm \
  --name=$CONTAINER_NAME \
  --network host \
  --ipc=host \
  --privileged \
  --env="QT_X11_NO_MITSHM=1" \
  --env="DISPLAY=$DISPLAY" \
  --volume="/etc/localtime:/etc/localtime:ro" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="$HOME/data:/root/data" \
  --device=/dev/dri \
  --group-add video \
  garlio:noetic \
  /bin/bash
