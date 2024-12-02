%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% run method of Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function logs_out = run(obj)
%
%   Input handling
%
    arguments
        obj Simulation;
    end
%
%   Initialise simulation
%
    obj.pre_init_fcn(obj);
    obj.initialise();
    obj.post_init_fcn(obj);
    obj.configure_logging();
    obj.update_logging();
%
%   Step simulation until simulation end time (written with while loop to
%   allow for variable step solver)
%
    while obj.t + 1e-8 < obj.t_span(2)
        obj.pre_step_fcn(obj);
        obj.step();
        obj.post_step_fcn(obj);
        obj.update_logging();
    end
%
%   Terminate simulation
%
    obj.pre_term_fcn(obj);
    obj.terminate();
    obj.post_term_fcn(obj);
%
%   Output log data
%
    if nargout > 0
        logs_out = obj.logs_out;
    end
%
%   Increment run count
%
    obj.run_count = obj.run_count + 1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%