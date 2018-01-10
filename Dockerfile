FROM ubuntu:16.04

RUN useradd -ms /bin/bash ros

RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.0x.sg/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update \
    && apt-get install -y ros-lunar-desktop-full \
    && apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN rosdep init

USER ros
RUN rosdep update
RUN echo "source /opt/ros/lunar/setup.bash" >> ~/.bashrc

