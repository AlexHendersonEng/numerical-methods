%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test script for testing simulation framework
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear all; close all; clc;
%
% Inputs
%
tspan = [0, 10];
solver = EulerBackward(0.01);
u = [0, 0, 1, 1];
u_t = [0, 1, 1 + 1e-3, 10];
%
% Set up graph
%
nodes = {TF1(1, 0), ...
         TF1(1, 0), ...
         Input(u, u_t), ...
         TF1(1, 0), ...
         Gain(2)};
adjacency = [0, 0, 0, 0, 0;
             0, 0, 0, 0, 1;
             0, 1, 0, 1, 0;
             1, 0, 0, 0, 1;
             0, 0, 0, 0, 0];
%
% Run simulation
%
sim_man = SimulationManager(nodes, adjacency, solver);
sim_man.run(tspan);
%
% Plot outputs
%
sim_man.plot_digraph();
sim_man.plot_results();
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%