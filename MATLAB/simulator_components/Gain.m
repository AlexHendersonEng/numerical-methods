%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gain class which implements a gain component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Gain < Component
%
    properties
        gain % Row vector of gains
    end
%
    methods
        function obj = Gain(gain, logging)
%
%           Gain instatiator assigns gain and logging option
%
            arguments
                gain
                logging = true
            end
            obj.gain = gain;
            obj.logging = logging;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise gain component by initialising input/output and
%           logging initial values 
%
            obj.solver = solver;
            obj.input = input;
            obj.output = obj.gain .* obj.input;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.output = obj.gain .* obj.input;
            obj.logger = obj.logger.log(obj);
        end
%
        function [dydx, dydp] = derivative(obj)
%
%           Calculate derivate of output with respect to input and param
%
            dydx = obj.gain;
            dydp = obj.input;
        end
%
        function update(obj, param_update)
%
%           Update param
%
            obj.gain = param_update;
        end
%
        function params =  parameters(obj)
%
%           Return tunable parameters in array
%
            params = obj.gain;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%