%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% GradientDescent optimisation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef GradientDescent < Optimiser
%
    properties
        lr double
    end
%
    methods
        function obj = GradientDescent(params, options)
%
%           Input handling
%
            arguments
                params
                options.lb = repmat(-100, 1, numel(params));
                options.ub = repmat(100, 1, numel(params));
                options.lr = 1e-3;
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