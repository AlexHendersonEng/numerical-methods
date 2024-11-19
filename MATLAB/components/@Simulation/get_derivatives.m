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
    derivatives = arrayfun(@(block_tree) get_derivative(obj, block_tree), obj.state_idx);
end
%
function state = get_derivative(parent, block_tree)
%
%   Loop through block tree
%W
    for block_i = block_tree{1}
        blocks = parent.blocks;
        parent = blocks{block_i};
    end
%
%   Get derivative
%
    state = parent.input;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%