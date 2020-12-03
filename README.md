# RailCoreII_300ZLT

My Current Version 
Please review and use at your risk.  The setup I applied my not work for others.

Physical setup

Duet 3 with SBC Raspberry Pi 4 with 4 meg of memory 
The 5 volts supplied to the SBC and Duet are separate. Please review of the jumper settings to ensure the Duet 3 is not trying get or supply power to the SBC.  The reason for separate power supplies are centered on the fact that RPi4 require more power than a version 3.  I did not was a drop in power to either board and cause damage.

SBC – Configuration 
I use WINSCP and the directory /opt/dsf/sd/ is the location for the configuration files.  It will make it easier to copy, backup or post for help.

Hot End

Hemera Hot End with Volcano 0.40 nozzle
  The direct drive setup will change the available printing area in the X and Y
  The Volcano will reduce the Z also

Stepper Motors

All Z motors 1.8-degree E3D high torque motors.  The motors are taller than normal thus the normal case feet will not work with normal case feet.  
            Please note the connection in the Duet board from each location.  It is important for declaring the motors and providing axis locations.

X and Y are Nema 17 0.9-degree with high torque output also.  I felt that a heavy hot end will put strain on the motors and sometimes more is better.

Lead Screws

TR8*2 and with the 1.8 Degree motors provides 0.01mm min Z layer height increment.  
Steps/mm for M92 16 value for the steps is 1600.

Help was provided Railcore Discord room on many of my questions.  It is important to review, and understand before acting.

Again this under development
