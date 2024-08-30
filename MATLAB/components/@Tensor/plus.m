%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor plus method for overloading the addition operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = plus(a, b)
%
%   If both a and b are tensors
%
    if isa(a, 'Tensor') && isa(b, 'Tensor')
%
%       If a and b are the same tensor
%
        if a == b
            c = repmat(2, size(a.value)) .* a;
            return
        end
%
%       Compute resulting tensor
%
        c = Tensor(a.value + b.value);
%
%       Return if no gradient tracking
%
        if a.no_grad && b.no_grad; return; end
%
%       Assign local gradients
%
        dcda = eye(numel(a.value));
        dcdb = eye(numel(a.value));
        if a.no_grad
            c.local_grad(end + 1, :) = {b, dcdb};
        elseif b.no_grad
            c.local_grad(end + 1, :) = {a, dcda};
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
        c = Tensor(a.value + b);
%
%       Return if no gradient tracking
%
        if a.no_grad; return; end
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
        c = Tensor(a + b.value);
%
%       Return if no gradient tracking
%
        if b.no_grad; return; end
%
%       Assign local gradients
%
        dcdb = eye(numel(a));
        c.local_grad(end + 1, :) = {b, dcdb};
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%