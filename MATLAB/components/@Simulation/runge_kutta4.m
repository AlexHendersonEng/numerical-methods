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
    adj_states = states + 0.5 * obj.h .* k1;
    obj.update(adj_states, obj.t + 0.5 * obj.h);
    k2 = obj.get_derivatives();
%
%   k3 step
%
    adj_states = states + 0.5 * obj.h .* k2;
    obj.update(adj_states, obj.t + 0.5 * obj.h);
    k3 = obj.get_derivatives();
%
%   k4 step
%
    adj_states = states + obj.h * k3;
    obj.update(adj_states, obj.t + obj.h);
    k4 = obj.get_derivatives();
%
%   Update states
%
    states = states + (obj.h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
%
%   Update simulation time
%
    obj.t = obj.t + obj.h;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%