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
        J
        order   % Column 1 is node index in propagation order
                % Column 2 is column 1 node dependencies
    end
%
    methods
        function obj = Optimiser(nodes, adjacency)
%
%           Get number of nodes
%
            obj.nodes = nodes;
            obj.adjacency = adjacency;
            obj.n_nodes = size(obj.adjacency, 1);
            obj.J = zeros(obj.n_nodes, 1);
            obj.order = cell(obj.n_nodes, 2);
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
%               Ouput node base case: If node has no outputs it must be an
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
%           Get weight update for all nodes
%
            for prop_i = 1 : obj.n_nodes
%
%               Get propagation node index
%
                node_i = obj.order{prop_i, 1};
%
%               If no dependent nodes then it is an output so we dont want
%               to multiply it by zero when calculating the Jacobian so set
%               dedy to 1
%
                nodes_d = obj.order{prop_i, 2};
                if isempty(nodes_d)
                    dedy = 1;
                else
                    dedy = 0;
                end
%
%               Add up dependent nodes gradient
%
                for node_d = nodes_d
                    dedy = dedy + obj.J(node_d);
                end
%
%               Calculate Jacobian
%
                dydw = obj.nodes{node_i}.derivative();
                obj.J(node_i) = dedy * dydw;
            end
        end
%
        function step(~)
        
        end
%
        function zero_grad(obj)
            obj.J = zeros(obj.n_nodes, 1);
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%