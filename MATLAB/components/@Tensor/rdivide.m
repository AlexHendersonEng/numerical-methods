%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor rdivide method for overloading the right array division operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = rdivide(a, b)
%
%   If both a and b are tensors
%
    if isa(a, 'Tensor') && isa(b, 'Tensor')
%
%       If a and b are the same tensor
%
        if a == b
            c = Tensor(ones(size(a.value))) + zeros(size(a.value));
            return
        end
%
%       Compute resulting tensor
%
        c = Tensor(a.value ./ b.value);
%
%       Return if no gradient tracking
%
        if a.no_grad && b.no_grad; c.no_grad = true; return; end
%
%       Assign local gradients
%
        dcda = diag(1 ./ reshape(b.value, [], 1));
        dcdb = -diag(reshape(a.value, [], 1) ./ (reshape(b.value, [], 1)) .^ 2);
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
        c = Tensor(a.value ./ b);
%
%       Return if no gradient tracking
%
        if a.no_grad; return; end
%
%       Assign local gradients
%
        dcda = diag(1 ./ reshape(b, [], 1));
        c.local_grad(end + 1, :) = {a, dcda};
%
%   Else only b is a tensor
%
    else
%
%       Compute resulting tensor
%
        c = Tensor(a ./ b.value);
%
%       Return if no gradient tracking
%
        if b.no_grad; return; end
%
%       Assign local gradients
%
        dcdb = -diag(reshape(a, [], 1) ./ (reshape(b.value, [], 1)) .^ 2);
        c.local_grad(end + 1, :) = {b, dcdb};
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%