%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% get_derivatives method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function derivatives = get_derivatives(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Loop over state blocks and get derivatives
%
    derivatives = repmat(Tensor(0), 1, obj.n_states);
    for state_n = 1 : obj.n_states
        state_i = obj.state_idx(state_n);
        derivatives(state_n) = obj.blocks{state_i}.input;
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%