%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_tensor_backward_matrix method for testing the tensor class using the
% backwards gradient propagation method on matrices
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_tensor_backward_matrix(test_case)
%
%   Set random number generator seed
%
    rng(0);
%
%   Define base tensors
%
    a = Tensor(rand(2, 1));
    b = Tensor(rand());
    c = Tensor(rand());
%
%   Calculation and back propagation
%
    d = a' * a - 3 * b .^ 3 + 4 * c;
    d.backward();
%
%   Verify results
%
    test_case.verifyEqual([2 * a.value(1, 1); ...
                           2 * a.value(2, 1)], a.grad);
    test_case.verifyEqual(-9 * b.value .^ 2, b.grad);
    test_case.verifyEqual(4, c.grad);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%