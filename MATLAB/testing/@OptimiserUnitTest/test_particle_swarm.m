%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_particle_swarm method for testing the particle swarm
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_particle_swarm(test_case)
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
    [x, f_val] = particle_swarm(@(x) f(x), ...
                                n_vars, ...
                                'max_iter', 1000, ...
                                'w', 0.5, ...
                                'c1', 2, ...
                                'c2', 2, ...
                                'swarm_size', 100, ...
                                'lb', repmat(-100, 1, n_vars), ...
                                'ub', repmat(100, 1, n_vars), ...
                                'Display', false);
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