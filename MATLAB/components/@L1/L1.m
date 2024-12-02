%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% L1 loss function class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef L1 < Block
%
    properties (Access = public)
        y_t double; % Time values column vector
        y double; % Data values where each column is new signal
    end
%
    methods (Access = public)
        function obj = L1(y_t, y)
%
%           Input handling
%
            arguments
                y_t double;
                y double;
            end
%
%           Call block superclass
%
            obj = obj@Block(1, 1);
%
%           Assign properties
%
            obj.y_t = y_t;
            obj.y = y;
        end
%
        update(obj, t);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%