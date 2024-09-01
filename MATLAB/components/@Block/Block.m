%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Block class for implementation of a block object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Block < handle
%
    properties
        input Tensor
        output Tensor
        logging logical
        solver
        logger Logger
        params
    end
%
    methods
        function obj = Block(n_in, n_out, logging)
%
%           Block base class instatiator assigns logging option
%
            arguments
                n_in = 1;
                n_out = 1;
                logging = true
            end
            obj.logging = logging;
%
%           Initialise input and output
%
            obj.input = repmat(Tensor(0), 1, n_in);
            obj.output = repmat(Tensor(0), 1, n_out);
%
%           Create logger
%
            obj.logger = Logger();
        end
%
        initialise(obj, solver, n_steps);
%
        step(obj);
%
        terminate(obj);
%
        log(obj);
%
        params = parameters(obj);
%
        reset(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%