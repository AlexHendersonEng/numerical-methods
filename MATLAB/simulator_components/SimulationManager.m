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
        t
        order   % Column 1 is node index in execution order
                % Column 2 is column 1 node dependencies
    end
%
    methods (Access = public)
        function obj = SimulationManager(nodes, adjacency, solver)
%
%           SimulationManager instatiation method which assigns nodes,
%           adjacency matrix and solver
%
            obj.nodes = nodes;
            obj.n_nodes = numel(obj.nodes);
            obj.adjacency = adjacency;
            obj.solver = solver;
            obj.order = cell(obj.n_nodes, 2);
        end
%
        function plot_digraph(obj)
%
%           Plot adjacecny matrix in graphical form
%
            graph = digraph(obj.adjacency);
            plot(graph);
        end
%
        function run(obj, tspan)
%
%           Run the simulation for the specified time span
%
            obj.t = tspan(1) : obj.solver.h : tspan(2);
            obj.initialise();
            obj.step();
            obj.terminate();
        end
%
        function plot_results(obj)
%
%           Plot the output of all nodes against time
%
            figure();
            for node_idx = 1 : obj.n_nodes
                plot(obj.t, obj.nodes{node_idx}.logger.output, ...
                     'LineWidth', 1.5, ...
                     'DisplayName', ['Node: ', num2str(node_idx)]);
                hold('on');
            end
            xlabel('Time (s)');
            ylabel('Output');
            legend('Location', 'northeast');
            hold('off');
        end
    end
%
    methods (Access = private)
        function initialise(obj)
%
%           Initialise solver time
%
            obj.solver.update(obj.t(1));
%
%           Get initialisation order
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
%           Get initialisation order recursively
%
            function count = exec_order(node_i, count)
%
%               General node base case: If node has already been added to
%               initialisation order return
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
%               input node so we will add it to the initialisation order
%               with no dependent nodes
%
                if isempty(input_idx)
                    obj.order(count, :) = {node_i, []};
                    count = count + 1;
                    return
                end
%
%               Loop through input nodes and add them to initialisation
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
%           Step forward in time
%
            for t_curr = obj.t(2 : end)
%
%               Update solver time
%
                obj.solver.update(t_curr);
%
%               Step nodes
%
                for exec_i = 1 : obj.n_nodes
%
%                   Add up dependent nodes output
%
                    output = 0;
                    for node_d = obj.order{exec_i, 2}
                        output = output + obj.nodes{node_d}.output;
                    end
%
%                   Step node
%
                    node_i = obj.order{exec_i, 1};
                    obj.nodes{node_i}.input = output;
                    obj.nodes{node_i}.step();
                end
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
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%