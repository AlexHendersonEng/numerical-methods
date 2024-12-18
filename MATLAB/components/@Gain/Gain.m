%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gain block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Gain < Block
%
    properties (Access = public)
        param Tensor;  % Gain
    end
%
    methods (Access = public)
        function obj = Gain(param)
%
%           Input handling
%
            arguments
                param Tensor = Tensor(1);
            end
%
%           Call block superclass
%
            obj = obj@Block(1, 1);
%
%           Assign properties
%
            obj.param = param;
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