%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% accuracy for testing ODE solver accuracy
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
h = 0.1;
t = 0 : h : 10;
lam = 0.5;
%
% Analytical solution
%
y = exp(lam .* t);
%
% Configure blocks
%
blocks = {Integrator(Tensor(1));
          Gain(Tensor(lam));
          L1(t, y)};
%
% Configure simulation
%
connections = [1, 1, 2, 1;
               2, 1, 1, 1;
               1, 1, 3, 1];
sim = Simulation(blocks, connections, ...
                 't_span', [t(1), t(end)], ...
                 'h', h, ...
                 'solver', 'euler_forward', ...
                 'logs_info', containers.Map({'output', 'loss'}, ...
                                             {[1, 1], [3, 1]}), ...
                 'restart', true);
%
% Run simulation
%
logs_out1 = sim.run();
%
sim.solver_select = SolverSelect.runge_kutta4;
logs_out2 = sim.run();
%
sim.solver_select = SolverSelect.euler_backward;
logs_out3 = sim.run();
%
% Plot simulation logs
%
fig = figure();
ax = axes(fig);
plot(ax, logs_out1('loss').time, logs_out1('loss').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Euler Forward');
hold(ax, 'on');
plot(ax, logs_out2('loss').time, logs_out2('loss').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Runge Kutta 4');
plot(ax, logs_out3('loss').time, logs_out3('loss').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Euler Backward');
hold(ax, 'off');
ax.YScale = 'log';
grid(ax, 'on');
xlabel(ax, 'Time (s)');
ylabel(ax, 'Error');
legend(ax, 'Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%