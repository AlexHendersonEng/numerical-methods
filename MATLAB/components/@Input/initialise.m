%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% initialise method of input class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function initialise(obj, solver, n_steps)
%
%   Input handling
%
    arguments
        obj
        solver
        n_steps
    end
%
%   Call superclass method
%
    initialise@Block(obj, solver, n_steps);
%
%   Assign block initial input and output
%
    obj.input = Tensor(obj.solver.t);
    obj.output = Tensor(interp1(obj.u_t, obj.u, obj.input.value));
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%