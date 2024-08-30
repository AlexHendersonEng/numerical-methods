%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor backward method for performing back propagation of gradients
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function backward(obj, grad)
%
%   Input handling
%
    arguments
        obj
        grad = ones(size(obj.value));
    end
%
%   Assign gradient
%
    obj.grad = grad;
%
%   Reshape gradient to column vector
%
    grad_vec = reshape(obj.grad, [], 1);
%
%   Back propagate
%
    for var_idx = 1 : size(obj.local_grad, 1)
%
%       Get local tensor
%
        tensor = obj.local_grad{var_idx, 1};
%
%       Accumulate gradient
%
        local_grad = obj.local_grad{var_idx, 2}' * grad_vec;
        tensor.grad = tensor.grad + reshape(local_grad, size(tensor.value));
%
%       Back propagate
%
        tensor.backward(tensor.grad);
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%