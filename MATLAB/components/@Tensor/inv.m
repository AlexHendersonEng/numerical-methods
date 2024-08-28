%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor inv method for overloading the matrix inversion function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = inv(a)
%
%   Compute resulting tensor
%
    c = Tensor(inv(a.value), 'mode', a.mode);
%
%   Assign local gradients
%
    dcda = -kron(c.value, c.value');
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