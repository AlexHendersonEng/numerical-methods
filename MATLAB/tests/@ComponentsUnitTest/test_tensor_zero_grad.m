%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_tensor_zero_grad method for testing the tensor class zero gradients
% method
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_tensor_zero_grad(test_case)
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
    d.zero_grad();
%
%   Verify results
%
    test_case.verifyEqual(0, a.grad);
    test_case.verifyEqual(0, b.grad);
    test_case.verifyEqual(0, c.grad);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%