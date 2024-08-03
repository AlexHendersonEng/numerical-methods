%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Input class which implements a input component for inputting time varying
% signals into the simulation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Input < Component
%
    properties
        u
        u_t
    end
%
    methods
        function obj = Input(u, u_t, logging)
%
%           Input instatiator assigns time varying signal time and values
%           and logging option. Object input is also assigned as an empty
%           array as the input component has no input
%
            arguments
                u
                u_t
                logging = true
            end
            obj.u = u;
            obj.u_t = u_t;
            obj.input = [];
            obj.logging = logging;
        end
%
        function initialise(obj, solver, ~)
%
%           Initialise Input component by initialising solver, output and
%           logging initial values 
%
            obj.solver = solver;
            obj.output = interp1(obj.u_t, obj.u, obj.solver.t);
            obj.logger = obj.logger.log(obj);
        end
%
        function step(obj)
%
%           Step forward in time calculating new output and logging data 
%
            obj.output = interp1(obj.u_t, obj.u, obj.solver.t);
            obj.logger = obj.logger.log(obj);
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%