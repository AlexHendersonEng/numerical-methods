%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gain block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Gain < Block
%
    properties (Access = public)
        k double;  % Gain
    end
%
    methods (Access = public)
        function obj = Gain(k)
%
%           Input handling
%
            arguments
                k double = 1;
            end
%
%           Call block superclass
%
            obj = obj@Block();
%
%           Assign properties
%
            obj.k = k;
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