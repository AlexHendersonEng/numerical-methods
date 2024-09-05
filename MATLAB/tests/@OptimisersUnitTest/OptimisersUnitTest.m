%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% OptimisersUnitTest class for running of unit tests for optimisers in
% the numerical methods repository
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef OptimisersUnitTest < matlab.unittest.TestCase
%
    methods (TestClassSetup)
        add_paths(test_case);
    end
%
    methods (TestClassTeardown)
        rm_paths(test_case);
    end
%
    methods (Test)
        test_adam_optim(test_case);
%
        test_gradient_descent(test_case);
%
        test_particle_swarm(test_case);
%
        test_newton_raphson(test_case);
%
        test_genetic_algorithm(test_case);
%
        test_simulated_annealing(test_case);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%