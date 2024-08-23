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
        f
        x0
        options.tol = 1e-6
        options.max_iter = 100
        options.dx = 1e-6
    end
%
%   Initial setup
%
    x = x0;
    iter = 0;
%
%   Solve loop
%
    while iter < options.max_iter
%
%       Calculate the function value at the current guess
%
        fx = f(x);
%
%       Approximate the derivative using finite difference
%
        dfx = (f(x + options.dx) - f(x - options.dx)) / (2 * options.dx);
%        
%       Check if the derivative is zero to avoid division by zero
%
        if dfx == 0
            error('Derivative is zero. No solution found.');
        end
%
%       Calculate the next guess using the Newton-Raphson formula
%
        x_new = x - fx / dfx;
%
%       Check if the change is within the tolerance
%
        if abs(x_new - x) < options.tol
            root = x_new;
            return;
        end
%
%       Update the current guess and increment the iteration count
%
        x = x_new;
        iter = iter + 1;
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