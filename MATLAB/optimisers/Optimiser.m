%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Optimiser base class optimisation algorithms
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Optimiser < handle
%
    properties
        nodes
        adjacency
        n_nodes
        n_params = 0;
        grad
        param_grad
        order   % Column 1 is node index in propagation order
                % Column 2 is column 1 node dependencies
        lb
        ub
    end
%
    methods
        function obj = Optimiser(nodes, adjacency, lb, ub)
%
%           Initialise variables
%
            obj.nodes = nodes;
            obj.adjacency = adjacency;
            obj.n_nodes = size(obj.adjacency, 1);
            obj.grad = cell(obj.n_nodes, 1);
            obj.param_grad = cell(obj.n_nodes, 1);
            obj.order = cell(obj.n_nodes, 2);
            obj.lb = lb;
            obj.ub = ub;
%
%           Initialise gradient and parameter gradient arrays
%
            for node_i = 1 : numel(obj.nodes)
                n_inputs = numel(obj.nodes{node_i}.input);
                obj.grad{node_i} = zeros(1, n_inputs);
%
                n_params = numel(obj.nodes{node_i}.parameters());
                obj.param_grad{node_i} = zeros(1, n_params);
%
                obj.n_params = obj.n_params + n_params;
            end
%
%           Generate bounds if required
%
            if isempty(obj.lb)
                obj.lb = repmat(-100, 1, obj.n_params);
            end
%
            if isempty(obj.ub)
                obj.ub = repmat(100, 1, obj.n_params);
            end
%
%           Get propagation order
%
            count = 1;
            for node_i = 1 : obj.n_nodes
                count = prop_order(node_i, count);
                if count > obj.n_nodes; break; end
            end         
%
%           Get propagation order recursively
%
            function count = prop_order(node_i, count)
%
%               General node base case: If node has already been added to
%               propagation order return
%
                if any(node_i == [obj.order{:, 1}])
                    return
                end
%
%               Get index of all output nodes
%
                output_idx = find(obj.adjacency(node_i, :));
%
%               Output node base case: If node has no outputs it must be an
%               output node so we will add it to the propagation order
%               with no dependent nodes
%
                if isempty(output_idx)
                    obj.order(count, :) = {node_i, []};
                    count = count + 1;
                    return
                end
%
%               Loop through output nodes and add them to propagation
%               order if required
%
                dep_array = zeros(size(output_idx));
                for idx = 1 : numel(output_idx)
                    dep_i = output_idx(idx);
                    count = prop_order(dep_i, count);
                    dep_array(idx) = dep_i;
                end
                obj.order(count, :) = {node_i, dep_array};
                count = count + 1;
            end
        end
%
        function backward(obj)
%
%           Get param update for all nodes
%
            for prop_i = 1 : obj.n_nodes
%
%               Get propagation node index
%
                node_i = obj.order{prop_i, 1};
%
%               If node is an input there is no need to calculate
%               derivatives
%
                if ~any(obj.adjacency(:, node_i)); continue; end
%
%               If no dependent nodes then it is an output node and the
%               gradient should be the derivative of its output (the error)
%               with respect to the input and there is no param to update
%               gradient of
%
                nodes_d = obj.order{prop_i, 2};
                if isempty(nodes_d)
                    [dydx, ~] = obj.nodes{node_i}.derivative();
                    obj.grad{node_i} = dydx;
                    obj.param_grad{node_i} = [];
                    continue
                end
%
%               Add up dependent nodes gradient which should have already
%               been computed
%
                grad_sum = 0;
                for node_d = nodes_d
                    grad_sum = grad_sum + obj.grad{node_d};
                end
%
%               Calculate gradient of error with respect to node input.
%               The grad_sum term gives de/dy, so, multiplying by dy/dx
%               gives de/dx and multiplying de/dy by dy/dp gives the de/dp
%               which is the param gradient
%
                [dydx, dydp] = obj.nodes{node_i}.derivative();
                obj.grad{node_i} = obj.grad{node_i} + grad_sum .* dydx;
                if isempty(obj.param_grad{node_i}); continue; end
                obj.param_grad{node_i} = obj.param_grad{node_i} + grad_sum .* dydp;
            end
        end
%
        function step(~)
        
        end
%
        function zero_grad(obj)
            for node_i = 1 : obj.n_nodes
                obj.grad{node_i} = zeros(size(obj.grad{node_i}));
                obj.param_grad{node_i} = zeros(size(obj.param_grad{node_i}));
            end
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%