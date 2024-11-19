%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% get_states method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function states = get_states(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Get states from state blocks
%
    states = arrayfun(@(block_tree) get_state(obj, block_tree), obj.state_idx);
end
%
function state = get_state(parent, block_tree)
%
%   Loop through block tree
%
    for block_i = block_tree{1}
        blocks = parent.blocks;
        parent = blocks{block_i};
    end
%
%   Get state
%
    state = parent.state;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%