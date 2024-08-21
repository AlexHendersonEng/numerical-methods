%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Add class which implements a channel addition component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Add < Component
%
    methods
%
        function initialise(obj, solver, input)
%
%           Initialise add component by initialising input/output and
%           logging initial values 
%
            obj.solver = solver;
            obj.input = input;
            obj.output = sum(obj.input);
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.output = sum(obj.input);
            obj.logger = obj.logger.log(obj);
        end
%
        function [dydx, dydp] = derivative(obj)
%
%           Calculate derivate of output with respect to input and param
%
            dydx = obj.input;
            dydp = [];
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%