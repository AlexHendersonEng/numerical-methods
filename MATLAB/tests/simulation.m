%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% simulation for testing simulation framework idea
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
          Integrator(Tensor(0));
          TF1(Tensor(0), Tensor(1))};
%
% Configure simulation
%
connections = [1, 1, 2, 1;
               2, 1, 4, 1;
               5, 1, 4, 2;
               6, 1, 3, 1;
               3, 1, 4, 3;
               4, 1, 5, 1;
               5, 1, 6, 1;
               1, 1, 7, 1];
sim = Simulation(blocks, connections, ...
                 't_span', [t(1), t(end)], ...
                 'h', h, ...
                 'solver', 'euler_backward', ...
                 'logs_info', containers.Map({'input', 'output1', 'output2'}, ...
                                             {[1, 1], [6, 1], [7, 1]}));
%
% Run simulation
%
logs_out = sim.run();
%
% Plot simulation block graph
%
figure();
sim.plot_digraph();
%
% Plot simulation logs
%
figure();
plot(logs_out('input').time, logs_out('input').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold('on');
plot(logs_out('output1').time, logs_out('output1').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Output 1');
plot(logs_out('output2').time, logs_out('output2').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Output 2');
hold('off');
grid('on');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%