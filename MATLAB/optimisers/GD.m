%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gradient descent based optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef GD < Optimiser
%
    properties
        h
    end
%
    methods
        function obj = GD(nodes, adjacency, h, options)
%
%           Input handling
%
            arguments
                nodes
                adjacency
                h = 1e-3
                options.lb = [];
                options.ub = [];
            end
%
%           Call super class instatiation method
%
            obj = obj@Optimiser(nodes, adjacency, options.lb, options.ub);
            obj.h = h;
        end
%
        function step(obj)
%
%           Initialise lower and upper bound arrays
%
            lb = obj.lb;
            ub = obj.ub;
%
%           Loop through nodes and update weights
%
            for node_i = 1 : obj.n_nodes
%
%               If node has no parameters then skip
%
                if isempty(obj.nodes{node_i}.parameters()); continue; end
%
%               Calculate param update
%
                param = obj.nodes{node_i}.parameters();
                param_update = param - obj.h * obj.param_grad{node_i};
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
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%