%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% initialise method of operator class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function initialise(obj, solver, n_steps)
%
%   Input handling
%
    arguments
        obj
        solver
        n_steps
    end
%
%   Call superclass method
%
    initialise@Block(obj, solver, n_steps);
%
%   Initialise output
%
    obj.output = Tensor(0);
    for op_i = 1 : numel(obj.operations)
        switch obj.operations(op_i)
            case '+'
                obj.output = obj.output + obj.input(op_i);
            case '-'
                obj.output = obj.output - obj.input(op_i);
            case '*'
                obj.output = obj.output .* obj.input(op_i);
            case '/'
                obj.output = obj.output ./ obj.input(op_i);
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%