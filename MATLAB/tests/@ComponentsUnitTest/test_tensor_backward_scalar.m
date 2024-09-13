%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_tensor_backward_scalar method for testing the tensor class using the
% backwards gradient propagation method on scalars
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_tensor_backward_scalar(test_case)
%
%   Define base tensors
%
    a = Tensor(2);
    b = Tensor(3);
    c = Tensor(4);
%
%   Calculation and back propagation
%
    d = 3 * a ^ 3 - b ^ 2 + 4 * c;
    d.backward();
%
%   Verify results
%
    test_case.verifyEqual(9 * a.value ^ 2, a.grad);
    test_case.verifyEqual(-2 * b.value, b.grad);
    test_case.verifyEqual(4, c.grad);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%