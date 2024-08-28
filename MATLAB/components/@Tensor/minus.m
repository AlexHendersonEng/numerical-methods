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
%       Throw error if both tensors do not have some propagation mode
%
        if ~strcmpi(a.mode, b.mode)
            error('Tensor do not have same propagation mode');
        end
%
%       Compute resulting tensor
%
        c = Tensor(a.value - b.value, 'mode', a.mode);
%
%       Assign local gradients
%
        dcda = eye(numel(a.value));
        dcdb = -eye(numel(a.value));
        if strcmpi(a.mode, 'forward')
            a.local_grad(end + 1, :) = {c, dcda};
            b.local_grad(end + 1, :) = {c, dcdb};
        else
            c.local_grad(end + 1 : end + 2, :) = {a, dcda;
                                                  b, dcdb};
        end
%
%   Else if only a is a tensor
%
    elseif isa(a, 'Tensor')
%
%       Compute resulting tensor
%
        c = Tensor(a.value - b, 'mode', a.mode);
%
%       Assign local gradients
%
        dcda = eye(numel(a.value));
        if strcmpi(a.mode, 'forward')
            a.local_grad(end + 1, :) = {c, dcda};
        else
            c.local_grad(end + 1, :) = {a, dcda};
        end
%
%   Else only b is a tensor
%
    else
%
%       Compute resulting tensor
%
        c = Tensor(a - b.value, 'mode', b.mode);
%
%       Assign local gradients
%
        dcdb = -eye(numel(a));
        if strcmpi(b.mode, 'forward')
            b.local_grad(end + 1, :) = {c, dcdb};
        else
            c.local_grad(end + 1, :) = {b, dcdb};
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%