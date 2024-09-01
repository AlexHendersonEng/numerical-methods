%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Similation class for implementation of a simulation object
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Simulation < handle
%
    properties
        blocks
        n_blocks
        connections % n x 4 matrix [block1, outport, block2, inport;
                    %               block2, outport, block3, inport;
                    %               ...]
        solver
        order % Block index execution order
        n_steps
    end
%
    methods
        function obj = Simulation(blocks, connections, solver, n_steps)
%
%           Input validation
%
            arguments
                blocks
                connections
                solver
                n_steps = 1
            end
%
%           Assign variables
%
            obj.blocks = blocks;
            obj.n_blocks = numel(obj.blocks);
            obj.connections = connections;
            obj.solver = solver;
            obj.n_steps = n_steps;
%
%           Initialise network
%
            obj.initialise();
        end
%
        initialise(obj);
%
        step(obj);
%
        terminate(obj);
%
        reset(obj);
%
        plot_digraph(obj);
%
        count = exec_order(obj, block_i, count);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%