%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_bayes_optim method for testing the Bayesian optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_bayes_optim(test_case)
%
%   Objective function
%
    f = @(x) (x(1) - 2) ^ 2 + (x(2) + 3) ^ 2 + (x(3) - 1) ^ 2;
%
%   Set random number generator seed
%
    rng(0);
%
%   Optimise
%
    n_vars = 3;
    [x, f_val] = bayes_optim(@(x) f(x), ...
                             n_vars, ...
                             'max_iter', 100, ...
                             'n_train', 100, ...
                             'n_test', 2, ...
                             'sigma_f', 2, ...
                             'l', 0.2, ...
                             'lb', repmat(-5, 1, n_vars), ...
                             'ub', repmat(5, 1, n_vars), ...
                             'display', false);
%
%   Verify results
%
    test_case.verifyEqual([f_val, x], [0, 2, -3, 1], ...
                          'AbsTol', 1e-2);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%