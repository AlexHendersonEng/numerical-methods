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
%   Get current simulation states and derivatives
%
    x0 = arrayfun(@(tensor) tensor.value, obj.get_states())';
    derivatives = reshape(obj.get_derivatives(), [], 1);
%
%   Solve for new states
%
    x = newton_raphson(@(x) loss_fcn(obj, x, x0), x0, ...
                       'display', false);
    states = arrayfun(@(x, derivative) generate_state(obj, x, derivative), ...
                      x, derivatives);
%
%   Reset simulation state
%
    original_states = arrayfun(@(x, k) Tensor(x), ...
                               x0);
    obj.update(original_states, obj.t);
%
%   Update simulation time
%
    obj.t = obj.t + obj.h;
end
%
function error = loss_fcn(obj, x, x0)
%
%   Update simulation
%
    states = arrayfun(@(val) Tensor(val), x);
    obj.update(states, obj.t + obj.h);
%
%   Extract derivatives
%
    dxdt = arrayfun(@(tensor) tensor.value, obj.get_derivatives())';
%
%   Compute error
%
    error = x0 - x + obj.h .* dxdt;
end
%
function state = generate_state(obj, x, derivative)
%
%   Generate state and override gradient tracking
%
    state = Tensor(x);
    state.local_grad(end + 1, :) = {derivative, obj.h};
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%