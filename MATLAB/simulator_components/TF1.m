%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TF1 class which implements a first order transfer function component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef TF1 < Component
%
    properties
        tau;
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
            dydt = @(t, y) (1 / obj.tau) * (obj.input - y);
            obj.output = obj.solver.step(@(t, y) dydt(t, y), obj.output);
            obj.logger = obj.logger.log(obj);
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%