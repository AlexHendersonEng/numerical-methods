%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor abs method for calculating absolute tensor value
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = abs(a)
%
%   Compute resulting tensor
%
    c = Tensor(abs(a.value));
%
%   Return if no gradient tracking
%
    if a.no_grad; c.no_grad = true; return; end
%
%   Assign local gradients
%
    dcda = eye(numel(a.value));
    c.local_grad(end + 1, :) = {a, dcda};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%