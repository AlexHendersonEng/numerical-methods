%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% step method of simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function step(obj)
%
%   Step blocks
%
    for exec_i = 1 : obj.n_blocks
%
%       Get execution block
%
        block_i = obj.order(exec_i);
%
%       Loop through input blocks
%
        input_idx = obj.connections((obj.connections(:, 3) == block_i), 1)';
        for dep_i = input_idx
%
%           Get output block
%
            outblock = obj.blocks{dep_i};
            outport_i = obj.connections(dep_i, 2);
%
%           Get input block
%
            inblock = obj.blocks{block_i};
            inport_i = obj.connections(dep_i, 4);
            inblock.input(inport_i) = outblock.output(outport_i);
        end
%
%       Step block
%
        obj.blocks{block_i}.step();
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%