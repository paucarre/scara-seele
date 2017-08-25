# Introduction
SCARA-seele is an open source project to design closed-loop SCARA robot which,
when finished, should include solid modeling of parts which should be either
laser cut or 3D printed (besides shafts, bearings, collars, couplers and other metallic pieces)

Source code for inverse kinematics and signal conditioning will
be released in dependant projects. [Kalman Filter for rotary sensor is already available](https://github.com/paucarre/stepper-kalman-filter)

# Solid modeling
The general topology of the SCARA robot will be an first linear actuator
that will lift the chained planar (angular) actuators. As the end effector
will have around 300mm length and the materials will be a mixture of MDF
and plastics, placing the linear actuator at the end of the end effector
it's very likely to cause serious structural problems.

## Angular Actuator

The angular actuator is designed using FreeCAD (open source parametric modeling)
using laser cut for cost reasons.
It uses a AS5448A magnetic rotatory sensor.
The solid modeling file is in `solid_modeling/angular.FCStd`
### FreeCAD Design
![](https://lh3.googleusercontent.com/RZDmFDqH0Tn4_d8J0h7VIhyJDEQKfYXlhl_zMmdzhGFwP4B9fq9yzPpWrqp-vloXW7q_bJuF1Wz9zYs=w3716-h1928-rw)
### Laser cut assembly
![](https://lh3.googleusercontent.com/8Y880jW4qwiRlMy8F-sHVzTMkEQ32ZhlGQjcy1K63yYIatYiH-wjlr93KlCSGTg3F659GPmq1_T-UM8=w3716-h1928-rw)


## Linear Actuator (lifter)
The linear actuator is designed using OpenSCAD. It could had been doing in
FreeCAD but due to the geometrical complexity of the edge joints the software
seemed unable to handle it (it constantly crashed and corrupted design ).
One of the advantages of OpenSCAD is that is very easy to programmatically
design the edge joints using loops.
It should be noted that both the top motor holder and the bottom sensor holder
will be 3d printed independently.
The solid modeling file is in `solid_modeling/lifter.scad`
### OpenSCAD Design
![](https://lh5.googleusercontent.com/hLw_7GoiBAgh1V1O_aSLFpr5kcgygpRbCc1rfbTbzLsLjD-7QiIVWNpfKJAroLmlpEkC2YqZ1JVIaL8=w3716-h1928-rw)
### Laser cut assembly
![](https://lh3.googleusercontent.com/zrHeOZ84twj0wHQmrq3p5EZxGgI6pTz9VCaykLNvBLdA5amYb8wXMkKoWavOUXdhH0VU3Eon3gmtKC8=w3716-h1928-rw)

### Linear Actuator Motor holder
This is ongoing and currently designing it in Fusion 360 and it'll be 3D
printed initially using PLA.
![](https://lh6.googleusercontent.com/WoMa8DIR8OImk-0p-AdwiG5pufYBHc7fRlgscAQXw1rnTh2vDNEez8c_RCOB-KTZVwNTMPRK7gYIplY=w3716-h1836-rw)
