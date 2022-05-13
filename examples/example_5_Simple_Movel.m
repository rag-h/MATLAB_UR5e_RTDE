% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- Example 5: Simple MOVEL -----
clear all;

% TCP Host and Port settings
host = '127.0.0.1';
% host = '192.168.0.100';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);


% Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movel(target,jointOrPose,a,v,t,r)
% Move to position (linear in tool-space)
% PARAMETERS:
% *target*: Target pose (pose can also be specified as joint positions, then forward
% kinematics is used to calculate the corresponding pose)
% *a* = joint acceleration of the leading axis (default = 1.2)
% *jointOrPose*= "joint" or "pose" to provide joint inputs or pose
% inputs
% *v* = joint speed of the leading axis (default = 0.25)
% *t* = time (s) (default = 0). If it were specified the command would ignore
% the a and v values
% *r* = blend radius (m) (default = 0). If blend radius is set, the robot arm trajectory
% will be modified to avoid the robot stopping at the point

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-588.53, -133.30, 200, 2.2214, -2.2214, 0.00];
point2 = [-688.53, -133.30, 200, 2.2214, -2.2214, 0.00];
point3 = [-688.53, -233.30, 200, 2.2214, -2.2214, 0.00];
point4 = [-588.53, -233.30, 200, 2.2214, -2.2214, 0.00];

% Joint Positions
% home = [-2.69606900000000	-1.83257300000000	-1.57086200000000	-1.30890000000000	1.57081700000000	-2.69599800000000];
% point1 = [-2.69611900000000	-2.01735600000000	-1.80293400000000	-0.892044000000000	1.57081600000000	-2.69611900000000];
% point2 = [-2.75911500000000	-2.21060700000000	-1.47753600000000	-1.02419200000000	1.57081900000000	-2.75911500000000];
% point3 = [-2.63049400000000	-2.26435200000000	-1.38215900000000	-1.06582200000000	1.57081200000000	-2.63049400000000];
% point4 = [-2.55204200000000	-2.07477000000000	-1.70951400000000	-0.928048000000000	1.57080800000000	-2.55204200000000];


% Play around with these values and see what you observe!
% What happens when you set a large/small r value?
% What happens when you set a t value?
% What happens when acceleration is large but the velocity is small?
% What happens when the velocity is large but the acceleration is small?

a = 1.0;
v = 0.1;
r = 0;

% Remember when you set t, it will have priority over the a and v
% parameters that you have set!
t = 0;

% movej can be called just by providing only the target pose

poses1 = rtde.movel(home);

% You can also pass in values for accleration, velocity
poses2 = rtde.movel(point1,'pose',a,v,t,r);

% REMEMBER: You do not need to provide any a,v,t or r values at all if you wish to
% use the default values!
poses3 = rtde.movel(point2,'pose',a,v,t,r);

poses4 = rtde.movel(point3,'pose',a,v,t,r);

poses5 = rtde.movel(point4,'pose',a,v,t,r);

poses6 = rtde.movel(point1,'pose',a,v,t,r);

poses7 = rtde.movel(home);


% You can combine all of the poses like this
poses = [poses1;poses2;poses3;poses4;poses5;poses6;poses7;];
% and plot the path of the TCP
rtde.drawPath(poses);


% Closing the TCP Connection
rtde.close();