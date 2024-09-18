%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% optimisation script for optimising a surrogate model
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
% Analytical solution
%
t = (0 : 0.01 : 10)';
y = 2 * (1 - exp(-t));
y1 = ones(size(t));
%
% Training parameters
%
n_epochs = 100;
lr = 1e-1;
%
% Set up surrogate model
%
h = 0.01;
solver = RK4(t(1), h);
blocks = {Input([1, 1]', [0, 10]'), ...
          Split(2), ...
          TF1(0, 2), ...
          Gain(1), ...
          L2(y, t), ...
          Gain(2), ...
          L2(y1, t)};
connections = [1, 1, 2, 1;
               2, 1, 3, 1;
               3, 1, 4, 1;
               4, 1, 5, 1;
               2, 2, 6, 1;
               6, 1, 7, 1];
sim = Simulation(blocks, connections, solver, numel(t));
optim = Adam(sim.parameters(), 'lr', lr);
%
% Train surrogate model
%
for epoch = 1 : n_epochs
%
%   Reset epoch error
%
    epoch_error = 0;
%
%   Zero gradients and reset simulation
%
    sim.blocks{5}.output.zero_grad();
    sim.blocks{7}.output.zero_grad();
    solver.t = t(1);
    sim.reset();
%
%   Run simulation
%
    for step = 1 : numel(t) - 1
%
%       Reset computational graph      
%
        sim.blocks{5}.output.reset_graph();
        sim.blocks{7}.output.reset_graph();
%
%       Step simulation
%
        solver.update();
        sim.step();
%
%       Accumulate epoch error
%
        epoch_error = epoch_error + ...
                      sim.blocks{5}.output.value + ...
                      sim.blocks{7}.output.value;
%
%       Accumulate gradients
%
        sim.blocks{5}.output.backward();
        sim.blocks{7}.output.backward();
    end
%
%   Terminate simulation
%
    sim.terminate();
%
%   Step optimiser
%
    optim.step();
%
%   Print param value
%
    disp("Epoch: " + num2str(epoch) + ", Error: " + num2str(epoch_error) + ...
         ", Param Value: " + num2str([optim.params.value]));
end
%
% Plot actual versus surrogate respons
%
figure();
plot(t, y, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Actual Output 1');
hold('on');
plot(t, [sim.blocks{4}.logger.output.value], ...
     'LineWidth', 1.5, ...
     'LineStyle', '--', ...
     'DisplayName', 'Surrogate Output 1');
plot(t, y1, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Actual Output 2');
plot(t, [sim.blocks{6}.logger.output.value], ...
     'LineWidth', 1.5, ...
     'LineStyle', '--', ...
     'DisplayName', 'Surrogate Output 2');
hold('off');
grid('on');
xlabel('Time (s)');
ylabel('Output');
legend('Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%