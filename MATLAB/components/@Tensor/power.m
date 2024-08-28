%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor power method for overloading the element-wise matrix power
% operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = power(a, b)
%
%   Compute resulting tensor
%
    c = Tensor(a.value .^ b, 'mode', a.mode);
%
%   Assign local gradients
%
    dcda = b * diag(reshape(a.value, [], 1)) .^ (b - 1);
    if strcmpi(a.mode, 'forward')
        a.local_grad(end + 1, :) = {c, dcda};
    else
        c.local_grad(end + 1, :) = {a, dcda};
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%