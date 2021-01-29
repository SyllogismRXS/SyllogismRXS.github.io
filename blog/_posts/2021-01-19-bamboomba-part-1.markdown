---
layout: single
title:  "Bamboomba: The wooden robot."
date:   2021-01-19 12:00:00 -0400
categories: robotics ROS woodworking
header:
  teaser: /assets/images/2021-01-19-bamboomba-part-1/teaser.jpg
  og_image: /assets/images/2021-01-15-dovetail-box/DSC_0520.JPG
  image: /assets/images/2021-01-19-bamboomba-part-1/header.jpg
---

What do you get when you cross a Roomba from 2008...

![Apart Roomba]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/apart_roomba.jpg)

with scrap wood?

![Wood with scroll saw]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/scroll-saw-wood.jpg)

You get... Bamboomba!

![Bamboomba]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/bamboomba.jpg)

You might be wondering why Kevin, being the professional researcher who he is,
decided to build a half-wooden monstrosity with an obsolete robot base.  Didn't
Kevin go to college for thirteen years or something? Why didn't you just buy a
robot, Kevin? How is this robot going to help you pay your mortgage? Kevin.

Jeeeeeez, stop hassling me. I built Bamboomba to show what is possible with a
couple of low-cost sensors and to learn about the new features in the [Robot
Operating System (ROS) 2](https://index.ros.org/doc/ros2/)
[Navigation2](https://navigation.ros.org/) software stack. Also, I think it's
really really funny.

![Ruler]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/ruler.jpg)

To be completely honest, when my friend and I co-founded [RIF
Robotics](https://www.rifrobotics.com) in the fall of 2020, we submitted an
application to Clearpath Robotics'
[PartnerBot](https://clearpathrobotics.com/blog/2020/11/winners-of-the-2020-partnerbot-grant-program-announced-putting-robotic-platforms-in-researchers-hands/)
program and we won! That means we will be receiving an industrial-grade indoor
ground robot in February 2021 named
[Dingo](https://clearpathrobotics.com/dingo-indoor-mobile-robot/).

![Bamboomba]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/dingo.png)

We will be using the ROS2 and Navigation2 software stacks to control Dingo and
build maps of the environment with a LIDAR, but I wanted to get a head start on
the software development, so I built Bamboomba as a surrogate platform. Both
Bamboomba and Dingo will have the same sensor suite and software stack, so
moving between the two platforms should be fairly seamless. I did go to college
for thirteen years, right? The sensor suite consists of an [Intel RealSense
D435i](https://www.intelrealsense.com/depth-camera-d435/) and an [RP LIDAR
A2](https://www.slamtec.com/en/Lidar/A2).

![Sensors]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/sensor-suite.jpg)

The D435i provides an inertial measurement unit (i.e., measurements of linear
and rotational accelerations), a 2D RGB image, and a 3D point cloud of the
environment. The RP LIDAR uses a rotating laser to measure distances to objects
around the robot in 360 degrees. There will be more on these sensors and how
they help the robot to build maps and navigate around obstacles in a future
post. The important part to note at this moment is that I hand cut and drilled
the mounts for these professional sensors without using any CAD software or 3D
printers. One of my industrial design friends said that he calls anything not
cut by a [CNC](https://en.wikipedia.org/wiki/Numerical_control) machine
"folksy."  Like folk music. Not written down. I prefer the term... Artisinal
Robotics.

![Artisinal Robotics]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/artisinal-robotics.gif)

That GIF isn't from a random woodworking project. I was fine-tuning the
mounting block for the LIDAR on my shooting board.

Bamboomba is loosely based on the Turtlebot design, which has been used
extensively in the open source and academic robotics communities.

![Turtlebot]({{ site.url }}{{ site.baseurl
}}/assets/images/2021-01-19-bamboomba-part-1/turtlebot.png)

But Bamboomba is a lot cheaper, only took one day to build from scratch, and,
literally, can't be reproduced! The main idea I took from the Turtlebot was the
multiple levels offset by aluminum stand-offs. This sparse design allows a
roboticist to attach random sensors and a closed laptop (the robot "brains")
can fit on one of the platforms. I was able to cut the platforms out of spare
plywood using my scroll saw. However, I didn't want to order stand-offs from an
expensive mechanical parts store and wait two weeks for the parts to arrive, so
I drove five minutes to Lowe's and stared at the mechanical fasteners for an
hour until I came up with the following design for the stand-offs:

![Stand offs]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/standoffs.jpg)

The aluminum rod cost $10 and I was able to cut it precisely with a pipe cutter:

![Cutting]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/cutting.jpg)

Once the aluminum rod stand-offs were cut to size, it was fairly easy to
assemble the platforms. The most difficult part was in determining where to
drill the holes for the screws to pass through without a template. Still, the
desired effect was achieved.

![Cutting]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/platforms.jpg)
