
% Author: Raghav Hariharan
% For MTRN4230 2023

%% ----- EXAMPLE 7: Drawing Letters -----
% Example of drawing a letter/digit from the rvc toolbox hershey library
clear all;

startup_rvc; % Startup the rvc toolbox

load hershey; % Load in the hershey fonts

character = hershey{'B'}; % Select the letter that you want to draw (Letter or number works)
scale = 0.1; % Select the scale of the digit. 1 = 100%, 0.1 = 10% scale

path = [scale*character.stroke; zeros(1,numcols(character.stroke))]; % create the path 


% Where ever there is an nan it indicates that we need to lift up.
k = find(isnan(path(1,:)));

% At these positions add in a z hight
path(:,k) = path(:,k-1); path(3,k) = 0.2*scale; % Determine the hight of the lift up motions. 0.2 * scale is the height. 0.2 is in m

traj = [path'*1000]; % convert to the mm units so that we can use the rtde toolbox

% Generate a plot of what we are expecting
scatter3(traj(:,1), traj(:,2), traj(:,3));
plot3(traj(:,1), traj(:,2), traj(:,3));



%% NOW USE THE RTDE TOOLBOX TO EXECUTE THIS PATH!


% % TCP Host and Port settings
% host = '127.0.0.1'; % THIS IP ADDRESS MUST BE USED FOR THE VIRTUAL BOX VM
host = '192.168.230.128'; % THIS IP ADDRESS MUST BE USED FOR THE VMWARE
% host = '192.168.0.100'; % THIS IP ADDRESS MUST BE USED FOR THE REAL ROBOT
port = 30003;
% 

% Calling the constructor of rtde to setup tcp connction
rtde = rtde(host,port);

% Setting home
home = [-588.53, -133.30, 371.91, 2.2214, -2.2214, 0.00];


poses = rtde.movej(home);
% Creating a path array
path = [];

% setting move parameters
v = 0.5;
a = 1.2;
blend = 0.005;

% Populate the path array
for i = 1:length(traj)
    disp(i);
    disp(traj(i,1:3) + [-588.53, -133.30 100]);
    point = [[(traj(i,1:3) + [-588.53, -133.30 30]),(home(4:6))],a,v,0,blend];
    if isempty(path)
        path = point;
    else
        path = cat(1,path,point);
    end
end

% Execute the movement!
poses = rtde.movej(path);

rtde.drawPath(poses);

rtde.close;