%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% basic_simulation script for testing simulation framework
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Clear and close all
%
clear all; close all; clc;
%
% Add paths
%
file_path = mfilename('fullpath');
[path, ~, ~] = fileparts(file_path);
addpath(fullfile(path, '..', 'ode_solvers'));
addpath(fullfile(path, '..', 'optimisers'));
addpath(fullfile(path, '..', 'simulator_components'));
%
% Inputs
%
h = 0.01;
t = 0 : h : 10;
solver = RK4(t(1), h);
u = [0, 0, 1, 1];
u_t = [0, 1, 1 + 1e-3, 10];
%
% Set up graph
%
nodes = {TF1(1, 0), ...
         TF1(1, 0), ...
         Input(u, u_t), ...
         TF1(1, 0), ...
         Gain(2)};
adjacency = [0, 0, 0, 0, 0;
             0, 0, 0, 0, 1;
             0, 1, 0, 1, 0;
             1, 0, 0, 0, 1;
             0, 0, 0, 0, 0];
%
% Run simulation
%
sim_man = SimulationManager(nodes, adjacency, solver);
for step = 1 : numel(t) - 1
    sim_man.step();
end
sim_man.terminate();
%
% Plot outputs
%
sim_man.plot_digraph();
%
% Plot the output of all nodes against time
%
figure();
for node_i = 1 : sim_man.n_nodes
    plot(sim_man.nodes{node_i}.logger.t, sim_man.nodes{node_i}.logger.output, ...
         'LineWidth', 1.5, ...
         'DisplayName', ['Node: ', num2str(node_i)]);
    hold('on');
end
hold('off');
grid('on');
xlabel('Time (s)');
ylabel('Output');
legend('Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%