%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Operator class for implementation of a operator object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Operator < Block
%
    properties
        operations
    end
%
    methods
        function obj = Operator(operations, logging)
%
%           Input handling
%
            arguments
                operations
                logging = true
            end
%
%           Call superclass instantiator
%
            obj = obj@Block(numel(operations), 1, logging);
%
%           Assign variables
%
            obj.operations = operations;
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