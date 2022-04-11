%% ----- EXAMPLE 0: Basic Usage -----
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

% Executing the movement.
% movej
[poses1,joints1,jointVelocity1,a1,t1] = rtde.movej(home);
% movel
[poses2,joints2,jointVelocity2,a2,t2] = rtde.movej(point1);
% movep
% [poses3,joints3,jointVelocity3,a3] = rtde.movel(home);
rtde.movel(home);
% You can combine all of the poses like this
poses = [poses1;poses2;];
% and plot the path of the TCP
rtde.drawPath(poses);

% Similarly combine all of the joint positions like this and plot it
joints = [joints1;joints2;];
rtde.drawJointPositions(joints)

velocities = [jointVelocity1;jointVelocity2;];
rtde.drawJointVelocities(velocities);

accelerations = [a1;a2;];

rtde.drawJointAccelerations(accelerations);


torques = [t1;t2];
rtde.drawJointTorques(torques);

% % OR concatenate the poses using the following method
% poses = rtde.movej(home);
% poses = cat(1,poses,rtde.movel(point1));
% poses = cat(1,poses,rtde.movep(home));
% % and plot them as follows
% rtde.drawPath(poses);


% Closing the TCP Connection
rtde.close();
