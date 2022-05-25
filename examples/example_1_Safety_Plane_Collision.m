% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 1: Safety Plane Collision -----

% The following example shows that an error is thrown when the protective
% stop is engaged. You can look at the safetymode function in the rtde file
% to look at what all the safety modes are.

clear all;

% TCP Host and Port settings
host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VM
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];

% This following point is below the table. So asking the robot to move to
% this point should throw an error as the protective stop is engaged.
pointBelowTable = [-500, -300, -100, 2.22, -2.22, 0.00];

% Executing the movement. This should succeed
poses1 = rtde.movej(home);
poses2 = rtde.movej(pointBelowTable);
poses3 = rtde.movej(home);

% Combining both resultant pose lists
poses = [poses1;poses2;poses3];

% Plotting the path of the TCP
rtde.drawPath(poses)

% Closing the TCP Connection
rtde.close();


