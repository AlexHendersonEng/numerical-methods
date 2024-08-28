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
    c = Tensor(a.value.', 'mode', a.mode);
%
%   Assign local gradients
%
    n = size(a.value, 1);
    dcda = flip(eye(n ^ 2), 2);
    dcda(1, 1) = 1; dcda(end, end) = 1;
    dcda(1, end) = 0; dcda(end, 1) = 0;
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