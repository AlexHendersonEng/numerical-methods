%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% update method for Derivative class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function update(obj, t)
%
%   Input handling
%
    arguments
        obj Derivative;
        t double;
    end
%
%   Update input
%
    obj.blocks{1}.input(1) = obj.input;
    obj.blocks{2}.input(1) = obj.input;
%
%   Update TF1 blocks
%
    Simulation.update_blocks(obj, t);
%
%   Update output
%
    obj.output = obj.blocks{end}.output;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%