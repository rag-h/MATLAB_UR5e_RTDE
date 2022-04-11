% Author: Raghav Hariharan
% A very simple example showing how to instantiate the vacuum gripper, and
% call its grip and release functions. 


clc;
clear all;

host = '192.168.0.100';
port = 63352;

vacuum = vacuum(host,port);

vacuum.grip()
disp("Grip")

pause(5)

vacuum.release()
disp("Release")

vacuum.close()