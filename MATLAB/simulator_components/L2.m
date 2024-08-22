%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% L2 class which implements an L2 loss component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef L2 < Component
%
    properties
        y % Column vector of signals where each column is new signal
        y_t % Column vector of signal time
        y_actual % Interpolated signal at given time
    end
%
    methods
        function obj = L2(y, y_t, logging)
%
%           L2 instatiator assigns goal time varying signal time and 
%           values and logging option
%
            arguments
                y
                y_t
                logging = true
            end
%
%           Call super class instatiator
%
            obj = obj@Component(logging);
%
%           Assign variables
%
            obj.y = y;
            obj.y_t = y_t;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise L2 loss component by initialising input/output
%           and logging initial values 
%
            obj.solver = solver;
            obj.input = input;
            obj.y_actual = interp1(obj.y_t, obj.y, obj.solver.t);
            obj.output = 0.5 * (obj.y_actual - obj.input) .^ 2;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.y_actual = interp1(obj.y_t, obj.y, obj.solver.t);
            obj.output = (obj.y_actual - obj.input) .^ 2;
            obj.logger = obj.logger.log(obj);
        end
%
        function [dydx, dydp] = derivative(obj)
%
%           Calculate derivative of output with respect to input and param
%
            dydx = obj.input - obj.y_actual;
            dydp = 0;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%