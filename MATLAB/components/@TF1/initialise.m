%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% initialise method of TF1 class
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
%   Assign sim initial input and output
%
    obj.blocks{1}.input(1) = obj.input;
    obj.output = obj.blocks{3}.output;
%
%   Initialise sub simulation
%
    obj.sim = Simulation(obj.blocks, obj.connections, solver);
%
%   Get parameters
%
    obj.params = obj.sim.parameters();
%
%   Call superclass method
%
    initialise@Block(obj, solver, n_steps);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%