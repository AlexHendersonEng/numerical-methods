%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% gradient_descent function for implementation of the gradient descent
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = gradient_descent(f, x0, opts)
%
%   Input validation
%
    arguments
        f function_handle;
        x0;
        opts.max_iter double = 100;
        opts.lr double = 1e-3;
        opts.dx double = 1e-6;
        opts.lb double = repmat(-100, size(x0));
        opts.ub double = repmat(100, size(x0));
        opts.display logical = true;
        opts.jacobian = @(x) [];
        opts.lr_scheduler = @(lr, iter, f_val) lr;
    end
%
%   Initial setup
%
    x = x0;
    fx = f(x);
    f_val = fx;
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
%       Calculate the next guess using the Newton-Raphson formula
%
        x = x - opts.lr * dfx;
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