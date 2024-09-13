%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor exp method for overloading the exp operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = exp(a)
%
%   Compute resulting tensor
%
    c = Tensor(exp(a.value));
%
%   Return if no gradient tracking
%
    if a.no_grad; c.no_grad = true; return; end
%
%   Assign local gradients
%
    dcda = diag(reshape(exp(a.value), [], 1));
    c.local_grad(end + 1, :) = {a, dcda};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%