%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ComponentsUnitTest class for running of unit tests for components in
% the numerical methods repository
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef ComponentsUnitTest < matlab.unittest.TestCase
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
        test_tensor_backward_scalar(test_case);
%
        test_tensor_backward_matrix(test_case);
%
        test_tensor_zero_grad(test_case);
%
        test_tensor_build_graph(test_case);
%
        test_tensor_optimisation(test_case);
%
        test_basic_simulation(test_case);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%