%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% adam_optim function for implementation of the adam optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = adam_optim(f, x0, opts)
%
%   Input validation
%
    arguments
        f function_handle;
        x0;
        opts.max_iter double = 100;
        opts.lr double = 1e-3;
        opts.dx double = 1e-6;
        opts.beta1 double = 0.9;
        opts.beta2 double = 0.999;
        opts.lb double = repmat(-100, size(x0));
        opts.ub double = repmat(100, size(x0));
        opts.display logical = true;
        opts.jacobian function_handle = @(x) [];
        opts.lr_scheduler function_handle = @(lr, iter, f_val) lr;
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
    for iter = 1 : opts.max_iter
%
%       Call learning rate scheduler
%
        opts.lr = opts.lr_scheduler(opts.lr, iter, f_val);
%
%       Get derivative
%
        if isempty(opts.jacobian(x))
%
%           Approximate the derivative using finite difference
%
            dfx = zeros(size(x));
            for x_i = 1 : numel(x)
                dx = zeros(size(x));
                dx(x_i) = opts.dx;
                dfx(x_i) = (f(x + dx) - fx) / opts.dx;
            end
        else
%
%           Get derivative using jacobian function
%
            dfx = opts.jacobian(x);
        end
%
%       Update biased first and second moment estimate
%
        m = opts.beta1 * m + (1 - opts.beta1) * dfx;
        v = opts.beta2 * v + (1 - opts.beta2) * dfx .^ 2;
%
%       Compute bias corrected first and second moment estimate 
%
        m_hat = m ./ (1 - opts.beta1 ^ iter);
        v_hat = v ./ (1 - opts.beta2 ^ iter);
%
%       Calculate param update
%
        x = x - opts.lr * m_hat ./ (sqrt(v_hat) + 1e-8);
%
%       Apply bounds
%
        x = min(max(x, opts.lb), opts.ub);
%
%       Calculate the function value at the current guess
%
        fx = f(x);
        f_val = fx;
%
%       Command window output
%
        if opts.display
            disp("Iter: " + num2str(iter) + ", f_val: " + num2str(f_val));
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%