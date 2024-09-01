%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% initialise method of noise class
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
%   Calculate initial output
%
    if isempty(obj.sample_rate)
        obj.sample_rate = solver.h;
    end
    obj.sample_n = obj.sample_rate / solver.h;
    obj.output = obj.input + obj.mu + randn(size(obj.input)) * obj.sigma;
%
%   Call superclass method
%
    initialise@Block(obj, solver, n_steps);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%