%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% L1 class which implements a loss magnitude loss component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef L1 < Component
%
    properties
        y % Column vector of signals where each column is new signal
        y_t % Column vector of signal time
        y_actual % Interpolated signal at given time
    end
%
    methods
        function obj = L1(y, y_t, logging)
%
%           L1 instatiator assigns goal time varying signal time and 
%           values and logging option
%
            arguments
                y
                y_t
                logging = true
            end
            obj.y = y;
            obj.y_t = y_t;
            obj.logging = logging;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise L1 loss component by initialising input/output
%           and logging initial values 
%
            obj.solver = solver;
            obj.input = input;
            obj.y_actual = interp1(obj.y_t, obj.y, obj.solver.t);
            obj.output = abs(obj.y_actual - obj.input);
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.y_actual = interp1(obj.y_t, obj.y, obj.solver.t);
            obj.output = abs(obj.y_actual - obj.input);
            obj.logger = obj.logger.log(obj);
        end
%
        function [dydx, dydp] = derivative(obj)
%
%           Calculate derivative of output with respect to input and param
%
            dydx = -sign(obj.y_actual - obj.input);
            dydp = 0;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%