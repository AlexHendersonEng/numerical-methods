%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Noise class which implements a gaussian noise component
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Noise < Component
%
    properties
        mu % Mean of Gaussian noise
        sigma % Standard deviation of Gaussian noise
        sample_rate % Sample rate which must be greater than or equal to
                    % and an integer multiple of the continuous time step
        sample_n % Number of continuous time steps between Gaussian
                 % distribution sampling
        n_elapsed = 0 % Elapsed steps since last sample of Gaussian
                      % distribution
    end
%
    methods
        function obj = Noise(mu, sigma, sample_rate, logging)
%
%           Noise instatiator assigns mean, standard deviation and logging
%           option
%
            arguments
                mu = 1
                sigma = 1;
                sample_rate = [];
                logging = true
            end
%
%           Call super class instatiator
%
            obj = obj@Component(logging);
%
%           Assign variables
%
            obj.mu = mu;
            obj.sigma = sigma;
            obj.sample_rate = sample_rate;
        end
%
        function initialise(obj, solver, input)
%
%           Initialise noise component by initialising input/output and
%           logging initial values 
%
            obj.solver = solver;
            if isempty(obj.sample_rate)
                obj.sample_rate = obj.solver.h;
            end
            obj.sample_n = obj.sample_rate / obj.solver.h;
            obj.input = input;
            obj.output = obj.input + obj.mu + randn(size(obj.input)) * obj.sigma;
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.n_elapsed = obj.n_elapsed + 1;
            if obj.n_elapsed == obj.sample_n
                obj.output = obj.input + obj.mu + randn(size(obj.input)) * obj.sigma;
                obj.n_elapsed = 0;
            else
                obj.output = obj.input;
            end
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
%
        function reset(obj)
%
%           Get initial time, input and output
%
            t_init = obj.logger.t(1);
            input_init = obj.logger.input(1, :);
            output_init = obj.logger.output(1, :);
%
%           Reset compoenent
%
            obj.input = input_init;
            obj.output = output_init;
            obj.logger.t = t_init;
            obj.logger.input = input_init;
            obj.logger.output = output_init;
            obj.n_elapsed = 0;
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%