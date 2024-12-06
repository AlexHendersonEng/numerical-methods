%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Memory block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Memory < Block
%
    properties (Access = private)
        prev_input Tensor; % Previous input
        ic Tensor; % Initial condition
    end
%
    methods (Access = public)
        function obj = Memory(ic)
%
%           Input handling
%
            arguments
                ic Tensor; % Initial condition
            end
%
%           Call block superclass
%
            obj = obj@Block(1, 1);
%
%           Assign properties
%
            obj.ic = ic;
            obj.prev_input = obj.ic;
        end
%
        update(obj, ~);
%
        reset(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%