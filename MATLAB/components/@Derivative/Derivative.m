%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Derivative block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Derivative < Block
%
    properties (Access = public)
        h double;  % Time step
    end
%
    properties (Access = private)
        prev_input Tensor; % Previous input
    end
%
    methods (Access = public)
        function obj = Derivative(h)
%
%           Input handling
%
            arguments
                h double;
            end
%
%           Call block superclass
%
            obj = obj@Block(1, 1);
%
%           Assign properties
%
            obj.h = h;
            obj.prev_input = Tensor(0);
        end
%
        update(obj, ~);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%