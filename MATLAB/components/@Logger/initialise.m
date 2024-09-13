%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% initialise method of logger class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function initialise(obj, block, n_steps)
%
%   Input handling
%
    arguments
        obj
        block
        n_steps = 1;
    end
%
%   Initialise logger
%
    obj.t = zeros(n_steps, 1);
    obj.input = repmat(Tensor(0), n_steps, numel(block.input));
    obj.output = repmat(Tensor(0), n_steps, numel(block.output));
    obj.n = 1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%