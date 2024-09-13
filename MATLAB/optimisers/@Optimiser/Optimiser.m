%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Optimiser base class for optimisation algorithms
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Optimiser < handle
%
    properties
        params Tensor
        n_params double
        lb double
        ub double
    end
%
    methods
        function obj = Optimiser(params, options)
%
%           Input handling
%
            arguments
                params
                options.lb = repmat(-100, 1, numel(params));
                options.ub = repmat(100, 1, numel(params));
            end
%
%           Assign parameters
%
            obj.params = params;
            obj.n_params = numel(params);
            obj.lb = options.lb;
            obj.ub = options.ub;
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