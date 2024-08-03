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
        adjacency
        solver
        t
    end
%
    methods (Access = public)
        function obj = SimulationManager(nodes, adjacency, solver)
%
%           SimulationManager instatiation method which assigns nodes,
%           adjacency matrix and solver
%
            obj.nodes = nodes;
            obj.adjacency = adjacency;
            obj.solver = solver;
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
            for node_idx = 1 : numel(obj.nodes)
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
%           Initialise all nodes
%
            visited = false(size(obj.nodes));
            for node_i = 1 : numel(obj.nodes)
                [~, visited] = init_node(node_i, visited);
            end
%
%           Get input recursively
%
            function [output, visited] = init_node(node_i, visited)
%
%               General node base case: If node has already been visited
%               return output
%
                if visited(node_i)
                    output = obj.nodes{node_i}.output;
                    return
                end
%
%               Get index of all input nodes
%
                input_idx = find(obj.adjacency(:, node_i))';
%
%               Input node base case: If node has no inputs it must be an
%               input node so we will initialise it and grab the output
%
                if isempty(input_idx)
                    obj.nodes{node_i}.initialise(obj.solver, []);
                    output = obj.nodes{node_i}.output;
                    visited(node_i) = true;
                    return
                end
%
%               Loop through input nodes and get outputs
%
                output = 0;
                for idx = input_idx
                    [temp, visited] = init_node(idx, visited);
                    output = temp + output;
                end
%
%               Initialise node
%
                obj.nodes{node_i}.initialise(obj.solver, output);
                output = obj.nodes{node_i}.output;
                visited(node_i) = true;
            end
        end
%
        function step(obj)
%
%           Step all nodes in network forward in time
%
            for t_curr = obj.t(2 : end)
                obj.solver.update(t_curr);
                visited = false(size(obj.nodes));
                for node_i = 1 : numel(obj.nodes)
                    [~, visited] = step_node(node_i, visited);
                end
            end
%
%           Step node recursively
%
            function [output, visited] = step_node(node_i, visited)
%
%               General node base case: If node has already been visited
%               return output
%
                if visited(node_i)
                    output = obj.nodes{node_i}.output;
                    return
                end
%
%               Get index of all input nodes
%
                input_idx = find(obj.adjacency(:, node_i))';
%
%               Input node base case: If node has no inputs it must be an
%               input node so we will step it and grab the output
%
                if isempty(input_idx)
                    obj.nodes{node_i}.step();
                    output = obj.nodes{node_i}.output;
                    visited(node_i) = true;
                    return
                end
%
%               Loop through input nodes and get outputs
%
                output = 0;
                for idx = input_idx
                    [temp, visited] = step_node(idx, visited);
                    output = temp + output;
                end
%
%               Step node
%
                obj.nodes{node_i}.input = output;
                obj.nodes{node_i}.step();
                output = obj.nodes{node_i}.output;
                visited(node_i) = true;
            end
        end
%
        function terminate(obj)
%
%           Call termination method on all nodes
%
            for node = 1 : numel(obj.nodes)
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