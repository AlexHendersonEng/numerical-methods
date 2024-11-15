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
%   Get current simulation states
%
    states = obj.get_states();
%
%   k1 step
%
    k1 = obj.get_derivatives();
%
%   k2 step
%
    adj_states = arrayfun(@(state, derivative) state + 0.5 * obj.h .* derivative, ...
                          states, ...
                          k1);
    obj.update(adj_states, obj.t + 0.5 * obj.h);
    k2 = obj.get_derivatives();
%
%   k3 step
%
    adj_states = arrayfun(@(state, derivative) state + 0.5 * obj.h .* derivative, ...
                          states, ...
                          k2);
    obj.update(adj_states, obj.t + 0.5 * obj.h);
    k3 = obj.get_derivatives();
%
%   k4 step
%
    adj_states = arrayfun(@(state, derivative) state + obj.h .* derivative, ...
                          states, ...
                          k3);
    obj.update(adj_states, obj.t + obj.h);
    k4 = obj.get_derivatives();
%
%   Update states
%
    states = arrayfun(@(state, d1, d2, d3, d4) state + (obj.h / 6) * (d1 + 2 * d2 + 2 * d3 + d4), ...
                      states, ...
                      k1, ...
                      k2, ...
                      k3, ...
                      k4);
%
%   Update simulation time
%
    obj.t = obj.t + obj.h;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%