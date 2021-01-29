---
layout: single
title:  "Bamboomba: The sort of wooden robot."
date:   2021-01-19 12:00:00 -0400
categories: robotics ROS woodworking
header:
  teaser: /assets/images/2021-01-19-bamboomba-part-1/teaser.jpg
  og_image: /assets/images/2021-01-19-bamboomba-part-1/angle-view.jpg
  image: /assets/images/2021-01-19-bamboomba-part-1/header.jpg
---

What do you get when you cross a Roomba...

![Apart Roomba]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/apart_roomba.jpg)

with scrap wood?

![Wood with scroll saw]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/scroll-saw-wood.jpg)

You get... Bamboomba!

![Bamboomba]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/bamboomba.jpg)

You might be wondering why Kevin, being the professional researcher who he is,
decided to build a half-wooden monstrosity with an obsolete robot base.  Didn't
Kevin go to college for thirteen years or something? Why don't you just *buy* a
robot, Kevin? How is this robot going to help you pay your mortgage? Kevin.

Jeeeeeez, stop hassling me. I built Bamboomba to show what is possible with a
couple of low-cost sensors and to learn about the new features in the [Robot
Operating System (ROS) 2](https://index.ros.org/doc/ros2/)
[Navigation2](https://navigation.ros.org/) software stack. Also, I think it's a
really funny name.

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
for like thirteen years, right? The sensor suite consists of an [Intel
RealSense D435i](https://www.intelrealsense.com/depth-camera-d435/) and an [RP
LIDAR A2](https://www.slamtec.com/en/Lidar/A2).

![Sensors]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/sensor-suite.jpg)

The D435i provides an inertial measurement unit (i.e., measurements of linear
and rotational accelerations), a 2D RGB image, and a 3D point cloud of the
environment. The RP LIDAR uses a rotating laser to measure distances to objects
around the robot in 360&deg;. There will be more on these sensors and how
they help the robot to build maps and navigate around obstacles in a future
post. The important part to note at this moment is that I hand cut and drilled
the mounts for these professional sensors without using any CAD software or 3D
printers. One of my industrial design friends said that he calls anything not
cut by a [CNC](https://en.wikipedia.org/wiki/Numerical_control) machine
"folksy."  Like folk music. Not written down. I prefer the term, "Artisinal
Robotics."

![Artisinal Robotics]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/artisinal-robotics.gif)

That GIF isn't from a random woodworking project. I was fine-tuning the
mounting block for the LIDAR on the shooting board that I made with a chisel
and hand router.

Bamboomba is loosely based on the
[Turtlebot](https://www.turtlebot.com/turtlebot2/) design, which has been used
extensively in the open source and academic robotics communities.

![Turtlebot]({{ site.url }}{{ site.baseurl
}}/assets/images/2021-01-19-bamboomba-part-1/turtlebot.png)

But Bamboomba is a lot cheaper, only took one day to build from scratch, and,
literally, can't be faithfully reproduced! The main idea I took from the
Turtlebot was the multiple levels offset by aluminum stand-offs. This sparse
design allows a roboticist to attach random sensors to the platforms and a
closed laptop (the robot "brains") can fit on one of the platforms. I was able
to cut the platforms out of spare plywood using my scroll saw. I didn't want to
order aluminum stand-offs from an expensive mechanical parts store and, more
importantly, wait two weeks for the parts to arrive, so I drove five minutes to
Lowe's and stared at the mechanical fasteners section for an hour until I came
up with the following design for the stand-offs:

![Stand offs]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/standoffs.jpg)

The aluminum rod cost $10 and I was able to cut it precisely with a pipe cutter:

![Cutting]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/cutting.jpg)

Once the aluminum rod stand-offs were cut to size, it was fairly easy to
assemble the platforms. The most tedious part was determining where to drill
the holes for the screws to pass through without a template. This involved
drawing intersecting lines to find the midpoint between mounting screw
locations and transferring hole points by laying the wooden platforms directly
on top of each other. If you look closely, you can see my layout lines.

![Standoffs]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/platforms.jpg)

When designing a ground robot with a single planar LIDAR, one of the most
difficult design decisions is where to place the LIDAR. If the LIDAR is mounted
at a low-point on the robot, it will ensure that the LIDAR doesn't miss any
obstacles close to the ground. However, if the LIDAR is close to the ground,
the laser will most likely be obstructed by other mechanical structures on the
robot. This is opposed to mounting the LIDAR on top of the robot, where it can
have an unobstructed 360&deg; view of its surroundings. However, the LIDAR will
not be able to see objects that are below its line-of-sight, which could result
in collisions with low-lying obstacles! Of course, you could use multiple
LIDARs to cover the blind spots, but that costs more money and Bamboomba is not
that kind of robot. I drilled mounting holes for the LIDAR in both the bottom
and the top platforms, so that I could experiment with mounting the LIDAR at
two different heights. When the LIDAR is in the bottom configuration, I route
the LIDAR and serial cables behind the aluminum stand-off to reduce the
obstructions in the LIDAR's field-of-view. The cables are beautifully secured
in place with zip ties.

![LIDAR Bottom]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/lidar-bottom.jpg)

When the LIDAR is mounted in the top configuration, it has to be raised
slightly to ensure that its laser is not obstructed by the RealSense
camera. This is done with the 3/4" piece of wood that played the starring role
in the previous animated GIF.

![Angle View]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/angle-view.jpg)

Finally, the laptop is mounted to Bamboomba with velcro to make it easy to remove.

![Front View]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/front-view.jpg)

I hope this article will inspire others to hack their own Roombas into wooden
abominations. There are [other](https://github.com/tork-a/roomblock) ways to
[build](https://www.turtlebot.com/build/) or
[buy](https://dabit.industries/products/turtlebot-2) a similar robot, but I
like mine best. Bamboomba's platform is made from readily accessible parts that
can be put together in a day with some basic cutting tools.

![Parts]({{ site.url }}{{ site.baseurl }}/assets/images/2021-01-19-bamboomba-part-1/parts-on-bench.jpg)

I've got to come clean about something that has really been bothering me. The
robot's base is not really a Roomba. It's an [iRobot
Create](https://en.wikipedia.org/wiki/IRobot_Create). But the bamboo + Roomba
name was *soooo* good and it's basically the Roomba without the vacuum. My
roommate from college gifted me the Create back in 2008 for being in his
wedding when I had not even considered studying robotics in graduate school. He
knew what I wanted.

In a future post, I will describe how the ROS2 and Navigation2 software stacks
are used to build maps and navigate around obstacles in
the environment with the LIDAR.

Thanks for following along.
