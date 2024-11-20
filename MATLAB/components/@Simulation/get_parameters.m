%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% get_parameters method of Simulation class
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
        param = get_paramter(obj.blocks{block_i}, []);
        params = [params, param];
    end
end
%
function param = get_paramter(parent, param)
%
%   If block has param property add parameter to parameter array
%
    if any(strcmpi(fieldnames(parent), 'param'))
        param = [param, parent.param];
    end
%
%   If block has sub-blocks recursively get parameters of sub-blocks
%
    if any(strcmpi(fieldnames(parent), 'blocks'))
        for block_i = 1 : numel(parent.blocks)
            param = get_paramter(parent.blocks{block_i}, param);
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%