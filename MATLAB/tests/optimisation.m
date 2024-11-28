%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% optimisation for testing parameter optimisation
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
% Load training data
%
load('train_data.mat', 'train_data');
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
          TF1(Tensor(0), Tensor(2));
          Gain(1);
          L2(train_data.time, train_data.data)};
%
% Configure simulation
%
connections = [1, 1, 2, 1;
               2, 1, 3, 1;
               3, 1, 4, 1];
sim = Simulation(blocks, connections, ...
                 't_span', [0, 10], ...
                 'h', h, ...
                 'solver', 'euler_forward', ...
                 'logs_info', containers.Map({'output', 'loss'}, ...
                                             {[3, 1], [4, 1]}), ...
                 'restart', true, ...
                 'post_init_fcn', @(sim) post_init_fcn(sim), ...
                 'pre_step_fcn', @(sim) pre_step_fcn(sim), ...
                 'post_step_fcn', @(sim) post_step_fcn(sim));
%
% Run simulation
%
params = sim.get_parameters();
n_params = numel(params);
x0 = arrayfun(@(tensor) tensor.value, params);
adam_optim(@(x) loss_fcn(x, sim, params, n_params), ...
           x0, ...
           'lr', 1e-2, ...
           'max_iter', 200, ...
           'jacobian', @(x) jacobian_fcn(params, n_params), ...
           'lr_scheduler', @(lr, iter, f_val) lr_scheduler(lr, iter));
%
% Plot result comparison
%
figure();
plot(u_t, u, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold('on');
plot(train_data.time, train_data.data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Actual Output');
plot(sim.logs_out('output').time, sim.logs_out('output').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Surrogate Output');
hold('off');
grid('on');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Location', 'northeast');
%
% Post-init function
%
function post_init_fcn(sim)
%
%   Zero gradients
%
    sim.blocks{end}.output.zero_grad();
end
%
% Pre-step function
%
function pre_step_fcn(sim)
%
%   Reset tensor computational graph
%
    sim.blocks{end}.output.reset_graph();
end
%
% Post-step function
%
function post_step_fcn(sim)
%
%   Back propagate gradients
%
    sim.blocks{end}.output.backward();
end
%
% Loss function
%
function loss = loss_fcn(x, sim, params, n_params)
%
%   Update parameters
%
    for n = 1 : n_params
        params(n).value = x(n);
    end
%
%   Run simulation
%
    sim.run();
%
%   Calculate loss
%
    loss = mean(sim.logs_out('loss').data) .^ 2;
end
%
% Jacobian function
%
function jacobian = jacobian_fcn(params, n_params)
%
%   Get jacobian
%
    jacobian = zeros(1, n_params);
    for n = 1 : n_params
        jacobian(n) = params(n).grad;
    end
end
%
% Learning rate scheduler function
%
function lr = lr_scheduler(lr, iter)
%
%   Adjust learnig rate
%
    if mod(iter, 100) == 0
        lr = lr * 0.5;
        disp("Learning rate: " + num2str(lr));
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%