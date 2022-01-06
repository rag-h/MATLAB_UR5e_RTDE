classdef rtde
    properties
        socket
    end
    methods
        % Constructor
        function obj = rtde(host,port)
            obj.socket = tcpip(host, port);
            obj.socket.InputBufferSize = 1220;
            obj.socket.OutputBufferSize = 3000;
            fopen(obj.socket);

            disp('Socket Connected!');
        end

        % Close Socket

        function close(obj)
            fclose(obj.socket);
            delete(obj.socket);
            clear obj.socket;

            disp("Socket Disconnected!")
        end
    
    
        % Following function returns the list of poses that the robot followed to
        % get from pose A to pose B
        function poses = move(obj,type,target)
        
            flushinput(obj.socket)
            flushoutput(obj.socket)
        
            tolerance = [0.0001,0.0001,0.0001,0.0001,0.0001,0.0001];
        
            target(1:3) = target(1:3) * 0.001; % Converting to meter
        
            % Converting pose to string
            target_char = ['move', type ,'(p[',num2str(target(1)),',',...
                num2str(target(2)),',',...
                num2str(target(3)),',',...
                num2str(target(4)),',',...
                num2str(target(5)),',',...
                num2str(target(6)),...
                '])\n'];
        
            % Sending the command through as bytes
            fprintf(obj.socket,target_char);
        
            % Pause for a short interval to allow the command to be received 
            pause(0.3);
            
            % Appending the inital position of the arm to an array
            poses = toolVectorActual(obj);
            
            
            % Determining whether or not the arm has reached the target position
            % Poses(end,:) = current pose of the arm
            % target = target pose of the arm
            % poses(end,:) - target should be 0 if the robot arm has reached the
            % target
            % We set a tolerance value as the robotic arm's motions in the real
            % world is not perfect. In the sim is is perfect though
        
            while any(abs(poses(end,:) - target) > tolerance,'all') %&& checkSafetyMode(obj) == 1
                poses(end+1,:) = toolVectorActual(obj);
                if(checkSafetyMode(obj) ~= 1)

                   disp("woopsie");
                end
                pause(0.1);
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
            val = 4 + 8 + 48 + 48 + 48 + 48 + 48+ 48 + 48 + 48 + 48 + 48 +48 +48 + 48 +48 + 8 + 48 + 8 + 8;
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

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48;
            pos = readData(obj,byteOffset);

        end

        function pos = actualJointVelocities(obj)

            % Following is the offset in the message to retrieve the tool position.
            byteOffset = 4 + 8 + 48 + 48 + 48 + 48 + 48 + 48;
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
        
       
        function drawPath(obj,poses)
            line(poses(:,1), poses(:,2),poses(:,3));
            view(3)
        end
    end



end