%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Operator block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Operator < Block
%
    properties (Access = public)
        operations char;  % Operations character array e.g. '+-*/'
    end
%
    methods (Access = public)
        function obj = Operator(operations)
%
%           Input handling
%
            arguments
                operations char = '++';
            end
%
%           Call block superclass
%
            obj = obj@Block();
%
%           Assign properties
%
            obj.operations = operations;
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