%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% step method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function step(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Update continuous states
%
    switch obj.solver_select
        case SolverSelect.euler_forward
            states = obj.euler_forward();
        case SolverSelect.runge_kutta4
            states = obj.runge_kutta4();
        case SolverSelect.euler_backward
            states = obj.euler_backward();
    end
%
%   Update discrete states
%
    obj.update(states, obj.t);
%
%   Update simulation step index
%
    obj.step_idx = obj.step_idx + 1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%