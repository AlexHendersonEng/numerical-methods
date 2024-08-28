%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor zero_grad method for zeroing gradients of all tensors higher up
% in the computational graph
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function zero_grad(obj)
%
%   Zero gradient of current tensor
%
    obj.grad = 0;
%
%   Call zero gradient on all tensors higher up in computational graph 
%
    for grad_idx = 1 : size(obj.local_grad, 1)
        obj.local_grad{grad_idx, 1}.zero_grad();
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%