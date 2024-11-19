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
%   Initialise simulation time and empty state index array
%
    obj.t = obj.t_span(1);
    obj.state_idx = {};
%
%   Determine index's to blocks containing a state within the simulation
%
    for block_i = 1 : obj.n_blocks
        get_state_idx(obj, ...
                      obj.blocks{block_i}, ...
                      block_i);
    end
    obj.n_states = numel(obj.state_idx);
%
%   Get block execution order
%
    count = 1;
    for block_i = 1 : obj.n_blocks
        count = Simulation.exec_order(obj, block_i, count);
        if count > obj.n_blocks; break; end
    end
%
%   Initialise blocks
%
    states = obj.get_states();
    obj.update(states, obj.t);
%
%   Initialise simulation step infomation
%
    obj.step_idx = 1;
end
%
function get_state_idx(obj, block, block_tree)
%
%   If block has state add to state index list
%
    if any(strcmpi(fieldnames(block), 'state'))
        obj.state_idx(end + 1) = {block_tree};
    end
%
%   If block has no sub-blocks return
%
    if ~any(strcmpi(fieldnames(block), 'blocks'))
        return
    end 
%
%   Loop through sub-blocks and get state index
%
    for block_i = 1 : numel(block.blocks)
        get_state_idx(obj, ...
                      block.blocks{block_i}, ...
                      [block_tree, block_i]);
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%