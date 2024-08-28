%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor uminus method for overloading the unary minus operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = uminus(a)
%
%   Compute resulting tensor
%
    c = Tensor(-a.value, 'mode', a.mode);
%
%   Assign local gradients
%
    dcda = -eye(numel(a.value));
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