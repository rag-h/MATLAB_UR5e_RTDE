% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 0: Basic Usage 3 -----
% This program demonstrates how to get the final joint angle position and
% pose at the target position
clear all;

% TCP Host and Port settings
% host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VIRTUAL BOX VM
host = '192.168.230.128'; % THIS IP ADDRESS MUST BE USED FOR THE VMWARE
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Setting up the target point
target = [-588.53, -300, 200, 2.2214, -2.2214, 0.00];

% Moving to target position
rtde.movel(target);

% Print out the joint angles at the target position.
% Returns in radians
rad2deg(rtde.actualJointPositions())

% Print out the pose at the target position. 
% Returns x,y,z in meters
rtde.actualPosePositions()



% Closing the TCP Connection
rtde.close();