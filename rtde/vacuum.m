% Author: Raghav Hariharan
% This class controls the grip and release functionality of the vacuum
% gripper

classdef vacuum
    properties
        % Socket contains all tcp connection related stuff
        socket;
        % Following are necessary inputs for the vacuum gripper.
        pressure = 40.0;
        speed = 60.0;
        timeout = 30;

    end
    methods
        function obj = vacuum(host,port)
            obj.socket = tcpclient(host, port);
            
            obj.socket.InputBufferSize = 1220;
            obj.socket.OutputBufferSize = 3000;
            
            fopen(obj.socket);

            disp('Vacuum Socket Connected!');
        end

        % 0 = vaccum, 100 = 1 atmosphere pressure
        function setPressure(obj,p)
            obj.pressure = p;
        end

        % Determines how long the vacuum has active suction for (ms)
        function setSpeed(obj,s)
            obj.speed = s;
        end

        function setTimeout(obj,t)
            obj.timeout = t
        end

        % Close Socket
        function close(obj)
            fclose(obj.socket);
            delete(obj.socket);
            clear obj.socket;

            disp("Vacuum Socket Disconnected!");
        end

        function grip(obj)
            flushinput(obj.socket);
            flushoutput(obj.socket);

            str = "SET POS " + obj.pressure + " SPE " + obj.speed + " FOR " + obj.timeout + "GTO 1 \n";
            
            fprintf(obj.socket,str);  
        end

        function release(obj)
            flushinput(obj.socket);
            flushoutput(obj.socket);
            
            pressure = 100.0;

            str = "SET POS " + pressure + " SPE " + obj.speed + " FOR " + obj.timeout + "GTO 1 \n";

            fprintf(obj.socket,str);  

        end
    
    end

end