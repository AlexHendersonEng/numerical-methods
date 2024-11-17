%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% simulation_test for testing simulation framework idea
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Clear and close all
%
clear all; close all; clc;
%
% Add paths
%
[file_dir, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(file_dir, '..', 'components'));
addpath(fullfile(file_dir, '..', 'optimisers'));
%
% Inputs
%
u_t = [0, 1, 1 + 1e-6, 10];
u = [0, 0, 1, 1];
h = 0.01;
t = 0 : h : 10;
%
% Configure blocks
%
blocks = {Input(u_t, u);
          Gain(Tensor(5));
          Gain(Tensor(5));
          Operator('+--');
          Integrator(Tensor(0));
          Integrator(Tensor(0))};
%
% Configure simulation
%
connections = [1, 1, 2, 1;
               2, 1, 4, 1;
               5, 1, 4, 2;
               6, 1, 3, 1;
               3, 1, 4, 3;
               4, 1, 5, 1;
               5, 1, 6, 1];
sim = Simulation(blocks, connections, ...
                 't_span', [0, 10], ...
                 'h', h, ...
                 'solver', 'euler_backward', ...
                 'logs_info', containers.Map({'input', 'output'}, ...
                                             {[1, 1], [6, 1]}));
%
% Run simulation
%
sim.run();
%
% Plot simulation block graph
%
figure();
sim.plot_digraph();
%
% Plot simulation logs
%
figure();
plot(sim.logs_out('input').time, sim.logs_out('input').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold('on');
plot(sim.logs_out('output').time, sim.logs_out('output').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Output');
grid('on');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%