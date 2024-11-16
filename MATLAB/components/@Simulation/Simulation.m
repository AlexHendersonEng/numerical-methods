%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Simulation class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Simulation < handle
%
    properties (Access = public)
        blocks cell; % Cell array of blocks in the simulation
        connections double; % Connection graph for blocks in the form:
                            %   [outblock, outport, inblock, inport;
                            %    outblock, outport, inblock, inport; ... ]
        t_span double; % Time span for simulation:
                       %   [t_start, t_end] (s)
        h double; % Solver step size (s)
        solver_select SolverSelect; % ODE solver selection
        t double; % Simulation current time (s)
        logs_out containers.Map; % Logged data in the form:
                                 % containers.Map({'signal_name1', 'signal_name2', ...}, ...
                                 %                {LogData1, LogData2, ...})     
    end
%
    properties (Access = private)
        state_idx double; % Index's of blocks in the simulation which have a
                          % state
        n_states double; % Number of states in the simulation
        n_blocks double; % Number of blocks in the simulation
        order double; % Block execution order
        logs_info containers.Map; % Logging info dictionary in the form:
                                  % containers.Map({'signal_name1', 'signal_name2', ...}, ...
                                  %                {[block_index1, block_outport1], [block_index2, block_outport2], ...})
        step_idx double; % The current step of the simulation
        pre_init_fcn function_handle % Pre-initialise function
        post_init_fcn function_handle % Post-inialise function
        pre_step_fcn function_handle % Pre-step function
        post_step_fcn function_handle % Post-step function
        pre_term_fcn function_handle % Pre-terminate function
        post_term_fcn function_handle % Post-terminate functio
    end
%
    methods (Access = public)
        function obj = Simulation(blocks, connections, opts)
%
%           Input handling
%
            arguments
                blocks cell;
                connections double;
                opts.t_span double = [0, 10];
                opts.h double = 0.01;
                opts.solver_select SolverSelect = SolverSelect.euler_forward;
                opts.logs_info containers.Map = containers.Map('KeyType', 'char', 'ValueType', 'any');
                opts.pre_init_fcn function_handle = @(sim) [];
                opts.post_init_fcn function_handle = @(sim) [];
                opts.pre_step_fcn function_handle = @(sim) [];
                opts.post_step_fcn function_handle = @(sim) [];
                opts.pre_term_fcn function_handle = @(sim) [];
                opts.post_term_fcn function_handle = @(sim) [];
            end
%
%           Assign properties
%
            obj.blocks = blocks;
            obj.n_blocks = numel(blocks);
            obj.connections = connections;
            obj.t_span = opts.t_span;
            obj.h = opts.h;
            obj.solver_select = opts.solver_select;
            obj.logs_info = opts.logs_info;
            obj.logs_out = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.pre_init_fcn = opts.pre_init_fcn;
            obj.post_init_fcn = opts.post_init_fcn;
            obj.pre_step_fcn = opts.pre_step_fcn;
            obj.post_step_fcn = opts.post_step_fcn;
            obj.pre_term_fcn = opts.pre_term_fcn;
            obj.post_term_fcn = opts.post_term_fcn;
        end
%
        run(obj);
%
        plot_digraph(obj);
%
        params = get_parameters(obj);
    end
%
    methods (Access = private)
        initialise(obj);
%
        step(obj);
%
        terminate(obj);
%
        configure_logging(obj);
%
        update_logging(obj);
%
        count = exec_order(obj, block_i, count);
%
        states = get_states(obj);
%
        derivatives  = get_derivatives(obj);
%
        update(obj, states, t);
%
        states = euler_forward(obj);
%
        states = runge_kutta4(obj);
%
        states = euler_backward(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%