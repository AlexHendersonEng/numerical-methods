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
    c = Tensor(a.value .^ b);
%
%   Return if no gradient tracking
%
    if a.no_grad; c.no_grad = true; return; end
%
%   Assign local gradients
%
    dcda = b * diag(reshape(a.value, [], 1)) .^ (b - 1);
    c.local_grad(end + 1, :) = {a, dcda};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%