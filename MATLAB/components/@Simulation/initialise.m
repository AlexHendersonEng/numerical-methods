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
    obj.state_idx = [];
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
    states = obj.get_states();
    obj.update(states, obj.t);
%
%   Initialise simulation step infomation
%
    obj.step_idx = 1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%