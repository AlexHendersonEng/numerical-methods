%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% euler_backward method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function states = euler_backward(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Get current simulation states
%
    x0 = obj.get_states()';
%
%   Solve for new states
%
    states = newton_raphson(@(x) loss_fun(obj, x, x0), x0, ...
                            'display', false)';
%
%   Update simulation time
%
    obj.t = obj.t + obj.h;
end
%
function error = loss_fun(obj, x, x0)
%
%   Update simulation
%
    obj.update(x, obj.t + obj.h);
%
%   Extract derivatives
%
    dxdt = obj.get_derivatives()';
%
%   Compute error
%
    error = x0 - x + obj.h * dxdt;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%