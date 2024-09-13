%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% L1 class for implementation of a L1 loss function block
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef L1 < Block
%
    properties
        y        % Column vector of signals where each column is new signal
        y_t      % Column vector of signal time
        y_actual % Interpolated signal at given time
    end
%
    methods
        function obj = L1(y, y_t, logging)
%
%           Input handling
%
            arguments
                y
                y_t
                logging = true;
            end
%
%           Call superclass instantiator
%
            obj = obj@Block(1, 1, logging);
%
%           Assign variables
%
            obj.y = y;
            obj.y_t = y_t;
        end
%
        initialise(obj, solver, n_steps)
%
        step(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%