%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor reset_graph method for resetting the computational graph of the
% tensor
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function reset_graph(obj)
%
%   Call reset graph on all tensors higher up in computational graph 
%
    for grad_idx = 1 : size(obj.local_grad, 1)
        obj.local_grad{grad_idx, 1}.reset_graph();
    end
%
%   Empty computational graph
%
    obj.local_grad = {};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%