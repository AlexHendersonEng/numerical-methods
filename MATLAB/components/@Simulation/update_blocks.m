%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% update_blocks static method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function update_blocks(obj, t)
%
%   Update blocks
%
    for block_i = obj.order
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