%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_tensor_optimisation method for testing the tensor class in an
% optimisation problem
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_tensor_optimisation(test_case)
%
%   Define objective function, jacobian and initial values
%
    f = @(x) (x(1) - 2) ^ 2 + (x(2) + 3) ^ 2 + (x(3) + 1) ^ 2;
    x = [Tensor(0);
         Tensor(0);
         Tensor(0)];
%
%   Initialise gradient descent step
%
    h = 1e-2;
%
%   Loop through iterations
%
    for iter = 1 : 1e3
%
%       Set tensor gradient tracking on
%
        for x_i = 1 : numel(x)
            x(x_i).no_grad = false;
        end
%
%       Evaluate function and get jacobian
%
        y = f(x);
        y.backward();
%
%       Update values
%
        for x_i = 1 : numel(x)
            x(x_i).no_grad = true;
            x(x_i) = x(x_i) - h * x(x_i).grad;
        end
%
%       Zero gradients
%
        y.zero_grad();
    end
%
%   Verify results
%
    test_case.verifyEqual(cat(2, x.value), [2, -3, -1], ...
                          'AbsTol', 1e-3);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%