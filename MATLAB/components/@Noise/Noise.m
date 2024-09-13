%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Noise class for implementation of a noise block
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Noise < Block
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
%           Input handling
%
            arguments
                mu = 1
                sigma = 1;
                sample_rate = [];
                logging = true
            end
%
%           Call superclass instantiator
%
            obj = obj@Block(1, 1, logging);
%
%           Assign variables
%
            obj.mu = mu;
            obj.sigma = sigma;
            obj.sample_rate = sample_rate;
        end
%
        initialise(obj, solver, n_steps)
%
        step(obj);
%
        reset(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%