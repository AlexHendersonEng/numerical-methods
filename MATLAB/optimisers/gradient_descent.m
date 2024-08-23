%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% gradient_descent function for implementation of the gradient descent
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = gradient_descent(f, x0, options)
%
%   Input validation
%
    arguments
        f
        x0
        options.max_iter = 100
        options.h = 1e-3
        options.dx = 1e-6
        options.lb = repmat(-100, size(x0))
        options.ub = repmat(100, size(x0))
        options.display = true
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
    for iter = 1 : options.max_iter
%
%       Approximate the derivative using finite difference
%
        dfx = zeros(size(x));
        for x_i = 1 : numel(x)
            dx = zeros(size(x));
            dx(x_i) = options.dx;
            dfx(x_i) = (f(x + dx) - fx) / options.dx;
        end
%
%       Calculate the next guess using the Newton-Raphson formula
%
        x = x - options.h * dfx;
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
        if options.display
            disp("Iter: " + num2str(iter) + ", f_val: " + num2str(f_val));
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%