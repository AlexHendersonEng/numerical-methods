%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% parameters method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function params = get_parameters(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Loop over blocks in simulation and get parameters
%
    params = [];
    for block_i = 1 : obj.n_blocks
        if any(strcmpi(fieldnames(obj.blocks{block_i}), 'param'))
            params = [params, obj.blocks{block_i}.param];
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%