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
          Operator('+-');
          Gain(Tensor(1));
          Integrator(Tensor(0))};
%
% Configure simulation
%
connections = [1, 1, 2, 1;
               2, 1, 3, 1;
               3, 1, 4, 1;
               4, 1, 2, 2];
sim = Simulation(blocks, connections, ...
                 't_span', [0, 10], ...
                 'h', h, ...
                 'solver', 'runge_kutta4', ...
                 'logs_info', containers.Map({'output'}, {[4, 1]}));
%
% Run simulation
%
sim.run();
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%