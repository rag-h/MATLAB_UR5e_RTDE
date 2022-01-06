clear all;

% TCP Host and Port settings
host = '192.168.1.187';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-500, -300, 700, 2.22, -2.22, 0.00];

% Executing the movement
poses1 = rtde.move('j',home);
poses2 = rtde.move('j',point1);
poses3 = rtde.move('j',home);

% Combining both resultant pose lists
poses = [poses1;poses2;poses3];

% Plotting the path of the TCP
rtde.drawPath(poses)

% Closing the TCP Connection
rtde.close();



