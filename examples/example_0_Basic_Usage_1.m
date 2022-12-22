% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 0: Basic Usage 1 -----
% This program shows the basic useage of the rtde library.
clear all;

% TCP Host and Port settings
host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VM
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
% Notes these are [x,y,z,r,p,y]
% x,y,z are in mm, as URsim uses mm as well
% r,p,y are in radians

home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-500, -300, 200, 2.22, -2.22, 0.00];

% Executing the movement.

% movej
[poses1,jointPos1,jointVel1,jointAcc1,jointTor1] = rtde.movej(home);
% movel
[poses2,jointPos2,jointVel2,jointAcc2,jointTor2] = rtde.movel(point1);

% Lets move back home, but note that we aren't saving the movement
% information to variables
rtde.movel(home);


% You can combine all of the poses like this
poses = [poses1;poses2;];
% and plot the path of the TCP
rtde.drawPath(poses);

% Similarly combine all of the joint positions like this and plot it
joints = [jointPos1;jointPos2;];
rtde.drawJointPositions(joints)

% Combine all of the joint velocities and plot
velocities = [jointVel1;jointVel2;];
rtde.drawJointVelocities(velocities);

% Combine all of the joint accelerations and plot
accelerations = [jointAcc1;jointAcc2;];
rtde.drawJointAccelerations(accelerations);

% Combine all of the joint Torques and plot
torques = [jointTor1;jointTor2];
rtde.drawJointTorques(torques);

% % OR concatenate the poses using the following method
% poses = rtde.movej(home);
% poses = cat(1,poses,rtde.movel(point1));
% poses = cat(1,poses,rtde.movep(home));
% 
% % and plot them as follows
% rtde.drawPath(poses);


% Closing the TCP Connection
rtde.close();
