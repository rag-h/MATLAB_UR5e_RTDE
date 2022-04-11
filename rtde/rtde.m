% https://s3-eu-west-1.amazonaws.com/ur-support-site/32554/scriptManual-3.5.4.pdf
% https://s3-eu-west-1.amazonaws.com/ur-support-site/16496/ClientInterfaces_Realtime.pdf#%5B%7B%22num%22%3A20%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C57%2C542.78%2C0%5D
classdef rtde
    properties
        % Socket contains all tcp connection related stuff
        socket
        % frequency at which data is read. Default is 0.01 (100hz)
        frequency
    end
    methods
        % Constructor to establish TCP connection with the ur5e
        function obj = rtde(host,port)

            obj.frequency = 0.01;
            obj.host = host;
            obj.port = port;
 
            obj.socket = tcpip(host, port);

            obj.socket.InputBufferSize = 1220;
            obj.socket.OutputBufferSize = 3000;
            
            fopen(obj.socket);

            disp('UR5e connection Established!');
        end

        % Close Socket
        function close(obj)
            fclose(obj.socket);
            delete(obj.socket);
            clear obj.socket;

            disp("Socket Disconnected!")
        end
        
        % Function call for move c
        % Definition [poses,joints,jointVelocities,jointAccelerations,torques] = movec(via_point,pose_to,jointOrPose,a,v,r,mode)
        % Circular Move: Move to position (circular in tool-space)
        % TCP moves on the circular arc segment from current pose, through
        % pose_via to pose_to. Accelerates to and moves with constant tool
        % speed v. Use the mode parameter to define the orientation
        % interpolation.
        % PARAMETERS:

        % *pose_via* = path point (note: only position is used). Pose_via
        % can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose.
        
        % *pose_to* = arget pose (note: only position is used in Fixed orientation mode). Pose_to can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose.
        
        % *jointOrPose*= "joint" or "pose" to provide joint inputs or pose
        % inputs

        % *a* = tool acceleration (m/s^2) (default = 1.2)

        % *v* = tool speed (m/s) (default = 0.25)

        % *r* = blend radius (of target pose) (m) (default = 0.05)

        % *mode* = 0: Unconstrained mode. Interpolate orientation from current pose to target pose (pose_to) 

        % 1: Fixed mode. Keep orientation constant relative to the tangent of the circular arc(starting from current pose)
        % (mode default = 1)
        function [poses,joints,jointVelocities,jointAccelerations,torques] = movec(obj,via_point,pose_to,jointOrPose,a,v,r,mode)
            % Setting defaults if the following variables do not exist
            if ~exist('jointOrPose','var')
                jointOrPose = "pose";
            end            
            if ~exist('a','var')
                a = 1.2;
            end
            if ~exist('v','var')
                v = 0.25;
            end
            if ~exist('r','var')
                r = 0.025;
            end
            if ~exist('mode','var')
                mode = 1;
            end

            [poses,joints,jointVelocities,jointAccelerations,torques] = move(obj,'c',pose_to,via_point,jointOrPose,a,v,r,0,mode);
            
        end

        % Function call for move j
        % Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movej(target,jointOrPose,a,v,t,r)
        % Move to position (linear in joint-space)
        % When using this command, the robot must be at a standstill or come
        % from a movej or movel with a blend. The speed and acceleration
        % parameters control the trapezoid speed profile of the move.
        % Alternatively, the t parameter can be used to set the time for this
        % move. Time setting has priority over speed and acceleration settings
        % PARAMETERS:
        % *target*: Joint positions or pose. If pose is given then inverse kinematics
        % is used to calculate the corresponding joint positions
        % *jointOrPose*= "joint" or "pose" to provide joint inputs or pose
        % inputs
        % *a* = joint acceleration of the leading axis (default = 1.4)
        % *v* = joint speed of the leading axis (default = 1.05)
        % *t* = time (s) (default = 0). If it were specified the command would ignore
        % the a and v values
        % *r* = blend radius (m) (default = 0). If blend radius is set, the robot arm trajectory
        % will be modified to avoid the robot stopping at the point
        
        function [poses,joints,jointVelocities,jointAccelerations,torques] = movej(obj,target,jointOrPose,a,v,t,r)
            % Setting defaults if the following variables do not exist
            if ~exist('jointOrPose','var')
                jointOrPose = "pose";
            end
            if ~exist('a','var')
                a = 1.4;
            end
            if ~exist('v','var')
                v = 1.05;
            end
            if ~exist('t','var')
                t = 0;
            end
            if ~exist('r','var')
                r = 0;
            end

            [poses,joints,jointVelocities,jointAccelerations,torques] = move(obj,'j',target,[],jointOrPose,a,v,r,t);
        end
        
        % Function call for movel
        % Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movel(target,a,v,t,r)
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

        function [poses,joints,jointVelocities,jointAccelerations,torques] = movel(obj,target,jointOrPose,a,v,t,r)
            % Setting defaults if the following variables do not exist
            if ~exist('jointOrPose','var')
                jointOrPose = "pose";
            end
            if ~exist('a','var')
                 a = 1.2;
            end
            if ~exist('v','var')
                v = 0.25;
            end
            if ~exist('t','var')
                 t = 0;
            end
            if ~exist('r','var')
                 r = 0;
            end

            [poses,joints,jointVelocities,jointAccelerations,torques] = move(obj,'l',target,[],jointOrPose,a,v,r,t);
        end

        % Function call for move p
        % Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movep(obj,target,jointOrPose,a,v,r)
        % Move Process
        % Blend circular (in tool-space) and move linear (in tool-space) to position. Accelerates to and moves with constant tool speed v.
        % PARAMETERS
        % *target* = target pose (pose can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose)
        % *a* = tool acceleration (m/s^2) (default = 1.2)
        % *v* = tool speed (m/s) (default = 0.25
        % *r* = blend radius (m) (default = 0)
        function [poses,joints,jointVelocities,jointAccelerations,torques] = movep(obj,target,jointOrPose,a,v,r)
            % Setting defaults if the following variables do not exist
            if ~exist('jointOrPose','var')
                jointOrPose = "pose";
            end
            if ~exist('a','var')
                 a = 1.2;
            end
            if ~exist('v','var')
                v = 0.25;
            end
            if ~exist('r','var')
                 r = 0;
            end

            [poses,joints,jointVelocities,jointAccelerations,torques] = move(obj,'p',target,[],jointOrPose,a,v,r);
        end

        % Following function returns the list of poses that the robot followed to
        % get from pose A to pose B. This function will be called by
        % movec, movej, movel or movep functions. It is not intended to
        % call this function directly.
        function [poses,jointPositions,jointVelocities,jointAccelerations,torques] = move(obj,type,target,via_point,jointOrPose,a,v,r,t,mode)
        
            flushinput(obj.socket)
            flushoutput(obj.socket)
        
           tolerance = [0.0001,0.0001,0.0001,0.001,0.001,0.001];
            
            if(jointOrPose == "joint")
                if (type == "c")
                    tolerance = [0.03,0.03,0.03,5,5,5];
                    % Converting pose to string
                    via_point(1:3) = via_point(1:3) * 0.001; % Converting to meter
                    target_char = ['move', type ,'([',num2str(via_point(1)),',',...
                        num2str(via_point(2)),',',...
                        num2str(via_point(3)),',',...
                        num2str(via_point(4)),',',...
                        num2str(via_point(5)),',',...
                        num2str(via_point(6)),...
                        '],p[',num2str(target(1)),',',...
                        num2str(target(2)),',',...
                        num2str(target(3)),',',...
                        num2str(target(4)),',',...
                        num2str(target(5)),',',...
                        num2str(target(6)),...
                        '],a=' num2str(a) ', v=' num2str(v) ', r=' num2str(r) ',mode=' num2str(mode) ')\n'];
                elseif (type == "p")
                    target_char = ['move', type ,'([',num2str(target(1)),',',...
                        num2str(target(2)),',',...
                        num2str(target(3)),',',...
                        num2str(target(4)),',',...
                        num2str(target(5)),',',...
                        num2str(target(6)),...
                        '],a=' num2str(a) ', v=' num2str(v) ',r=' num2str(r) ')\n'];
                else
                    if(r ~= 0)
                    tolerance(1:3) = r;
                    end
                    % Converting pose to string
                    target_char = ['move', type ,'([',num2str(target(1)),',',...
                        num2str(target(2)),',',...
                        num2str(target(3)),',',...
                        num2str(target(4)),',',...
                        num2str(target(5)),',',...
                        num2str(target(6)),...
                        '],a=' num2str(a) ', v=' num2str(v) ', t=' num2str(t) ',r=' num2str(r) ')\n']
                end
            else
                target(1:3) = target(1:3) * 0.001; % Converting to meter
                if (type == "c")

                    tolerance = [0.03,0.03,0.03,5,5,5];

                    % Converting pose to string
                    via_point(1:3) = via_point(1:3) * 0.001; % Converting to meter
                    target_char = ['move', type ,'(p[',num2str(via_point(1)),',',...
                        num2str(via_point(2)),',',...
                        num2str(via_point(3)),',',...
                        num2str(via_point(4)),',',...
                        num2str(via_point(5)),',',...
                        num2str(via_point(6)),...
                        '],p[',num2str(target(1)),',',...
                        num2str(target(2)),',',...
                        num2str(target(3)),',',...
                        num2str(target(4)),',',...
                        num2str(target(5)),',',...
                        num2str(target(6)),...
                        '],a=' num2str(a) ', v=' num2str(v) ', r=' num2str(r) ',mode=' num2str(mode) ')\n'];
                elseif (type == "p")
                    target_char = ['move', type ,'(p[',num2str(target(1)),',',...
                        num2str(target(2)),',',...
                        num2str(target(3)),',',...
                        num2str(target(4)),',',...
                        num2str(target(5)),',',...
                        num2str(target(6)),...
                        '],a=' num2str(a) ', v=' num2str(v) ',r=' num2str(r) ')\n'];
                else
                    if(r ~= 0)
                    tolerance(1:3) = r;
                    end
                    % Converting pose to string
                    target_char = ['move', type ,'(p[',num2str(target(1)),',',...
                        num2str(target(2)),',',...
                        num2str(target(3)),',',...
                        num2str(target(4)),',',...
                        num2str(target(5)),',',...
                        num2str(target(6)),...
                        '],a=' num2str(a) ', v=' num2str(v) ', t=' num2str(t) ',r=' num2str(r) ')\n'];
                end
            end
        
            % Sending the command through as bytes
            fprintf(obj.socket,target_char);
            % Pause for a short interval to allow the command to be received 
            pause(0.3);
                        
            % Determining whether or not the arm has reached the target position
            % Poses(end,:) = current pose of the arm
            % target = target pose of the arm
            % poses(end,:) - target should be 0 if the robot arm has reached the
            % target
            % We set a tolerance value as the robotic arm's motions in the real
            % world is not perfect. In the sim is is perfect though

            if(jointOrPose == "joint")
                function_to_call = @actualJointPositions;   
                goal = actualJointPositions(obj);
            else
                function_to_call = @toolVectorActual; 
                goal = toolVectorActual(obj);
            end

            time0 = tic;
            timeLimit = 30; % 30 seconds

            % Appending the inital position of the arm to an array
            poses = toolVectorActual(obj);
            jointPositions = actualJointPositions(obj);
            jointVelocities = actualJointVelocities(obj);
            jointAccelerations = targetJointAccelerations(obj);
            torques = targetJointTorques(obj);

            while any(abs(goal(end,:) - target) > tolerance,'all') 
                goal(end+1,:) = function_to_call(obj); 

                if(jointOrPose == "joint") % This means goal is already recording the joints. So record poses instead  
                    poses(end+1,:) = toolVectorActual(obj);
                else % This means goal is already recording the poses. So record joints instead 
                    jointPositions(end+1,:) = actualJointPositions(obj);    
                end

                jointVelocities(end+1,:) = actualJointVelocities(obj);
                jointAccelerations(end+1,:) = targetJointAccelerations(obj);
                torques(end+1,:) = targetJointTorques(obj);

                checkSafetyMode(obj);
                pause(obj.frequency);

                if toc(time0) > timeLimit
                    if(jointOrPose == "joint")  
                        jointPositions = goal;
                    else 
                        poses = goal;
                    end
                    disp("Time out. Something probably went wrong.!");
                    return;
                end
            end

            if(jointOrPose == "joint")  
                jointPositions = goal;
            else 
                poses = goal;
            end
            disp("Succeeded!")
        end
        

        % Target must be 
        function joint_positions = servoj(obj,target_joint_positions,t,lookahead_time,gain)
            % Setting defaults if the following variables do not exist
            if ~exist('t','var')
                 t = 0.008;
            end

            if ~exist('lookahead_time','var')
                 lookahead_time = 0.1;
            end

            if ~exist('gain','var')
                 gain = 300;
            end

            tolerance = [0.05,0.05,0.05,0.05,0.05,0.05];

            target_char = ['servoj','([',num2str(target_joint_positions(1)),',',...
                    num2str(target_joint_positions(2)),',',...
                    num2str(target_joint_positions(3)),',',...
                    num2str(target_joint_positions(4)),',',...
                    num2str(target_joint_positions(5)),',',...
                    num2str(target_joint_positions(6)),...
                    '],0,0,' num2str(t) ',' num2str(lookahead_time) ',' num2str(gain) ')\n'];

            % Sending the command through as bytes
            fprintf(obj.socket,target_char);
            % Pause for a short interval to allow the command to be received 
            pause(0.3);

            time0 = tic;
            timeLimit = 30; % 10 seconds
            
            joint_positions = actualJointPositions(obj);

            while any(abs(joint_positions(end,:) - target_joint_positions) > tolerance,'all') 
                joint_positions(end+1,:) = actualJointPositions(obj);           
                checkSafetyMode(obj);
                pause(obj.frequency);

%                 poses(end,:)
%                 target_joint_positions
%                 abs(poses(end,:) - target_joint_positions)
%                 tolerance

                if toc(time0)>timeLimit
                    disp("Failed!");
                    return;
                end
             end 
            disp("Succeeded!")


        end

        
        % ROBOT MODE
        % RETURN VALUES:
        %-1 : ROBOT_MODE_NO_CONTROLLE
        % 0 : ROBOT_MODE_DISCONNECTED
        % 1 : ROBOT_MODE_CONFIRM_SAFETY
        % 2 : ROBOT_MODE_BOOTING
        % 3 : ROBOT_MODE_POWER_OF
        % 4 : ROBOT_MODE_POWER_ON
        % 5 : ROBOT_MODE_IDLE
        % 6 : ROBOT_MODE_BACKDRIVE
        % 7 : ROBOT_MODE_RUNNING
        % 8 : ROBOT_MODE_UPDATING_FIRMWARE
        function robotMode = checkRobotMode(obj)
          
            while obj.socket.BytesAvailable==0
                %t.BytesAvailable
            end
            rec = fread(obj.socket,obj.socket.BytesAvailable);
            
            % Following is the offset in the message to retrieve the robot_mode
            val = 4 + 8 + 48 + 48 + 48 + 48 + 48+ 48 + 48 + 48 + 48 + 48 + 48 + 48 + 48 +48 + 8 + 48 + 8 + 8;
            data  = [rec(val+1:val+8)];
            result = swapbytes(typecast(uint8(data),'double'));
            robotMode = round(result,6);
                
        end

        % SAFETY MODE
        % RETURN VALUES:
        % 1 : SAFETY_MODE_NORMAL
        % 2 : SAFETY_MODE_REDUCED
        % 3 : SAFETY_MODE_PROTECTIVE_STOP
        % 4 : SAFETY_MODE_RECOVERY
        % 5 : SAFETY_MODE_SAFEGUARD_STOP
        % 6 : SAFETY_MODE_SYSTEM_EMERGENCY_STOP
        % 7 : SAFETY_MODE_ROBOT_EMERGENCY_STOP
        % 8 : SAFETY_MODE_VIOLATION
        % 9 : SAFETY_MODE_FAULT
        % 10 : SAFETY_MODE_VALIDATE_JOINT_ID
        % 11 : SAFETY_MODE_UNDEFINED_SAFETY_MODE

        function safetyMode = checkSafetyMode(obj)
          
            while obj.socket.BytesAvailable==0
                %t.BytesAvailable
            end
            rec = fread(obj.socket,obj.socket.BytesAvailable);
            
            % Following is the offset in the message to retrieve the robot_mode
            val = 4 + 8 + 48 + 48 + 48 + 48 + 48+ 48 + 48 + 48 + 48 + 48 +48 + 48 + 48 +48 + 8 + 48 + 8 + 8 + 8 + 48;
            data  = [rec(val+1:val+8)];
            result = swapbytes(typecast(uint8(data),'double'));
            safetyMode = round(result,6);
            
            if safetyMode == 1 || safetyMode == 2
                return
            end

            errID = 'rtde:safetyError';
            switch safetyMode
                case 3
                    msgtext = 'Safety Mode Protective Stop.';
                case 4
                    msgtext = 'Safety Mode Recovery.';
                case 5
                    msgtext = 'Safety Mode Safeguard Stop.';
                case 6
                    msgtext = 'Safety Mode System Emergency Stop.';
                case 7
                    msgtext = 'Safety Mode Robot Emergency Stop.';
                case 8
                    msgtext = 'Safety Mode Violation.';
                case 9
                    msgtext = 'Safety Mode Fault.';
                case 10
                    msgtext = 'Safety Mode Validate Joint ID.';
                case 11
                    msgtext = 'Safety Mode Undefined Safety Mode';
                otherwise
                    disp('other value')
            end
                                               
                ME = MException(errID,msgtext);
                throw(ME);
                
        end
        
        function pos = actualJointPositions(obj)

            % Following is the offset in the message to retrieve the joint
            % positions
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end

        function pos = actualJointVelocities(obj)

            % Following is the offset in the message to retrieve the joint
            % velocities
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end
        
        function pos = targetJointAccelerations(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48;
            pos = readData(obj,byteOffset);

        end

        function pos = targetJointPositions(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8;
            pos = readData(obj,byteOffset);

        end

        function pos = targetToolVector(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48+ 48 + 48 + 48 + 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end
        


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Returns the x,y,z,rx,ry,rz of the actual tool position
        function pos = toolVectorActual(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48+ 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end

        function pos = TCPSpeedActual(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48+ 48 + 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end

        function pos = targetJointTorques(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end

        % Following function reads the data recieved from the robot
        function data = readData(obj,byteOffset)
            flushinput(obj.socket)
            flushoutput(obj.socket)
        
            if obj.socket.BytesAvailable>0
                fread(obj.socket,obj.socket.BytesAvailable);
            end
            while obj.socket.BytesAvailable==0
            end
        
            rec = fread(obj.socket,obj.socket.BytesAvailable);
            
            for i = 1 : 6
        
                bytePos = byteOffset+8*(i-1)+1;
                received  = [rec(bytePos:bytePos+7)]';
                res = swapbytes(typecast(uint8(received),'double'));
        
                if i <= 3 
                    data(i) = round(res,6);
                else
                    data(i) = round(res,6);
                end
                
            end
        end
        
       
        function drawJointPositions(obj,jointPositions)
            figure;
            hold on;
            plot(jointPositions(:,1));
            plot(jointPositions(:,2));
            plot(jointPositions(:,3));
            plot(jointPositions(:,4));
            plot(jointPositions(:,5));
            plot(jointPositions(:,6));
            title('Joint positions')
            xlabel('Time (s)'); 
            ylabel('Joint angles (radians)');
            legend({'Base','Shoulder','Elbow','Wrist 1','Wrist 2','Wrist 3'},'Location','southwest');
            hold off;
        end

        function drawJointVelocities(obj,jointVelocities)
            figure;
            hold on;
            plot(jointVelocities(:,1));
            plot(jointVelocities(:,2));
            plot(jointVelocities(:,3));
            plot(jointVelocities(:,4));
            plot(jointVelocities(:,5));
            plot(jointVelocities(:,6));
            title('Joint Velocities');
            xlabel('Time (s)'); 
            ylabel('Velocity (m/s)');
            legend({'Base','Shoulder','Elbow','Wrist 1','Wrist 2','Wrist 3'},'Location','southwest');
            hold off;
        end

        function drawJointAccelerations(obj,jointAccelerations)
            figure;
            hold on;
            plot(jointAccelerations(:,1));
            plot(jointAccelerations(:,2));
            plot(jointAccelerations(:,3));
            plot(jointAccelerations(:,4));
            plot(jointAccelerations(:,5));
            plot(jointAccelerations(:,6));
            title('Joint Accelerations');
            xlabel('Time (s)'); 
            ylabel('Acceleration (m/s^2)');
            legend({'Base','Shoulder','Elbow','Wrist 1','Wrist 2','Wrist 3'},'Location','southwest');
            hold off;
        end

        function drawJointTorques(obj,torques)
            figure;
            hold on;
            plot(torques(:,1));
            plot(torques(:,2));
            plot(torques(:,3));
            plot(torques(:,4));
            plot(torques(:,5));
            plot(torques(:,6));
            title('Joint Torques');
            xlabel('Time (s)'); 
            ylabel('Torque (Nm)');
            legend({'Base','Shoulder','Elbow','Wrist 1','Wrist 2','Wrist 3'},'Location','southwest');
            hold off;
        end


        function drawPath(obj,poses)
            figure;
            line(poses(:,1), poses(:,2),poses(:,3));
            view(3);
            title('TCP path')
            xlabel('x-axis'); 
            ylabel('y-axis');
            zlabel('z-axis');
        end

        % Set frequency value
        function setFrequency(obj,frequency)
            obj.frequency = frequency;
        end

        % Get Frequency value
        function frequency = getFrequency(obj)
            frequency = obj.frequency;
        end
    end



end