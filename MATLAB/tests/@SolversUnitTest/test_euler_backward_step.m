%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_euler_backward_step method for testing the step method of the Euler
% backward class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_euler_backward_step(test_case)
%
%   Instantiate Euler backward class
%
    t0 = 0;
    h = 0.01;
    solver = EulerBackward(t0, h);
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
    f = @(y) y0 - y + h * ode_fun(t0 + h, y);
    y_expected = newton_raphson(@(y) f(y), y0);
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