%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Adam step method
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function step(obj)
%
%   Loop over parameters
%
    for idx = 1 : obj.n_params
%
%       Update biased first and second moment estimate
%
        obj.m(idx) = obj.beta1 * obj.m(idx) + (1 - obj.beta1) * obj.params(idx).grad;
        obj.v(idx) = obj.beta2 * obj.v(idx) + (1 - obj.beta2) * obj.params(idx).grad .^ 2;
%
%       Compute bias corrected first and second moment estimate 
%
        m_hat = obj.m(idx) ./ (1 - obj.beta1 ^ obj.iter);
        v_hat = obj.v(idx) ./ (1 - obj.beta2 ^ obj.iter);
%
%       Update parameter
%
        obj.params(idx).value = obj.params(idx).value - obj.lr * m_hat ./ (sqrt(v_hat) + 1e-8);
%
%       Apply limits
%
        obj.params(idx).value = min(max(obj.params(idx).value, obj.lb(idx)), obj.ub(idx));
    end
%
%   Increment iteration counter
%
    obj.iter = obj.iter + 1;
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%