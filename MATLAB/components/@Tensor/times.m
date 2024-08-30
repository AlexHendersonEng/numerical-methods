%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor times method for overloading the element-wise multiplication
% operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = times(a, b)
%
%   If both a and b are tensors
%
    if isa(a, 'Tensor') && isa(b, 'Tensor')
%
%       If a and b are the same tensor
%
        if a == b
            c = a .^ 2;
            return
        end
%
%       Compute resulting tensor
%
        c = Tensor(a.value .* b.value);
%
%       Return if no gradient tracking
%
        if a.no_grad && b.no_grad; return; end
%
%       Assign local gradients
%
        dcda = diag(reshape(b.value, [], 1));
        dcdb = diag(reshape(a.value, [], 1));
        if a.no_grad
            c.local_grad(end + 1, :) = {a, dcdb};
        elseif b.no_grad
            c.local_grad(end + 1, :) = {b, dcda};
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
        c = Tensor(a.value .* b);
%
%       Return if no gradient tracking
%
        if a.no_grad; return; end
%
%       Assign local gradients
%
        dcda = diag(reshape(b, [], 1));
        c.local_grad(end + 1, :) = {a, dcda};
%
%   Else only b is a tensor
%
    else
%
%       Compute resulting tensor
%
        c = Tensor(a .* b.value);
%
%       Return if no gradient tracking
%
        if b.no_grad; return; end
%
%       Assign local gradients
%
        dcdb = diag(reshape(a, [], 1));
        c.local_grad(end + 1, :) = {b, dcdb};
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%