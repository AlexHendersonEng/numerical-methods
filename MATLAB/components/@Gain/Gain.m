%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gain class for implementation of a gain object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Gain < Block
%
    methods
        function obj = Gain(gain, logging)
%
%           Input handling
%
            arguments
                gain = 0;
                logging = true;
            end
%
%           Call superclass instantiator
%
            obj = obj@Block(1, 1, logging);
%
%           Assign variables
%
            obj.params = Tensor(gain);
        end
%
        initialise(obj, solver, n_steps)
%
        step(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%