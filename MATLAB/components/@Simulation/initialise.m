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
%   Initialise simulation time and restart flag
%
    obj.t = obj.t_span(1);
    restart_flag = obj.restart && obj.run_count > 0;
%
%   Determine index's to blocks containing a state within the simulation if
%   required
%
    if ~restart_flag
        obj.state_idx = {};
        for block_i = 1 : obj.n_blocks
            get_state_idx(obj, ...
                          obj.blocks{block_i}, ...
                          block_i);
        end
        obj.n_states = numel(obj.state_idx);
    end
%
%   Get block execution order if required
%
    if ~restart_flag
        count = 1;
        for block_i = 1 : obj.n_blocks
            count = Simulation.exec_order(obj, block_i, count);
            if count > obj.n_blocks; break; end
        end
    end
%
%   Initialise blocks
%
    if ~restart_flag
%
%       Simulation is not being restarted either because restart is not
%       enabled or it is the first run
%
        states = obj.get_states();
        if obj.restart
            obj.restart_states = states;
        end
    else
%
%       Simulation is being restarted, so use restart states and call
%       restart method on all blocks
%
        states = obj.restart_states;
        for block_i = 1 : obj.n_blocks
            reset_block(obj.blocks{block_i});
        end
        
    end
%
%   Update simulation
%
    obj.update(states, obj.t);
%
%   Initialise simulation step index
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
function reset_block(block)
%
%   Call reset method on block
%
    block.reset();
%
%   If block has no sub-blocks return
%
    if ~any(strcmpi(fieldnames(block), 'blocks'))
        return
    end 
%
%   Loop through sub-blocks and reset
%
    for block_i = 1 : numel(block.blocks)
        reset_block(block.blocks{block_i});
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%