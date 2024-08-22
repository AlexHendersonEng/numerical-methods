%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TF1 class which implements a first order transfer function component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef TF1 < Component
%
    properties
        tau % Row vector of time constants
    end
%
    methods
        function obj = TF1(tau, ic, logging)
%
%           TF1 instatiator assigns time constant, initial condition
%           and logging option
%
            arguments
                tau
                ic
                logging = true
            end
            obj.tau = tau;
            obj.output = ic;
            obj.logging = logging;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise TF1 component by initialising solver, input/output
%           and logging initial values 
%
            obj.solver = solver;
            obj.input = input;
            obj.output = obj.output;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            dydt = @(t, y) (1 ./ obj.tau) .* (obj.input - y);
            obj.output = obj.solver.step(@(t, y) dydt(t, y), obj.output);
            obj.logger = obj.logger.log(obj);
        end
%
        function [dydx, dydp] = derivative(obj)
%
%           Calculate derivative of output with respect to input and param
%
            dydx = 1;
            dydp = (1 ./ obj.tau) .* (obj.output - obj.input);
        end
%
        function update(obj, param_update)
%
%           Update param
%
            obj.tau = param_update;
        end
%
        function params =  parameters(obj)
%
%           Return tunable parameters in array
%
            params = obj.tau;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%