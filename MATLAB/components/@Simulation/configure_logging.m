%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% configure_logging method of the Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function configure_logging(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Generate time data
%
    t = obj.t_span(1) : obj.h : obj.t_span(2);
    n_t = numel(t);
%
%   Configure logging structure
%
    keys = obj.logs_info.keys;
    obj.logs_out = containers.Map('KeyType', 'char', 'ValueType', 'any');
    for key_i = 1 : numel(keys)
        obj.logs_out(keys{key_i}) = LogData(t, zeros(1, n_t));
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%