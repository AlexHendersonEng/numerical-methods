%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Integrator class for implementation of a integrator object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Integrator < Block
%
    methods
        function obj = Integrator(ic, logging)
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
            obj.output = Tensor(ic);
        end
%
        step(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%