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
addpath(fullfile(path, '..', '..', 'solvers'));
addpath(fullfile(path, '..', '..', 'optimisers'));
addpath(fullfile(path, '..', '..', 'components'));
%
% Inputs
%
h = 0.01;
t = (0 : h : 10)';
solver = RK4(t(1), h);
u = [0, 0, 1, 1]';
u_t = [0, 1, 1 + 1e-3, 10]';
%
% Set up graph
%
blocks = {Input(u, u_t), ...
          Split(2), ...
          TF1(0, 1), ...
          Gain(2), ...
          Noise(0, 0.01), ...
          L2([1, 1]', [0, 10]'), ...
          Gain(3)};
connections = [1, 1, 2, 1;
               2, 1, 3, 1;
               3, 1, 4, 1;
               4, 1, 5, 1;
               5, 1, 6, 1;
               2, 2, 7, 1];
%
% Run simulation
%
sim = Simulation(blocks, connections, solver, numel(t));
for step = 1 : numel(t) - 1
    solver.update();
    sim.step();
end
sim.terminate();
%
% Plot directed graph
%
sim.plot_digraph();
%
% Plot the output of all blocks against time
%
figure();
for block_i = 1 : sim.n_blocks
    for out_i = 1 : numel(sim.blocks{block_i}.output)
        plot(sim.blocks{block_i}.logger.t, [sim.blocks{block_i}.logger.output(:, out_i).value], ...
             'LineWidth', 1.5, ...
             'DisplayName', ['Block: ', num2str(block_i), ', Output: ', num2str(out_i)]);
        hold('on');
    end
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