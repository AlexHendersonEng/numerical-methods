%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% update_logging method of the Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function update_logging(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Loop over logged signals
%
    keys = obj.logs_info.keys;
    for key_i = 1 : numel(keys)
%
%       Get block and port location for logged signal
%
        loc = obj.logs_info(keys{key_i});
        block_i = loc{1}(1);
        port_i = loc{1}(2);
%
%       Update log
%
        log = obj.logs_out(keys{key_i});
        log.data(obj.step_idx) = obj.blocks{block_i}.output(port_i);
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%