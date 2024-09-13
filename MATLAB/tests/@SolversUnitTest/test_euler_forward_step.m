%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_euler_forward_step method for testing the step method of the Euler
% forward class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_euler_forward_step(test_case)
%
%   Instantiate Euler forward class
%
    t0 = 0;
    h = 0.01;
    solver = EulerForward(t0, h);
%
%   Define ode function and initial states
%
    dydt = @(t, y) [y(2);
                    (1 - y(1) ^ 2) * y(2) - y(1)]; % Van der Pol equation
    y0 = [0;
          0.01];
%
%   Calculate expected output
%
    y_expected = y0 + h * dydt(t0, y0);
%
%   Call step method
%
    y_actual = solver.step(@(t, y) dydt(t, y), y0);
%
%   Verify results
%
    test_case.verifyEqual(y_actual, y_expected);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%