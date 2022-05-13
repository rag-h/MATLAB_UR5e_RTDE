% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 2: Draw a simple square -----
clear all;

% TCP Host and Port settings
host = '127.0.0.1';
% host = '192.168.0.100';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
% Poses
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-588.53, -133.30, 200, 2.2214, -2.2214, 0.00];
point2 = [-688.53, -133.30, 200, 2.2214, -2.2214, 0.00];
point3 = [-688.53, -233.30, 200, 2.2214, -2.2214, 0.00];
point4 = [-588.53, -233.30, 200, 2.2214, -2.2214, 0.00];


% Executing the movement. 
% How does the movement look when you use movel instead?
[poses1,joints1] = rtde.movej(home);
[poses2,joints2]  = rtde.movej(point1);
[poses3,joints3]  = rtde.movej(point2);
[poses4,joints4]  = rtde.movej(point3);
[poses5,joints5]  = rtde.movej(point4);

[poses6,joints6] = rtde.movej(point1);

                %% ----- %%        
% The following is an example using joint positions instead of poses.
% Joint Positions
% home = [-2.69606900000000	-1.83257300000000	-1.57086200000000	-1.30890000000000	1.57081700000000	-2.69599800000000];
% point1 = [-2.69611900000000	-2.01735600000000	-1.80293400000000	-0.892044000000000	1.57081600000000	-2.69611900000000];
% point2 = [-2.75911500000000	-2.21060700000000	-1.47753600000000	-1.02419200000000	1.57081900000000	-2.75911500000000];
% point3 = [-2.63049400000000	-2.26435200000000	-1.38215900000000	-1.06582200000000	1.57081200000000	-2.63049400000000];
% point4 = [-2.55204200000000	-2.07477000000000	-1.70951400000000	-0.928048000000000	1.57080800000000	-2.55204200000000];

% Executing the movement. 
% How does the movement look when you use movel instead?
% [poses1,joints1] = rtde.movej(home,'joint');
% [poses2,joints2]  = rtde.movej(point1,'joint');
% [poses3,joints3]  = rtde.movej(point2, 'joint');
% [poses4,joints4]  = rtde.movej(point3, 'joint');
% [poses5,joints5]  = rtde.movej(point4, 'joint');
% 
% [poses6,joints6] = rtde.movej(point1, 'joint');

                %% ----- %%

% Combining both resultant pose lists
poses = [poses1;poses2;poses3;poses4;poses5;poses6];

% Plotting the path of the TCP
rtde.drawPath(poses)

% Closing the TCP Connection
rtde.close();