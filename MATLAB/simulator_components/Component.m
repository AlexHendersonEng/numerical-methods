%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Component base class for nodes in simulation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Component < handle
%
    properties
        input = 0;
        output = 0;
        solver
        logger = Logger()
        logging = false;
    end
%
    methods
        function obj = Component(logging)
%
%           Component base class instatiator assigns logging option
%
            arguments
                logging = true
            end
            obj.logging = logging;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise component by assigning solver, initialises 
%           input/output and logging initial values (runs once before
%           simulation)
%
            obj.solver = solver;
            obj.input = input;
            obj.output = obj.input;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%           (runs at every simulation step)
%
            obj.output = obj.output;
            obj.logger = obj.logger.log(obj);
        end
%
        function terminate(~)
%
%           Perform and simulation terminate actions (runs once at the end
%           of the simulation)
%

        end
%
        function log(obj)
%
%           Log data to logger
%
            if obj.logging
                obj.logger.log(obj);
            end
        end
%
        function [dydx, dydp] = derivative(~)
%
%           Calculate derivate of output with respect to input and param
%
            dydx = 0;
            dydp = 0;
        end
%
        function update(~, ~)
%
%           Update param
%
            
        end
%
        function params =  parameters(~)
%
%           Return tunable parameters in array
%
            params = [];
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%