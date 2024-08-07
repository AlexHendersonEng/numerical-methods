%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gain class which implements a gain component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Gain < Component
%
    properties
        gain;
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
            obj.output = obj.gain * obj.input;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.output = obj.gain * obj.input;
            obj.logger = obj.logger.log(obj);
        end
%
        function dydw = derivative(obj)
%
%           Calculate derivate of output with respect to weight
%
            dydw = obj.input;
        end
%
        function update(obj, weight_update)
%
%           Update weight
%
            obj.gain = obj.gain + weight_update;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%