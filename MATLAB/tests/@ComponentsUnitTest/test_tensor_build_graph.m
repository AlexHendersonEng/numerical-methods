%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_tensor_build_graph method for testing the tensor class build graph
% method
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_tensor_build_graph(test_case)
%
%   Define base tensors
%
    a = Tensor(1);
    b = Tensor(1);
    c = Tensor(1);
    d = Tensor(1);
%
%   Calculation and back propagation
%
    e = a * b;
    f = e * c;
    g = a + d;
    h = f * g;
    [s, t] = h.build_graph();
%
%   Verify results
%
    test_case.verifyEqual([1, 2, 3, 3, 2, 1, 7, 7], s);
    test_case.verifyEqual([2, 3, 4, 5, 6, 7, 8, 9], t);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%