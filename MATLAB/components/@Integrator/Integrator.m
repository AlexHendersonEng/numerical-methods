%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Integrator block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Integrator < Block
%
    properties (Access = public)
        state Tensor;  % Integrator state
    end
%
    methods (Access = public)
        function obj = Integrator(state)
%
%           Input handling
%
            arguments
                state Tensor = Tensor(0);
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