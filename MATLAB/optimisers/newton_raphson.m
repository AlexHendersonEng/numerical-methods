%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% newton_raphson function for implementation of the Newton-Raphson root
% finding algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function root = newton_raphson(f, x0, options)
%
%   Input validation
%
    arguments
        f % Column vector of functions
        x0 % Column vector of variables (size(f) == size(x0))
        options.tol = 1e-6
        options.dx = 1e-6
        options.max_iter = 100
        options.display = true
        options.jacobian = []
    end
%
%   Initial setup
%
    x = x0;
%
%   Solve loop
%
    for iter = 1 : options.max_iter
%
%       Calculate the function value at the current guess
%
        fx = f(x);
%
%       Get derivative
%
        if isempty(options.jacobian)
%
%           Approximate the derivative using finite difference
%
            n_x = numel(x);
            dfx = zeros(n_x, n_x);
            for x_i = 1 : n_x
                dx = zeros(size(x));
                dx(x_i) = options.dx;
                dfx(:, x_i) = (f(x + dx) - fx) / options.dx;
            end
        else
%
%           Get derivative using jacobian function
%
            dfx = options.jacobian(x);
        end
%        
%       Check if the derivative is zero to avoid division by zero
%
        if dfx == 0
            error('Derivative is zero. No solution found.');
        end
%
%       Calculate the next guess using the Newton-Raphson formula
%
        x_new = x - dfx \ fx;
%
%       Command window output
%
        if options.display
            disp("Iter: " + num2str(iter) + ", x: " + num2str(x_new'));
        end
%
%       Check if the change is within the tolerance
%
        if norm(x_new - x) < options.tol
            root = x_new;
            return
        end
%
%       Update the current guess and increment the iteration count
%
        x = x_new;
    end
%
%   If max iterations are reached without convergence
%
    error('Maximum number of iterations reached. No solution found.');
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%