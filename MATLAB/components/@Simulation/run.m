%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% run method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function run(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Initialise simulation
%
    obj.initialise();
    obj.configure_logging();
%
%   Step simulation until simulation end time (written with while loop to
%   allow for variable step solver)
%
    while obj.t + 1e-8 < obj.t_span(2)
        obj.step();
        obj.update_logging();
    end
%
%   Terminate simulation
%
    obj.terminate();
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%