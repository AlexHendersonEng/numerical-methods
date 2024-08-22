%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Adam optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Adam < Optimiser
%
    properties
        h
        beta1
        beta2
        m
        v
        step_num = 1
    end
%
    methods
        function obj = Adam(nodes, adjacency, h, options)
%
%           Input handling
%
            arguments
                nodes
                adjacency
                h = 1e-3;
                options.beta1 = 0.9;
                options.beta2 = 0.999;
                options.lb = [];
                options.ub = [];
            end
%
%           Call super class instatiation method and assign variables
%
            obj = obj@Optimiser(nodes, adjacency, options.lb, options.ub);
            obj.h = h;
            obj.beta1 = options.beta1;
            obj.beta2 = options.beta2;
            obj.m = cell(obj.n_nodes, 1);
%
%           Initialise first and second moment estimates
%
            for node_i = 1 : obj.n_nodes
                obj.m{node_i} = zeros(size(obj.param_grad{node_i}));
            end
            obj.v = obj.m;
        end
%
        function step(obj)
%
%           Initialise lower and upper bound arrays
%
            lb = obj.lb;
            ub = obj.ub;
%
%           Loop through nodes and update params
%
            for node_i = 1 : obj.n_nodes
%
%               Update biased first and second moment estimate
%
                obj.m{node_i} = obj.beta1 * obj.m{node_i} + (1 - obj.beta1) * obj.param_grad{node_i};
                obj.v{node_i} = obj.beta2 * obj.v{node_i} + (1 - obj.beta2) * obj.param_grad{node_i} .^ 2;
%
%               Compute bias corrected first and second moment estimate 
%
                m_hat = obj.m{node_i} ./ (1 - obj.beta1 ^ obj.step_num);
                v_hat = obj.v{node_i} ./ (1 - obj.beta2 ^ obj.step_num);
%
%               Calculate param update
%
                param = obj.nodes{node_i}.parameters();
                param_update = param - obj.h * m_hat ./ (sqrt(v_hat) + 1e-8);
%
%               Apply bounds
%
                n_param = numel(param);
                param_update = min(max(param_update, lb(1 : n_param)), ub(1 : n_param));
                lb(1 : n_param) = [];
                ub(1 : n_param) = [];
%
%               Update node param
%
                obj.nodes{node_i}.update(param_update);
            end
%
%           Increment step number
%
            obj.step_num = obj.step_num + 1;
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%