%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TF1 class for implementation of a TF1 object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef TF1 < Block
%
    properties
        blocks cell
        connections double
        sim Simulation
    end
%
    methods
        function obj = TF1(ic, tau, logging)
%
%           Input handling
%
            arguments
                ic = 0;
                tau = 1;
                logging = true;
            end
%
%           Call superclass instantiator
%
            obj = obj@Block(1, 1, logging);
%
%           Initlialise blocks and connections
%
            obj.blocks = {Operator('+-'), ...
                          Gain(1 / tau), ...
                          Integrator(ic), ...
                          Memory(ic)};
            obj.connections = [1, 1, 2, 1;
                               2, 1, 3, 1;
                               3, 1, 4, 1;
                               4, 1, 1, 2];
        end
%
        initialise(obj, solver, n_steps);
%
        step(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%