% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 6: Vacuum Gripper 2 -----
% A simple program combining the RTDE toolbox with the Vacuum gripper
% toolbox.
% NOTE: VACUUM GRIPPER SOFTWARE WILL NOT WORK USING THE VM. YOU MUST BE
% WORKING WITH THE REAL UR5e TO RUN THIS SOFTWARE

clc;
clear all;

% TCP Host and Port settings
host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
rtdeport = 30003;
vacuumport = 63352;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,rtdeport);

% Calling the constructor of vacuum to setup tcp connction
claw = vacuum(host,vacuumport);


% CLOSE GRIPPER
claw.pressure = 255;
claw.speed = 0;
claw.timeout = 0;

claw.grip()


pause(1);


%OPEN GRIPPER
claw.pressure = 0;
claw.speed = 0;
claw.timeout = 0;

claw.grip()


pause(1);



claw.close();
% Closing the TCP Connection
rtde.close();



