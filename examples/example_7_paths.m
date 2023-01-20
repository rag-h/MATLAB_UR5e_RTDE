% Author: Raghav Hariharan
% For MTRN4230 2023

%% ----- EXAMPLE 0: Basic Usage 1 -----
% This program shows the basic useage of the rtde library.
clear all;
% 
% TCP Host and Port settings
host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VM
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 30003;


% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];


velocity = 0.1;
acceleration = 1.2;
blend_1 = 0.00;
blend_2 = 0.01;
blend_3 = 0.01;
blend_4 = 0.01;


path_pose1 = [[-588.53, -133.30, 200, 2.2214, -2.2214, 0.00],acceleration, velocity,0, blend_1];
path_pose2 = [[-688.53, -133.30, 200, 2.2214, -2.2214, 0.00],acceleration, velocity,0, blend_2];
path_pose3 = [[-688.53, -233.30, 200, 2.2214, -2.2214, 0.00],acceleration, velocity,0, blend_3];
path_pose4 = [[-588.53, -233.30, 200, 2.2214, -2.2214, 0.00],acceleration, velocity,0, blend_4];

path = [path_pose1; path_pose2; path_pose3; path_pose4; path_pose1];




poses3 = rtde.movej(home,'pose',acceleration,velocity,0,0.0);
poses = rtde.movep(path);

rtde.drawPath(poses)





