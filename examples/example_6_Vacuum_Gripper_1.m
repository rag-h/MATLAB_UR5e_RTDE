% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 6: Vacuum Gripper 1 -----
% A very simple example showing how to instantiate the vacuum gripper, and
% call its grip and release functions. 
% NOTE: VACUUM GRIPPER SOFTWARE WILL NOT WORK USING THE VM. YOU MUST BE
% WORKING WITH THE REAL UR5e TO RUN THIS SOFTWARE


clc;
clear all;

% TCP Host and Port settings
host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VM
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 63352;

% Calling the constructor of the vacuum gripper class 
vacuum = vacuum(host,port);

% The vacuum gripper has 2 functions, grip and release
% Call the following to grip
vacuum.grip()

disp("Grip")

% You need to give it some time to apply the suction force
pause(5)

% Release

vacuum.release()

disp("Release")

% Closing the TCP Connection
vacuum.close()