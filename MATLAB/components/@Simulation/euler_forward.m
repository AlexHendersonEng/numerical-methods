%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% euler_forward method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function states = euler_forward(obj)
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
    x0 = arrayfun(@(tensor) tensor.value, obj.get_states());
    derivatives = obj.get_derivatives();
    dxdt = arrayfun(@(tensor) tensor.value, derivatives);
%
%   Update states
%
    x = x0 + obj.h .* dxdt;
    states = arrayfun(@(x, derivative) generate_state(obj, x, derivative), ...
                      x, ...
                      derivatives);
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