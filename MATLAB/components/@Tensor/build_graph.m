%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor build_graph method for building of the computational graph
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [s, t] = build_graph(obj)
%
%   Build computational graph
%
    [s, t, ~] = construct_graph(obj, ...
                                [], ...
                                [], ...
                                1, ...
                                2);
end
%
function [s, t, t_curr] = construct_graph(tensor, s, t, s_curr, t_curr)
%
%   Loop through local gradients  
%
    for grad_idx = 1 : size(tensor.local_grad, 1)
%
%       Add current source and target node to array
%
        s(end + 1) = s_curr;
        t(end + 1) = t_curr;
%
%       Recursively build graph on local tensors
%
        [s, t, t_curr] = construct_graph(tensor.local_grad{grad_idx, 1}, ...
                                         s, ...
                                         t, ...
                                         t_curr, ...
                                         t_curr + 1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%