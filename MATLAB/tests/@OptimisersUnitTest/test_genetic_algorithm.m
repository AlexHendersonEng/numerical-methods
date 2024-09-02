%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_genetic_algorithm method for testing the genetic algorithm
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_genetic_algorithm(test_case)
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
    [x, f_val] = genetic_algorithm(@(x) f(x), ...
                                   n_vars, ...
                                   'max_iter', 1000, ...
                                   'pop_size', 100, ...
                                   'elitism', true, ...
                                   'mutation_rate', 0.05, ...
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