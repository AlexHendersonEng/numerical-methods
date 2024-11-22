%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% frequency_analysis script analysing the frequency response of a first
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
[file_dir, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(file_dir, '..', 'components'));
addpath(fullfile(file_dir, '..', 'optimisers'));
addpath(fullfile(file_dir, '..', 'utilities'));
%
% Set random generator seed for repeatability
%
rng(0);
%
% Inputs
%
Fs = 100;
h = 1 / Fs;
t_span = [0, 10];
t = t_span(1) : h : t_span(2);
u_t = t;
u = randn(size(u_t));
omega = 1;
%
% Configure blocks
%
blocks = {Input(u_t, u);
          TF1(Tensor(0), Tensor(omega))};
connections = [1, 1, 2, 1];
%
% Configure simulation
%
sim = Simulation(blocks, connections, ...
                 't_span', t_span, ...
                 'h', h, ...
                 'solver', 'euler_forward', ...
                 'logs_info', containers.Map({'input', 'output'}, ...
                                             {[1, 1], [2, 1]}));
%
% Run simulation
%
sim.run();
%
% Input frequency analysis
%
U = dft(u);
U = U(1 : ceil(numel(u) / 2));
f_u = (Fs / numel(u)) * (0 : numel(U) - 1);
u_amplitude = abs(U / numel(u));
%
% Output frequency analysis
%
y = sim.logs_out('output').data;
Y = dft(y);
Y = Y(1 : ceil(numel(y) / 2));
f_y = (Fs / numel(y)) * (0 : numel(Y) - 1);
y_amplitude = abs(Y / numel(Y));
%
% Filter frequency response
%
G = sqrt(1 ./ (1 + (1 / omega) * f_y .^ 2));
%
% Plot simulation logs
%
figure();
keys = sim.logs_out.keys;
for key_i = 1 : numel(keys)
    plot(sim.logs_out(keys{key_i}).time, sim.logs_out(keys{key_i}).data, ...
         'LineWidth', 1.5, ...
         'DisplayName', keys{key_i});
    hold('on');
end
hold('off');
grid('on');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Location', 'northeast');
%
% Plot frequency
%
figure();
plot(f_u, u_amplitude, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Input');
hold('on');
plot(f_y, y_amplitude, ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Output');
plot(f_y, G * u_amplitude(2), ...
     'LineWidth', 1.5, ...
     'Color', 'k', ...
     'DisplayName', 'Filter');
hold('off');
set(gca, 'XScale', 'log', 'YScale', 'log');
grid('on');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
legend('Location', 'northeast');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%