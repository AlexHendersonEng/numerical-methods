%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% update method for Operator class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function update(obj, ~)
%
%   Input handling
%
    arguments
        obj Operator;
        ~;
    end
%
%   Update output
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