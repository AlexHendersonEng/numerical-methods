%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% newton_raphson function for implementation of the Newton-Raphson root
% finding algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function root = newton_raphson(f, x0, tol, max_iter, h)
%
%   Input validation
%
    arguments
        f
        x0
        tol = 1e-6
        max_iter = 100
        h = 1e-6
    end
%
%   Initial setup
%
    x = x0;
    iter = 0;
%
%   Solve loop
%
    while iter < max_iter
%
%       Calculate the function value at the current guess
%
        fx = f(x);
%
%       Approximate the derivative using finite difference
%
        dfx = (f(x + h) - f(x - h)) / (2 * h);
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
        if abs(x_new - x) < tol
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