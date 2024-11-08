%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% initialise method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function initialise(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Determine index's to blocks containing a state within the simulation
%
    for block_i = 1 : obj.n_blocks
        if isa(obj.blocks{block_i}, 'Integrator')
            obj.state_idx(end + 1) = block_i;
        end
    end
    obj.n_states = numel(obj.state_idx);
%
%   Get block execution order
%
    count = 1;
    for block_i = 1 : obj.n_blocks
        count = obj.exec_order(block_i, count);
        if count > obj.n_blocks; break; end
    end
%
%   Initialise blocks
%
    for exec_i = 1 : obj.n_blocks
%
%       Get execution block
%
        block_i = obj.order(exec_i);
%
%       Update block
%
        obj.blocks{block_i}.update(obj.t);
%
%       Update inputs of downstream blocks
%
        downstream_i = obj.connections((obj.connections(:, 1) == block_i), 1)';
        for down_i = downstream_i
%
%           Get blocks and ports
%
            inblock = obj.blocks{obj.connections(down_i, 3)};
            inport_i = obj.connections(down_i, 4);
            outport_i = obj.connections(down_i, 2);
%
%           Update input
%
            inblock.input(inport_i) = obj.blocks{block_i}.output(outport_i);
        end
    end
%
%   Initialise simulation step infomation
%
    obj.step_idx = 1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%