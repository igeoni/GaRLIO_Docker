FROM osrf/ros:noetic-desktop-full

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    vim \
    nano \
    build-essential \
    cmake \
    pkg-config \
    python3-pip \
    python3-catkin-tools \
    python3-rosdep \
    libeigen3-dev \
    libpcl-dev \
    libopencv-dev \
    libceres-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libsuitesparse-dev \
    libatlas-base-dev \
    libyaml-cpp-dev \
    libusb-1.0-0-dev \
    libpcap-dev \
    mesa-utils \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# rosdep initialization
RUN if [ ! -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then \
      rosdep init; \
    fi && rosdep update

# Create catkin workspace
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src

# Clone required repositories automatically
RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git
RUN git clone https://github.com/ChiyunNoh/GaRLIO.git

# Build workspace
WORKDIR /root/catkin_ws
RUN source /opt/ros/noetic/setup.bash && \
    catkin init && \
    catkin build

# evo
RUN pip3 install evo --upgrade --no-binary evo

# Environment setup
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc && \
    echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc && \
    echo 'export PATH=$PATH:/root/.local/bin' >> /root/.bashrc

WORKDIR /root/catkin_ws
CMD ["/bin/bash"]
