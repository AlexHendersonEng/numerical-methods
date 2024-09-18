%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Memory class for implementation of a memory object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Memory < Block
%
    properties
        prev_output
    end
%
    methods
        function obj = Memory(ic, logging)
%
%           Input handling
%
            arguments
                ic = 0;
                logging = true;
            end
%
%           Call superclass instantiator
%
            obj = obj@Block(1, 1, logging);
%
%           Assign variables
%
            obj.prev_output = Tensor(ic);
            obj.output = obj.prev_output;
        end
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