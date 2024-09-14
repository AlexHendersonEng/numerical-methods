%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Input class for implementation of a input object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Input < Block
%
    properties
        u % Column vector of signals where each column is new signal
        u_t % Column vector of signal time
    end
%
    methods
        function obj = Input(u, u_t, logging)
%
%           Input instatiator assigns time varying signal time and values
%           and logging option.
%
            arguments
                u
                u_t
                logging = true
            end
%
%           Call super class instatiator
%
            obj = obj@Block(1, size(u, 2), logging);
%
%           Assign variables
%
            obj.u = u;
            obj.u_t = u_t;
        end
%
        initialise(obj, solver, n_steps);
%
        step(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%