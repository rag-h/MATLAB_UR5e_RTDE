%% ----- MOVEJ -----
clear all;

% TCP Host and Port settings
host = '127.0.0.1';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);


% Definition: movej(target,a,v,t,r)
% Move to position (linear in joint-space)
% When using this command, the robot must be at a standstill or come
% from a movej or movel with a blend. The speed and acceleration
% parameters control the trapezoid speed profile of the move.
% Alternatively, the t parameter can be used to set the time for this
% move. Time setting has priority over speed and acceleration settings
% PARAMETERS:
% *target*: Joint positions or pose. If pose is given then inverse kinematics
% is used to calculate the corresponding joint positions
% *a* = joint acceleration of the leading axis (default = 1.4)
% *v* = joint speed of the leading axis (default = 1.05)
% *t* = time (s) (default = 0). If it were specified the command would ignore
% the a and v values
% *r* = blend radius (m) (default = 0). If blend radius is set, the robot arm trajectory
% will be modified to avoid the robot stopping at the point


% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
point1 = [-588.53, -133.30, 150, 2.2214, -2.2214, 0.00];
point2 = [-688.53, -133.30, 150, 2.2214, -2.2214, 0.00];
point3 = [-688.53, -233.30, 150, 2.2214, -2.2214, 0.00];
point4 = [-588.53, -233.30, 150, 2.2214, -2.2214, 0.00];

% Play around with these values and see what you observe!
% What happens when you set a large/small r value?
% What happens when you set a t value?
% What happens when acceleration is large but the velocity is small?
% What happens when the velocity is large but the acceleration is small?

a = 1.0;
v = 0.5;
r = 0;

% Remember when you set t, it will have priority over the a and v
% parameters that you have set!
t = 0;

% movej can be called just by providing only the target pose

poses1 = rtde.movej(home);

% You can also pass in values for accleration, velocity
poses2 = rtde.movej(point1,'pose',a,v,t,r);

% REMEMBER: You do not need to provide any a,v,t or r values at all if you wish to
% use the default values!
poses3 = rtde.movej(point2,'pose',a,v,t,r);

poses4 = rtde.movej(point3,'pose',a,v,t,r);

poses5 = rtde.movej(point4,'pose',a,v,t,r);

poses6 = rtde.movej(point1,'pose',a,v,t,r);

poses7 = rtde.movej(home);


% You can combine all of the poses like this
poses = [poses1;poses2;poses3;poses4;poses5;poses6;poses7;];
% and plot the path of the TCP
rtde.drawPath(poses);


% Closing the TCP Connection
rtde.close();