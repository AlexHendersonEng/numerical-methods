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
%   Set states
%
    for state_n = 1 : obj.n_states
        set_state(states(state_n), obj, obj.state_idx{state_n});
    end
%
%   Update blocks
%
    Simulation.update_blocks(obj, t);
end
%
function set_state(state, parent, block_tree)
%
%   Loop through block tree
%
    for block_i = block_tree
        blocks = parent.blocks;
        parent = blocks{block_i};
    end
%
%   Set state
%
    parent.state = state;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%