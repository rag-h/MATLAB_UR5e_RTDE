%% ----- EXAMPLE 1 -----
clear all;

% TCP Host and Port settings
host = '127.0.0.1';
% host = '192.168.0.100';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-588.53, -133.30, 200, 2.2214, -2.2214, 0.00];
point2 = [-688.53, -133.30, 200, 2.2214, -2.2214, 0.00];
point3 = [-688.53, -233.30, 200, 2.2214, -2.2214, 0.00];
point4 = [-588.53, -233.30, 200, 2.2214, -2.2214, 0.00];

% Executing the movement. 
% How does the movement look when you use movel instead?
poses1 = rtde.movej(home);

poses2 = rtde.movej(point1);
poses3 = rtde.movej(point2);
poses4 = rtde.movej(point3);
poses5 = rtde.movej(point4);

poses6 = rtde.movej(point1);

% Combining both resultant pose lists
poses = [poses1;poses2;poses3;poses4;poses5;poses6];


% Plotting the path of the TCP
rtde.drawPath(poses)

% Closing the TCP Connection
rtde.close();