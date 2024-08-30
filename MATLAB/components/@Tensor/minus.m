%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor minus method for overloading the subtraction operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = minus(a, b)
%
%   If both a and b are tensors
%
    if isa(a, 'Tensor') && isa(b, 'Tensor')
%
%       If a and b are the same tensor
%
        if a == b
            c = Tensor(zeros(size(a.value))) + zeros(size(a.value));
            return
        end
%
%       Compute resulting tensor
%
        c = Tensor(a.value - b.value);
%
%       Assign local gradients
%
        dcda = eye(numel(a.value));
        dcdb = -eye(numel(a.value));
        c.local_grad(end + 1 : end + 2, :) = {a, dcda;
                                              b, dcdb};
%
%   Else if only a is a tensor
%
    elseif isa(a, 'Tensor')
%
%       Compute resulting tensor
%
        c = Tensor(a.value - b);
%
%       Assign local gradients
%
        dcda = eye(numel(a.value));
        c.local_grad(end + 1, :) = {a, dcda};
%
%   Else only b is a tensor
%
    else
%
%       Compute resulting tensor
%
        c = Tensor(a - b.value);
%
%       Assign local gradients
%
        dcdb = -eye(numel(a));
        c.local_grad(end + 1, :) = {b, dcdb};
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%