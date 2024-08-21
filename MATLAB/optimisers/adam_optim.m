%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% adam_optim function for implementation of the adam optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = adam_optim(f, x0, options)
%
%   Input validation
%
    arguments
        f
        x0
        options.max_iter = 100
        options.h = 1e-3
        options.beta1 = 0.9
        options.beta2 = 0.999
        options.lb = repmat(-100, size(x0))
        options.ub = repmat(100, size(x0))
        options.Display = true
    end
%
%   Initial setup
%
    x = x0;
    fx = f(x);
    f_val = fx;
    m = zeros(size(x));
    v = zeros(size(x));
%
%   Solve loop
%
    for iter = 1 : options.max_iter
%
%       Approximate the derivative using finite difference
%
        dfx = zeros(size(x));
        for x_i = 1 : numel(x)
            dx = zeros(size(x));
            dx(x_i) = 1e-6;
            dfx(x_i) = (f(x + dx) - fx) / 1e-6;
        end
%
%       Update biased first and second moment estimate
%
        m = options.beta1 * m + (1 - options.beta1) * dfx;
        v = options.beta2 * v + (1 - options.beta2) * dfx .^ 2;
%
%       Compute bias corrected first and second moment estimate 
%
        m_hat = m ./ (1 - options.beta1 ^ iter);
        v_hat = v ./ (1 - options.beta2 ^ iter);
%
%       Calculate param update
%
        x = x - options.h * m_hat / (sqrt(v_hat) + 1e-8);
%
%       Apply bounds
%
        x = min(max(x, options.lb), options.ub);
%
%       Calculate the function value at the current guess
%
        fx = f(x);
        if fx < f_val
            f_val = fx;
        end
%
%       Command window output
%
        if options.Display
            disp("Iter: " + num2str(iter) + ", f_val: " + num2str(f_val));
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%