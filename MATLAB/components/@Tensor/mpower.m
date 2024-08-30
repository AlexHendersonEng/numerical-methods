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
    c = Tensor(a.value ^ b);
%
%   Return if no gradient tracking
%
    if a.no_grad; return; end
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
    c.local_grad(end + 1, :) = {a, dcda};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%