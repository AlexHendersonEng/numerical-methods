%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% SolversUnitTest class for running of unit tests for solvers in
% the numerical methods repository
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef SolversUnitTest < matlab.unittest.TestCase
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
        test_solver_instantiation(test_case);
%
        test_solver_update(test_case);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%