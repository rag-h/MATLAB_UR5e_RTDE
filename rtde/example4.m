%% ----- EXAMPLE 4: Simple Movec  -----
clear all;
% Import Peter Corkes RVC Toolbox
startup_rvc;

% TCP Host and Port settings
host = '127.0.0.1';
port = 30003;

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Defining points
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];
startPoint = [-588.53, -300, 350, 2.2214, -2.2214, 0.00];
via_point1 =  [-588.53, -400, 250, 2.2214, -2.2214, 0.00];
via_point2 =  [-688.53, -300, 250, 2.2214, -2.2214, 0.00];
via_point3 =  [-588.53, -200, 250, 2.2214, -2.2214, 0.00];
via_point4 =  [-488.53, -300, 250, 2.2214, -2.2214, 0.00];
target = [-588.53, -300, 150, 2.2214, -2.2214, 0.00];



a=1.2;
v=0.25;
r=0.025;
mode=2;

p1 = [-588.53, -400,  250]
poses = rtde.movel(startPoint);
hold on;
for i = 1:10:360
    p = (p1-startPoint(1:3))*rotz(i,'deg')+startPoint(1:3);
%     plot_point((p'*0.001), 'label', ' p', 'solid', 'ko')
    poses = cat(1,poses,rtde.movec([p,2.2214, -2.2214, 0.00],target,a,v,r,mode));
    poses = cat(1,poses,rtde.movej(target));
    rtde.movel(startPoint);
end

% poses = rtde.movel(startPoint);
% 
% poses = cat(1,poses,rtde.movec(via_point1,target,a,v,r,mode));
% 
% poses = cat(1,poses,rtde.movec(via_point2,startPoint,a,v,r,mode));
% 
% poses = cat(1,poses,rtde.movec(via_point3,target,a,v,r,mode));
% 
% poses = cat(1,poses,rtde.movec(via_point4,startPoint,a,v,r,mode));


% Plotting the path of the TCP
rtde.drawPath(round(poses,3));

% Closing the TCP Connection
rtde.close();

