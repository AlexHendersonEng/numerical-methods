%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor transpose method for overloading the transpose function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = transpose(a)
%
%   Compute resulting tensor
%
    c = Tensor(a.value.');
%
%   Return if no gradient tracking
%
    if a.no_grad; return; end
%
%   Assign local gradients
%
    n = size(a.value, 1);
    dcda = flip(eye(n), 2);
    dcda(1, 1) = 1; dcda(end, end) = 1;
    dcda(1, end) = 0; dcda(end, 1) = 0;
    c.local_grad(end + 1, :) = {a, dcda};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%