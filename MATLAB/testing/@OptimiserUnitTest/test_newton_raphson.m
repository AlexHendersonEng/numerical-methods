%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_newton_raphson method for testing the newton raphson root finding
% algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_newton_raphson(test_case)
%
%   Objective function
%
    f = @(x) [(x(1) - 2) ^ 2;
              (x(2) + 3) ^ 2;
              (x(3) - 1) ^ 2];
%
%   Optimise
%
    x0 = zeros(3, 1);
    root = newton_raphson(@(x) f(x), ...
                          x0, ...
                          'max_iter', 1000, ...
                          'tol', 1e-6, ...
                          'dx', 1e-6, ...
                          'display', false);
%
%   Verify results
%
    test_case.verifyEqual(root, [2; -3; 1], ...
                          'AbsTol', 1e-3);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%