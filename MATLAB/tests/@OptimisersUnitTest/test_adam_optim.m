%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_adam_optim method for testing the adam optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_adam_optim(test_case)
%
%   Objective function
%
    f = @(x) (x(1) - 2) ^ 2 + (x(2) + 3) ^ 2 + (x(3) - 1) ^ 2;
%
%   Optimise
%
    x0 = zeros(1, 3);
    [x, f_val] = adam_optim(@(x) f(x), ...
                            x0, ...
                            'max_iter', 1000, ...
                            'lr', 0.01, ...
                            'dx', 1e-6, ...
                            'beta1', 0.9, ...
                            'beta2', 0.999, ...
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