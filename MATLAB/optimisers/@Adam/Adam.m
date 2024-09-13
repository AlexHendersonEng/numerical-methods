%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Adam optimisation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Adam < Optimiser
%
    properties 
        lr double
        beta1 double
        beta2 double
        m double
        v double
        iter double = 1;
    end
%
    methods
        function obj = Adam(params, options)
%
%           Input handling
%
            arguments
                params
                options.lb = repmat(-100, 1, numel(params));
                options.ub = repmat(100, 1, numel(params));
                options.lr = 1e-3;
                options.beta1 = 0.9;
                options.beta2 = 0.999;
            end
%
%           Call superclass constructor
%
            obj = obj@Optimiser(params, ...
                                'lb', options.lb, ...
                                'ub', options.ub);
%
%           Assign parameters
%
            obj.lr = options.lr;
            obj.beta1 = options.beta1;
            obj.beta2 = options.beta2;
            obj.m = zeros(size(obj.params));
            obj.v = zeros(size(obj.params));
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