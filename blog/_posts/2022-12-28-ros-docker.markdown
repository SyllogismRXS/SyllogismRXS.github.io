---
layout: single
title:  "ROS Development in Docker"
date:   2022-12-28 10:45:00 -0400
categories: ROS Docker docker-compose robotics programming development
header:
  teaser: /assets/images/2022-12-28-ros-docker/docker-ros.png
  og_image: /assets/images/2022-12-28-ros-docker/docker-ros.png
  image: /assets/images/2022-12-28-ros-docker/docker-ros-header.png
---

If you use the [Robot Operating System (ROS)](https://www.ros.org) and you are
frusterated with system dependencies, incompatible ROS / Linux operating system
versions, and non-determinstic builds, then this article is for you.

For each of my ROS development workspaces, I create a
[Docker](https://www.docker.com/) development environment to isolate the ROS
environment from my host system's environment. This allows me to easily run an
old version of ROS (e.g., ROS Kinetic), on a new version of Ubuntu (e.g.,
Ubuntu 22.04 Jammy). Docker is similar to a very light-weight virtual machine,
but Docker allows you to more easily share hardware resources between the host
machine and the Docker container.

There are a number of other guides to setup a  development
environment:
- [ROS Docker 1](https://roboticseabass.com/2021/04/21/docker-and-ros/)
- [ROS Docker 2](https://tuw-cpsg.github.io/tutorials/docker-ros/)
- [Using ROS from a Docker
  Image](https://subscription.packtpub.com/book/hardware-&-creative/9781786463654/1/ch01lvl1sec11/using-ros-from-a-docker-image)
- [ROS Dev in Docker
  Mac/Windows](https://docs.freedomrobotics.ai/docs/ros-development-in-docker-on-mac-and-windows)

I think that many of the articles focus on basic Docker commands, instead of an
opinionated description of how to organize your ROS workspaces and
repositories to facilitate collaborative development.


## Design Requirements

In our ROS Docker setup, we want to be able to:

1. Use our preferred code/text editor on the host system.
2. Launch ROS GUI programs from within the container.
3. Leverage the host system's GPU, if available.

## Host System Dependencies

As a warning, I'm writing this guide from the perspective of someone who uses
Ubuntu for development, but most of the instructions should apply to anyone
using a Linux-based (amd64) system. (Note to self: try these instructions on my
Windows 10 partition).

1. [Install Docker](https://docs.docker.com/engine/install/). Make sure to
   follow the
   [post-installation](https://docs.docker.com/engine/install/linux-postinstall/)
   steps, so you don't have to use `sudo` to run Docker.

2. [Install Docker Compose](https://docs.docker.com/compose/install/linux/).

3. [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

That's all you should need! We will be installing all the messy ROS bits inside
of a Docker container, so your host system will stay nice and clean.

## Host Directory Setup / Docker Build

On my host machine, I keep all of my ROS projects in a folder located at
`~/ros` and I will use that directory in this guide to be explicit, but you can
use a different root directory.

1. Create the `src` directory in a new ROS workspace:

        mkdir -p ~/ros/ros_docker_example/workspace/src

2. Create a `data` directory, which will be used to facilitate exchanging
   files (e.g., ROS bags), between the ROS Docker container and your host system:

        mkdir -p ~/ros/ros_docker_example/data

3. Clone the ROS Docker setup files from my GitHub repository under the
   `ros_docker_example` directory:

        cd ~/ros/ros_docker_example
        git clone https://github.com/SyllogismRXS/ros_docker_setup.git

    Your directory should now look like the following:

    ![Directory Structure]({{ site.url }}{{ site.baseurl }}/assets/images/2022-12-28-ros-docker/tree.png)

4. Clone the ROS2 example repository into your workspace's `src` folder. We
   will be building these example projects to test our build system. You would
   replace this repository with your own ROS repositories.

        cd ~/ros/ros_docker_example/workspace/src
        git clone -b humble https://github.com/ros2/examples.git

5. We will now create a `.env` file in the same directory that contains the
   `docker-compose.yml` file with your user's ID and group ID. This is needed,
   so that we can launch ROS GUIs from within the Docker container.

        cd ~/ros/ros_docker_example/ros_docker_setup
        echo -e "USER_ID=$(id -u ${USER})\nGROUP_ID=$(id -g ${USER})" > .env

    Docker compose will automatically read the `.env` file before running any
    commands.

6. We can now build the Docker image in the `ros_docker_setup` directory:

        docker compose build

## Test the Docker Environment

1. Run the minimal subscriber example

        docker compose up -d dev
        docker exec -it ros_humble /bin/bash
        ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function


2. In a different terminal, run the minimal publisher example:

        docker exec -it ros_humble /bin/bash
        ros2 run examples_rclcpp_minimal_publisher publisher_member_function

    At this point, you should see ROS messages being printed to the terminal.

3. Launch the rviz2 GUI from inside the container:

        docker exec -it ros_humble /bin/bash
        rviz2

## Development Use Case

The primary use case for this Docker setup is to develop ROS packages. After
building the Docker image, you can start a container (once with the `up` command,
enter into it (with the `exec` command), run a build command (with `colcon`),
and run other ROS commands. For example, you can start and enter a container:

    docker compose up -d dev
    docker exec -it ros_humble /bin/bash

At this point, you can use your host's code/text editor to make changes to code
in your host's workspace `src` directory and they will immediately take effect
in the container's `src` directory. Then, inside of the container, build the
workspace with the command:

    colcon build --symlink-install


You can use multiple Docker container terminals by running `docker exec -it
ros_humble /bin/bash` in another terminal after the `up` command was already
run once.

## Detailed Notes

The following are detailed notes that describe some of the Docker
options/features and why they were chosen. This section is most helpful if you
following along with the `docker-compose.yml` and `Dockerfile` commands in the
[`ros_docker_setup`](https://github.com/SyllogismRXS/ros_docker_setup)
repository.

### docker-compose.yml

1. The
[`docker-compose.yml`](https://github.com/SyllogismRXS/ros_docker_setup/blob/main/docker-compose.yml)
file contains two separate "services": `dev` and `dev-nvidia`. The `dev-nvidia`
service contains additional flags to share the host's NVIDIA GPU with the
Docker container. In order to use the `dev-nvidia` service, you will need both
an NVIDIA GPU and you will need to install `nvidia-docker2` using NVIDIA's
[instructions](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html).

2. The `USER_ID` and `GROUP_ID` variables are passed from `.env` to the Docker
   build command via the build arguments:

        args:
          USER_ID: ${USER_ID:-0}
          GROUP_ID: ${GROUP_ID:-0}

3. The `network_mode` is set to `host` to allow the container to have full
   access to the host's networking system. This is fine for a development
   environment, but should be made more restrictive in a deployed container
   (not our current use-case).

4. The `DISPLAY` environment variable display is passed from the host to the
   container to enable GUI applications. In addition, the `.X11-unix` and
   `.docker.xauth` files are mounted from the host to the container in the
   `volumes` section to enable GUIs.

5. The `src` directory of the workspace is mounted from the host to the
   container in the `volumes` section. It is important to note that the
   `volumes` section of the `docker-compose.yml` file is only relevant during
   `up` and `run` commands, not during the `build` phase. During build time,
   the code is copied into the Docker image with the `COPY` command in the
   `Dockerfile`.


### Dockerfile

1. The
   [`Dockerfile`](https://github.com/SyllogismRXS/ros_docker_setup/blob/main/Dockerfile)
   contains the instructions to build the ROS Docker image. Our `Dockerfile` is
   based on the `osrf/ros:humble-desktop-full` Docker image provided by the
   main ROS folks (OSRF, OpenRobotics, etc.) This image already contains an
   installed version of ROS Humble and many of the GUIs and build utilities,
   which we will be using.

2. After declaring the `FROM` image and some basic metadata, we install a
   specific Debian package:

        RUN apt-get update \
            && apt-get install -y \
            python3-pip \
            && rm -rf /var/lib/apt/lists/*

    In your own Dockerfile, you would augment this Debian package installation
    list to fit your needs.

3. Using the `adduser` command, we create a `ros` user with the same `USER_ID`
   and `GROUP_ID` as your host system, which enables GUI applications. In
   addition, the `ros` user can issue `sudo` commands without a
   password. Again, this is fine for a local development environment, but you
   wouldn't do this in a deployed Docker image.

4. We source the main ROS system's setup file (`/opt/ros/humble/setup.bash`)
   and colcon's setup file to the `ros` user's `.bashrc`. This provides the
   `ros` user with access to the ROS environment every time the container is
   entered.

5. Near the end of the `Dockerfile`, the code is copied into the image with the
   `COPY` command. The code is copied into the image, so that we can install
   it's dependencies and make sure it builds deterministically. However, when
   the user runs the `docker compose up` command, the code on the host system
   is mounted over the code that was previously copied into the image. This
   allows changes to the repository code to show up immediately inside the
   container for incremental builds.

6. Finally, `rosdep` is used to install the repository's dependencies and
   `colcon` is used to perform the workspace build. In addition, the
   workspace's `local_setup.bash` is added to the `ros` user's `.bashrc` file,
   so that it's resources are immediately available when the container is
   entered.
