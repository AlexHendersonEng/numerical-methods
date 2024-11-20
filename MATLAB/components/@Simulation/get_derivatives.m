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
%   Get derivatives from state blocks
%
    derivatives = cellfun(@(block_tree) get_derivative(obj, block_tree), obj.state_idx);
end
%
function derivative = get_derivative(parent, block_tree)
%
%   Loop through block tree
%
    for block_i = block_tree
        blocks = parent.blocks;
        parent = blocks{block_i};
    end
%
%   Get derivative
%
    derivative = parent.input;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%