%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% update method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function update(obj, states, t)
%
%   Input handling
%
    arguments
        obj Simulation;
        states;
        t double;
    end
%
%   Set integrator states
%
    for state_n = 1 : obj.n_states
        state_i = obj.state_idx(state_n);
        obj.blocks{state_i}.state = states(state_n);
    end
%
%   Update blocks
%
    for exec_i = 1 : obj.n_blocks
%
%       Get execution block
%
        block_i = obj.order(exec_i);
%
%       Update block
%
        obj.blocks{block_i}.update(t);
%
%       Update inputs of downstream blocks
%
        downstream_i = find(obj.connections(:, 1) == block_i)';
        for down_i = downstream_i
%
%           Get blocks and ports
%
            inblock = obj.blocks{obj.connections(down_i, 3)};
            inport_i = obj.connections(down_i, 4);
            outport_i = obj.connections(down_i, 2);
%
%           Update inputs
%
            inblock.input(inport_i) = obj.blocks{block_i}.output(outport_i);
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%