%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor mpower method for overloading the matrix power operator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function c = mpower(a, b)
%
%   Compute resulting tensor
%
    c = Tensor(a.value ^ b, 'mode', a.mode);
%
%   Assign local gradients
%
    n = size(a.value, 1);
    dcda = zeros(n ^ 2, n ^ 2);
    for m = 0 : (b - 1)
        am = a.value ^ m;
        akm = a.value ^ (b - 1 - m);
        dcda = dcda + kron(am, akm');
    end
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