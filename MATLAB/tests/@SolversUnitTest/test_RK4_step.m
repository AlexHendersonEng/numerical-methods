%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_RK4_step method for testing the step method of the RK4 class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_RK4_step(test_case)
%
%   Instantiate RK4 class
%
    t0 = 0;
    h = 0.01;
    solver = RK4(t0, h);
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
    k1 = ode_fun(t0, y0);
    k2 = ode_fun(t0 + 0.5 * h, y0 + h * 0.5 * k1);
    k3 = ode_fun(t0 + 0.5 * h, y0 + h * 0.5 * k2);
    k4 = ode_fun(t0 + h, y0 + h * k3);
    y_expected = y0 + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
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