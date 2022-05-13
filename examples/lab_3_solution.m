% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- Tutorial 3 Solution  -----
% A for loop and a rotz command is used to automate the calculation on way
% points to generate a sphere
% Things to look at for students:
% Why doesn't the movec comman take the sphere directly to the target
% point. The tolerance of the movec command isn't as accurate as the
% movej/l commands.
% 
clear all;
% Import Peter Corkes RVC Toolbox
startup_rvc;

% TCP Host and Port settings
host = '127.0.0.1';
% host = '192.168.0.100';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
startPoint = [-588.53, -300, 400, 2.2214, -2.2214, 0.00];
target = [-588.53, -300, 200, 2.2214, -2.2214, 0.00];


a=1.2;
v=0.25;
r=0.025;
mode=2;

p1 = [-588.53, -400,  300];

% Move to start position and initialise variables
[poses,jointPos,jointVelocities,jointAccelerations,torques] = rtde.movel(startPoint);


% Creating a for loop
for i = 1:22.5:360

    p = (p1-startPoint(1:3))*rotz(i,'deg')+startPoint(1:3);


    [pose,joint,jointVelocity,jointAcceleration,torque] = rtde.movec([p,2.2214, -2.2214, 0.00],target,'pose',a,v,r,mode);
    
    % Contatenating the variable returned to the appropriate lists
    poses = cat(1,poses,pose);
    jointPos = cat(1,jointPos,joint);
    torques = cat(1,torques,torque);
    jointVelocities = cat(1,jointVelocities,jointVelocity);
    jointAccelerations = cat(1,jointAccelerations,jointAcceleration);

    % Nudge the tool to the target position
    [pose,joint,jointVelocity,jointAcceleration,torque] = rtde.movej(target);
    % Contatenating the variable returned to the appropriate lists
    poses = cat(1,poses,pose);
    jointPos = cat(1,jointPos,joint);
    torques = cat(1,torques,torque);
    jointVelocities = cat(1,jointVelocities,jointVelocity);
    jointAccelerations = cat(1,jointAccelerations,jointAcceleration);

    % Move tool back to the start position
    [pose,joint,jointVelocity,jointAcceleration,torque] = rtde.movel(startPoint);
    % Contatenating the variable returned to the appropriate lists
    poses = cat(1,poses,pose);
    jointPos = cat(1,jointPos,joint);
    torques = cat(1,torques,torque);
    jointVelocities = cat(1,jointVelocities,jointVelocity);
    jointAccelerations = cat(1,jointAccelerations,jointAcceleration);
end


% Plotting
rtde.drawJointPositions(jointPos);
rtde.drawJointAccelerations(jointAccelerations);
rtde.drawJointVelocities(jointVelocities);
rtde.drawJointTorques(torques);
rtde.drawPath(poses);

% Closing the TCP Connection
rtde.close();

