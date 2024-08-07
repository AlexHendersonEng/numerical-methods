%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% SimulationManager class for running simulations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef SimulationManager < handle
%
    properties
        nodes
        n_nodes
        adjacency
        solver
        order   % Column 1 is node index in execution order
                % Column 2 is column 1 node dependencies
    end
%
    methods (Access = public)
        function obj = SimulationManager(nodes, adjacency, solver)
%
%           Assign variables
%
            obj.nodes = nodes;
            obj.n_nodes = numel(obj.nodes);
            obj.adjacency = adjacency;
            obj.solver = solver;
            obj.order = cell(obj.n_nodes, 2);
%
%           Initialise network
%
            obj.initialise();
        end
%
        function initialise(obj)
%
%           Get execution order
%
            count = 1;
            for node_i = 1 : obj.n_nodes
                count = exec_order(node_i, count);
                if count > obj.n_nodes; break; end
            end
%
%           Initialise nodes
%
            for exec_i = 1 : obj.n_nodes
%
%               Add up dependent nodes output
%
                output = 0;
                for node_d = obj.order{exec_i, 2}
                    output = output + obj.nodes{node_d}.output;
                end
%
%               Initialise node
%
                node_i = obj.order{exec_i, 1};
                obj.nodes{node_i}.initialise(obj.solver, output);
            end
%
%           Get execution order recursively
%
            function count = exec_order(node_i, count)
%
%               General node base case: If node has already been added to
%               execution order return
%
                if any(node_i == [obj.order{:, 1}])
                    return
                end
%
%               Get index of all input nodes
%
                input_idx = find(obj.adjacency(:, node_i))';
%
%               Input node base case: If node has no inputs it must be an
%               input node so we will add it to the execution order
%               with no dependent nodes
%
                if isempty(input_idx)
                    obj.order(count, :) = {node_i, []};
                    count = count + 1;
                    return
                end
%
%               Loop through input nodes and add them to execution
%               order if required
%
                dep_array = zeros(size(input_idx));
                for idx = 1 : numel(input_idx)
                    dep_i = input_idx(idx);
                    count = exec_order(dep_i, count);
                    dep_array(idx) = dep_i;
                end
                obj.order(count, :) = {node_i, dep_array};
                count = count + 1;
            end
        end
%
        function step(obj)
%
%           Update solver time
%
            obj.solver.update();
%
%           Step nodes
%
            for exec_i = 1 : obj.n_nodes
%
%               Add up dependent nodes output
%
                output = 0;
                for node_d = obj.order{exec_i, 2}
                    output = output + obj.nodes{node_d}.output;
                end
%
%               Step node
%
                node_i = obj.order{exec_i, 1};
                obj.nodes{node_i}.input = output;
                obj.nodes{node_i}.step();
            end
        end
%
        function terminate(obj)
%
%           Call termination method on all nodes
%
            for node = 1 : obj.n_nodes
                obj.nodes{node}.terminate();
            end
        end
%
        function reset(obj)
%
%           Reset nodes
%
            for node_i = 1 : obj.n_nodes
%
%               Get first input and output
%
                t = obj.nodes{node_i}.logger.t(1);
                input = obj.nodes{node_i}.logger.input(1);
                output = obj.nodes{node_i}.logger.output(1);
%
%               Update nodes
%
                obj.nodes{node_i}.input = input;
                obj.nodes{node_i}.output = output;
                obj.nodes{node_i}.logger.t(1) = t;
                obj.nodes{node_i}.logger.input = input;
                obj.nodes{node_i}.logger.output = output;
            end
        end
%
        function plot_digraph(obj)
%
%           Plot adjacecny matrix in graphical form
%
            graph = digraph(obj.adjacency);
            plot(graph);
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%