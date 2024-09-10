%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% exec_order method of simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function count = exec_order(obj, block_i, count)
%
%   General block base case: If block has already been added to
%   execution order return
%
    if any(block_i == obj.order)
        return
    end
%
%   Get index of all input blocks
%
    input_idx = obj.connections((obj.connections(:, 3) == block_i), 1)';
%
%   Input block base case: If block has no inputs it must be an
%   input block so we will add it to the execution order and increment the
%   count
%
    if isempty(input_idx)
        obj.order(end + 1) = block_i;
        count = count + 1;
        return
    end
%
%   Initial condition block base case: If block has dependent blocks all
%   with an initial conditions add to execution order
%
    ic_blocks = {'Memory', 'Integrator'};
    for dep_i = input_idx
        if ~any(strcmpi(class(obj.blocks{dep_i}), ic_blocks))
%
%           If current dependent block is not a block with initial
%           condition break loop and contiune
%
            break
        elseif dep_i == input_idx(end)
%
%           Else if all dependent blocks have been looped through and all
%           have initial conditions add to execution order and return
%
            obj.order(end + 1) = block_i;
            count = count + 1;
            return
        end
    end

%
%   Loop through input blocks and add them to execution order if required
%   and then add current block to execution order and increment count
%
    for dep_i = input_idx
        count = obj.exec_order(dep_i, count);
    end
    obj.order(end + 1) = block_i;
    count = count + 1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%