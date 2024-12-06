%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% optimisation_SIMO for testing parameter optimisation in a single input,
% multiple output system
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
load('train_data_SIMO.mat', 'train_data1', 'train_data2');
%
% Inputs
%
u_t = [0, 1, 1 + 1e-6, 10];
u = [0, 0, 1, 1];
h = 0.1;
t = 0 : h : 10;
%
% Configure blocks
%
blocks = {Input(u_t, u);
          TF1(Tensor(0), Tensor(1.5));
          Gain(1);
          Derivative(h);
          Gain(1);
          L2(train_data1.time, train_data1.data);
          L2(train_data2.time, train_data2.data)};
%
% Configure simulation
%
connections = [1, 1, 2, 1;
               2, 1, 3, 1;
               2, 1, 4, 1;
               4, 1, 5, 1;
               3, 1, 6, 1;
               5, 1, 7, 1];
sim = Simulation(blocks, connections, ...
                 't_span', [t(1), t(end)], ...
                 'h', h, ...
                 'solver', 'euler_forward', ...
                 'logs_info', containers.Map({'output1', 'output2', 'loss1', 'loss2'}, ...
                                             {[3, 1], [5, 1], [6, 1], [7, 1]}), ...
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
           'max_iter', 1e3, ...
           'jacobian', @(x) jacobian_fcn(params, n_params), ...
           'lr_scheduler', @(lr, iter, f_val) lr_scheduler(lr));
%
% Plot result comparison
%
figure();
plot(u_t, u, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold('on');
plot(train_data1.time, train_data1.data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Actual Output 1');
plot(train_data2.time, train_data2.data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Actual Output 2');
plot(sim.logs_out('output1').time, sim.logs_out('output1').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Surrogate Output 1');
plot(sim.logs_out('output2').time, sim.logs_out('output2').data, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Surrogate Output 2');
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
    sim.blocks{end - 1}.output.backward();
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
    logs_out = sim.run();
%
%   Calculate loss
%
    loss = mean(logs_out('loss1').data + logs_out('loss2').data) .^ 2;
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
function lr = lr_scheduler(lr)
%
%   Adjust learnig rate
%

end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%