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
%   Get current simulation states and derivatives
%
    states = obj.get_states();
    derivatives = obj.get_derivatives();
%
%   Update states
%
    states = states + obj.h .* derivatives;
%
%   Update simulation time
%
    obj.t = obj.t + obj.h;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%