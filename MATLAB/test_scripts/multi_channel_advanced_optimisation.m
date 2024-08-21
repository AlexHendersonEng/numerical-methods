%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% multi_channel_advanced_optimisation script for optimising a surrogate
% model
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
t = (0 : h : 10)';
solver = RK4(t(1), h);
u = repmat([0, 0, 1, 1]', 1, 3);
u_t = [0, 1, 1 + 1e-3, 10]';
%
% Set up 'black box' model
%
nodes = {Input(u, u_t), ...
         Gain([2, 1.5, 2.5]), ...
         TF1([1, 0.5, 1.5], [0, 0, 0]), ...
         Add()};
adjacency = [0, 1, 0, 0;
             0, 0, 1, 0;
             0, 0, 0, 1;
             0, 0, 0, 0];
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
         Gain([0.9, 1, 1.1]), ...
         TF1([0.1, 0.2, 0.3], [0, 0, 0]), ...
         Add(), ...
         L2(y, y_t)};
adjacency = [0, 1, 0, 0, 0;
             0, 0, 1, 0, 0;
             0, 0, 0, 1, 0;
             0, 0, 0, 0, 1;
             0, 0, 0, 0, 0];
%
% Optimise surrogate model
%
solver.t = t(1);
sim_man = SimulationManager(nodes, adjacency, solver);
optim = PSO(nodes, ...
            adjacency, ...
            @(x) loss_fcn(x, sim_man, t), ...
            'lb', repmat(0.1, 1, 6), ...
            'ub', repmat(10, 1, 6));
optim.backward()
for iter = 1 : 50
    optim.step();
    optim.backward();
    disp("Iter: " + num2str(iter) + ", Loss: " + num2str(optim.best_particle.loss));
end
%
% Apply best params found
%
x = optim.best_particle.x;
for node_i = 1 : numel(sim_man.nodes)
    params = sim_man.nodes{node_i}.parameters();
    param_update = x(1 : numel(params)) - params;
    sim_man.nodes{node_i}.update(param_update);
    x(1 : numel(params)) = [];
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
% Cost function
%
function loss = loss_fcn(x, sim_man, t)
%
%   Initialise loss
%
    loss = 0;
%
%   Initialise nodes
%
    for node_i = 1 : numel(sim_man.nodes)
        params = sim_man.nodes{node_i}.parameters();
        param_update = x(1 : numel(params)) - params;
        sim_man.nodes{node_i}.update(param_update);
        x(1 : numel(params)) = [];
    end
%
%   Reset simulation
% 
    sim_man.reset();
    sim_man.solver.t = t(1);
%
%   Run simulation
%
    for step = 1 : numel(t) - 1
        sim_man.step();
        loss = loss + sim_man.nodes{end}.output;
    end
    sim_man.terminate();
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%