% Author: Raghav Hariharan
% For MTRN4230 2022

%% ----- EXAMPLE 6: Vacuum Gripper 2 -----
% A simple program combining the RTDE toolbox with the Vacuum gripper
% toolbox.
% NOTE: VACUUM GRIPPER SOFTWARE WILL NOT WORK USING THE VM. YOU MUST BE
% WORKING WITH THE REAL UR5e TO RUN THIS SOFTWARE

clc;
clear all;

host = '192.168.0.100';
rtdeport = 30003;
vacuumport = 63352;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,rtdeport);

% Calling the constructor of vacuum to setup tcp connction
vacuum = vacuum(host,vacuumport);

home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-588.53, -133.30, 150, 2.2214, -2.2214, 0.00];
point2 = [-688.53, -133.30, 400, 2.2214, -2.2214, 0.00];
point3 = [-688.53, -233.30, 400, 2.2214, -2.2214, 0.00];
point4 = [-588.53, -233.30, 400, 2.2214, -2.2214, 0.00];

drop =   [-588.53, -233.30, 400, 2.2214, -2.2214, 0.00];


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

% Turn on vacuum gripper
vacuum.grip()

% REMEMBER: You do not need to provide any a,v,t or r values at all if you wish to
% use the default values!
poses3 = rtde.movel(point2,'pose',a,v,t,r);

poses4 = rtde.movel(point3,'pose',a,v,t,r);

poses5 = rtde.movel(point4,'pose',a,v,t,r);

poses6 = rtde.movel(point1,'pose',a,v,t,r);

% Release Vacuum gripper
vacuum.release()

pause(0.2)

poses7 = rtde.movel(home);


% You can combine all of the poses like this
poses = [poses1;poses2;poses3;poses4;poses5;poses6;poses7;];
% and plot the path of the TCP
rtde.drawPath(poses);


% Closing the TCP Connection
rtde.close();