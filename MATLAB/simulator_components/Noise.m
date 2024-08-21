%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Noise class which implements a gaussian noise component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Noise < Component
%
    properties
        mu
        sigma
    end
%
    methods
        function obj = Noise(mu, sigma, logging)
%
%           Noise instatiator assigns mean, standard deviation and logging
%           option
%
            arguments
                mu = 1
                sigma = 1;
                logging = true
            end
            obj.mu = mu;
            obj.sigma = sigma;
            obj.logging = logging;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise noise component by initialising input/output and
%           logging initial values 
%
            obj.solver = solver;
            obj.input = input;
            obj.output = obj.input + obj.mu + randn() * obj.sigma;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.output = obj.input + obj.mu + randn() * obj.sigma;
            obj.logger = obj.logger.log(obj);
        end
%
        function [dydx, dydp] = derivative(~)
%
%           Calculate derivate of output with respect to input and param
%
            dydx = 1;
            dydp = 0;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%