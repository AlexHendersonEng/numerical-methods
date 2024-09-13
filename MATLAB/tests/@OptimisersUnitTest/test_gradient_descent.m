%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_gradient_descent method for testing the gradient descent
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_gradient_descent(test_case)
%
%   Objective function
%
    f = @(x) (x(1) - 2) ^ 2 + (x(2) + 3) ^ 2 + (x(3) - 1) ^ 2;
%
%   Optimise
%
    x0 = zeros(1, 3);
    [x, f_val] = gradient_descent(@(x) f(x), ...
                                  x0, ...
                                  'max_iter', 1000, ...
                                  'h', 0.01, ...
                                  'dx', 1e-6, ...
                                  'lb', repmat(-100, size(x0)), ...
                                  'ub', repmat(100, size(x0)), ...
                                  'display', false);
%
%   Verify results
%
    test_case.verifyEqual([f_val, x], [0, 2, -3, 1], ...
                          'AbsTol', 1e-3);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%