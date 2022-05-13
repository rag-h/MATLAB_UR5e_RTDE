% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 0: Basic Usage 2 -----
clear all;

% TCP Host and Port settings
host = '127.0.0.1';
% host = '192.168.0.100';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);


% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-500, -300, 200, 2.22, -2.22, 0.00];

% You can use the ~ to ignore variables that you do not want.
% Performing the movements
[~,jointPos1,~,jointAcc1] = rtde.movej(home);

[~,jointPos2,~,jointAcc2] = rtde.movej(point1);

% Ploting the joint positions
joints = [jointPos1;jointPos2;];
rtde.drawJointPositions(joints)

% Ploting the joint accelerations
accelerations = [jointAcc1;jointAcc2;];
rtde.drawJointAccelerations(accelerations);


% Closing the TCP Connection
rtde.close();