% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 3: Simple Movec  -----
clear all;

% TCP Host and Port settings
host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VM
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
startPoint = [-588.53, -300, 350, 2.2214, -2.2214, 0.00];
via_point1 =  [-588.53, -400, 250, 2.2214, -2.2214, 0.00];
via_point2 =  [-688.53, -300, 250, 2.2214, -2.2214, 0.00];
via_point3 =  [-588.53, -200, 250, 2.2214, -2.2214, 0.00];
via_point4 =  [-488.53, -300, 250, 2.2214, -2.2214, 0.00];
target = [-588.53, -300, 150, 2.2214, -2.2214, 0.00];


% Questions/Exploration tasks:
% 1: Does the UR5e reach the target position properly? Yes/No Why?
% 2: What can we do to make it always reach the target position?
% 3: What are some other ways we can draw a sphere?
% 4: What happens when you change mode to be 1? Can you come up with a
% solution to draw a sphere while the mode is 1?

a = 1.2; % Tool Acceleration
v = 0.25; % Tool Velocity
r = 0.025; % Blend radius

% Tool Mode. 
% 0 = unconstrained (rotation angle of tool can change)
% 1 = Fixed ( rotation angle of tool will not change
mode = 2;


% Move to start point. The top of the circle
poses = rtde.movel(startPoint); 

% Move to bottom of the circle through via_point1
poses = cat(1,poses,rtde.movec(via_point1,target,'pose',a,v,r,mode)); 

% Move back to the top of the circle
poses = cat(1,poses,rtde.movel(startPoint));

% Move to bottom of the circle through via_point2
poses = cat(1,poses,rtde.movec(via_point2,target,'pose',a,v,r,mode));

% Move back to the top of the circle
poses = cat(1,poses,rtde.movel(startPoint));

% Move to bottom of the circle through via_point3
poses = cat(1,poses,rtde.movec(via_point3,target,'pose',a,v,r,mode));

% Move back to the top of the circle
poses = cat(1,poses,rtde.movel(startPoint));

% Move to bottom of the circle through via_point4
poses = cat(1,poses,rtde.movec(via_point4,target,'pose',a,v,r,mode));

% Plotting the path of the TCP
rtde.drawPath(poses);

% Closing the TCP Connection
rtde.close();

