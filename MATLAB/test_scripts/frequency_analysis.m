%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% frequency_analysis script for analysing the frequency response of a first
% order transfer function
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
addpath(fullfile(path, '..', 'utilities'));
%
% Set random generator seed for repeatability
%
rng(0);
%
% Inputs
%
Fs = 100;                 
T = 1 / Fs;     
t = 0 : T : 10;
u_t = t;
u = randn(size(u_t));
solver = RK4(t(1), T);
omega = 1;
%
% Set up graph
%
nodes = {Input(u, u_t), ...
         TF1(omega, 0)};
adjacency = [0, 1;
             0, 0];
%
% Run simulation
%
sim_man = SimulationManager(nodes, adjacency, solver);
for step = 1 : numel(t) - 1
    sim_man.step();
end
sim_man.terminate();
%
% Input frequency analysis
%
U = dft(u);
U = U(1 : ceil(numel(u) / 2));
f_u = (Fs / numel(u)) * (0 : numel(U) - 1);
%
% Output frequency analysis  
%
y = sim_man.nodes{2}.logger.output;
Y = dft(y);
Y = Y(1 : ceil(numel(y) / 2));
f_y = (Fs / numel(y)) * (0 : numel(U) - 1);
%
% Filter frequency response
%
G = sqrt(1 ./ (1 + f_y .^ 2));
%
% Plot the output of all nodes against time
%
figure();
for node_i = 1 : sim_man.n_nodes
    plot(t, sim_man.nodes{node_i}.logger.output, ...
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
% Plot frequency
%
figure();
plot(f_u, abs(U / numel(u)), ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold on;
plot(f_y, abs(Y / numel(y)), ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Output');
plot(f_y, G, ...
     'LineWidth', 1.5, ...
     'Color', 'k', ...
     'DisplayName', 'Filter');
hold off;
set(gca, 'XScale', 'log', 'YScale', 'log');
grid('on');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
legend('Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%