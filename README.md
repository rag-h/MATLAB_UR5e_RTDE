# MATLAB UR5e RTDE
An abstraction layer allowing tcp communication between Matlab (windows) to ursim (linux in vm).

## Pre-requsites
1. Ensure that you have setup the URSim properly.
2. Some of the example code use Peter Corkes RVC Toolbox (matlab version), please install that as well

## Download from Github
1. Download code as a zip file.
2. Extract contents.
3. Copy the "rtde" folder

## Windows

1. Navigate to the toolbox Folder of matlab. 
2. On windows this may be "C:\Program Files\MATLAB\R2021b\toolbox".
3. Paste the rtde folder inside.
4. Open MATLAB

## OSX
1. Go to Applications 
2. Right click on MATLAB and select "Show Package Contents".  
3. Open the "Toolbox" folder 
4. In another file explorer window, find the "rtde" folder from inside the extracted folder 
5. Copy the "rtde" folder that you have downloaded into the "Toolbox" folder. 
6. Now that the “rvctools” folder is inside the "Toolbox" folder, right click on the “rvctools” folder and select “Make Alias”. 
7. This should have created another folder like “rvctools alias”. Move this folder to your Desktop Folder 
8. Open MATLAB

## From inside MATLAB (ALL operating systems)
1. Select Set path.
![Select set Path](https://github.com/rag-h/mtrn4230_course_development/blob/main/rtde/images/select%20set%20path.png)
2. Navigate to where you saved the rtde folder. The path should be something like "C:\Program Files\MATLAB\R2021b\toolbox\RTDE" for **windows**. For **OSX**, you’ll need to select the “rtde alias” that you saved on the desktop. 
(Note: The image below is just an example, it does not show the correct file path)

![Find File](https://github.com/rag-h/mtrn4230_course_development/blob/main/rtde/images/setpath.png)

3. Press save. 
4. Install the Instrument Control Toolbox in Matlab. In the Matlab Command Window, type "tmtool", a pop up window will appear, saying "require Instrument Control Toolbox".
11. Click on the tab "Instrument Control Toolbox" in the popped up window
12. Log in with your unsw account to add the toolbox to your existing Matlab
13. Finish Installation

## Verify that the RTDE Toolbox works
1. Open up the Virtual Machine
2. Open up the UR5e URsim application
3. Start the UR5e. Make sure that the red power indicator on the bottom left corner is green. If it is red, select the red power circle. Then press ON -> SELECT on the menu displayed. The red power indicator will now turn green and the robot is now in the powered on state.
Robot powered off state:
![Powered Off](https://github.com/rag-h/MATLAB_UR5e_RTDE/blob/main/rtde/images/ursimpoweredoff.png)

Robot powered on state:
![Powered ON](https://github.com/rag-h/MATLAB_UR5e_RTDE/blob/main/rtde/images/usimpoweredon.png)


4. Open up MATLAB
5. Open up the "example_0_Basic_Usage_1.m" file from inside the examples folder.
6. Make sure that the host IP is :'127.0.0.1'. If it isn't change it
7. Press run.
8. If you get a message saying Connection Established and a few movement Succeeded messages, it means that you have installed and setup everything properly.
9. When you select run, if you switch over to the VM, you can see the UR5e moving as well.

## Troubleshooting
### Connecting to the VM
1. Make sure the IP address is '127.0.0.1' when connecting to the VM. If you use the incorrect IP address MATLAB will freeze and you may need to force close MATLAB and reopen it. 
2. If you do encounter a SAFETY CODE related error on the MATLAB terminal, you will need to switch to the VM and restart the robot.
3. The Vacuum Gripper example code will not work on the VM. They will only work when connected to the real robot. 

### Connecting to the Real UR5e
1. Make sure the IP address is '192.168.0.100' when connecting to the real robot.

### UR5e connection Established! but only getting Time out. Something probably went wrong.! errors:
1. You probably have not started up the UR5e robot in URsim. Check to make sure that the power indicator on the bottom left corner in URsim is green and NOT red. If it is red, you will need to power on the UR5e.
