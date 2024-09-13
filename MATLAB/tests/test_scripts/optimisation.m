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
%
% Training parameters
%
n_epochs = 500;
lr = 1e-2;
%
% Set up surrogate model
%
h = 0.01;
solver = RK4(t(1), h);
blocks = {Input([1, 1]', [0, 10]'), ...
          TF1(0, 2), ...
          Gain(1), ...
          L2(y, t)};
connections = [1, 1, 2, 1;
               2, 1, 3, 1;
               3, 1, 4, 1];
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
    sim.blocks{end}.output.zero_grad();
    sim.reset();
    solver.t = t(1);
%
%   Run simulation
%
    for step = 1 : numel(t) - 1
%
%       Reset computational graph      
%
        sim.blocks{end}.output.reset_graph();
%
%       Step simulation
%
        solver.update();
        sim.step();
%
%       Accumulate epoch error
%
        epoch_error = epoch_error + sim.blocks{end}.output.value;
%
%       Accumulate gradients
%
        sim.blocks{end}.output.backward();
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%