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
% Set up 'black box' model
%
nodes = {Input(u, u_t), ...
         Gain(2), ...
         TF1(1, 0)};
adjacency = [0, 1, 0;
             0, 0, 1;
             0, 0, 0];
%
% Run 'black box' simulation
%
sim_man = SimulationManager(nodes, adjacency, solver);
for step = 1 : numel(t) - 1
    sim_man.step();
end
sim_man.terminate();
%
% Extract data
%
y_t = t;
y = sim_man.nodes{end}.logger.output;
%
% Set up surrogate model
%
nodes = {Input(u, u_t), ...
         Gain(1), ...
         TF1(1, 0), ...
         L2(y, y_t)};
adjacency = [0, 1, 0, 0;
             0, 0, 1, 0;
             0, 0, 0, 1;
             0, 0, 0, 0];
%
% Optimise surrogate model
%
solver.t = t(1);
sim_man = SimulationManager(nodes, adjacency, solver);
optim = Adam(nodes, adjacency, 0.02);
for epoch = 1 : 200
%
%   Initialise error
%
    error = 0;
%
%   Reset simulation
% 
    sim_man.reset();
    solver.t = t(1);
    optim.zero_grad();
%
%   Run simulation
%
    for step = 1 : numel(t) - 1
        sim_man.step();
        optim.backward();
    end
    sim_man.terminate();
    error = error + sim_man.nodes{end}.output;
%
%   Print error and step optimiser
%
    disp("Epoch: " + num2str(epoch) + ", Error: " + num2str(error));
    optim.step();
end
%
% Plot 'black box' outputs vs surrogate
%
figure();
plot(sim_man.nodes{1}.logger.t, sim_man.nodes{1}.logger.output, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold('on');
plot(y_t, y, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Black Box');
plot(sim_man.nodes{end - 1}.logger.t, sim_man.nodes{end - 1}.logger.output, ...
     'LineWidth', 1.5, ...
     'LineStyle', '--', ...
     'DisplayName', 'Surrogate');
hold('off');
grid('on');
xlabel('Time (s)');
ylabel('Output');
legend('Location', 'northeast')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%