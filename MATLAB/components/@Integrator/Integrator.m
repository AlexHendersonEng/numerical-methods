%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Integrator block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Integrator < Block
%
    properties (Access = public)
        state double;  % Integrator state
    end
%
    methods (Access = public)
        function obj = Integrator(state)
%
%           Input handling
%
            arguments
                state double = 0;
            end
%
%           Call block superclass
%
            obj = obj@Block();
%
%           Assign properties
%
            obj.state = state;
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