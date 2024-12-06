%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% runge_kutta4 method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function states = runge_kutta4(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   If no states return
%
    states = obj.get_states();
    if isempty(states)
        obj.t = obj.t + obj.h;
        return
    end
%
%   Get current simulation states and derivatives
%
    x0 = arrayfun(@(tensor) tensor.value, states);
    derivatives = obj.get_derivatives();
%
%   k1 step
%
    k1 = arrayfun(@(tensor) tensor.value, derivatives);
%
%   k2 step
%
    adj_states = arrayfun(@(x, k) Tensor(x + 0.5 * obj.h .* k), ...
                          x0, ...
                          k1);
    obj.update(adj_states, obj.t + 0.5 * obj.h);
    k2 = arrayfun(@(tensor) tensor.value, obj.get_derivatives());
%
%   k3 step
%
    adj_states = arrayfun(@(x, k) Tensor(x + 0.5 * obj.h .* k), ...
                          x0, ...
                          k2);
    obj.update(adj_states, obj.t + 0.5 * obj.h);
    k3 = arrayfun(@(tensor) tensor.value, obj.get_derivatives());
%
%   k4 step
%
    adj_states = arrayfun(@(x, k) Tensor(x + obj.h .* k), ...
                          x0, ...
                          k3);
    obj.update(adj_states, obj.t + obj.h);
    k4 = arrayfun(@(tensor) tensor.value, obj.get_derivatives());
%
%   Update states
%
    x = x0 + (obj.h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
    states = arrayfun(@(x, derivative) generate_state(obj, x, derivative), ...
                      x, ...
                      derivatives);
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