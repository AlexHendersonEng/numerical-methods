%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Simulated annealing optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef SA < Optimiser
%
    properties
        loss_fcn % Cost function
        particles; % Particles struct
        particles_prev % Previous particles struct
        best_particle % Best particle struct
        n_params % Number of parameters
        pop_size % Population size
        lb % Lower bound for particle positions
        ub % Upper bound for particle positions
        T % Temperature
    end
%
    methods
        function obj = SA(nodes, adjacency, loss_fcn, options)
%
%           Handle inputs
%
            arguments
                nodes
                adjacency
                loss_fcn
                options.pop_size = 50;
                options.T = 10
                options.lb
                options.ub
            end
%
%           Call superclass constructor
%
            obj = obj@Optimiser(nodes, adjacency);
%
%           Assign variables
%
            obj.loss_fcn = loss_fcn;
            obj.pop_size = options.pop_size;
            obj.T = options.T;
            obj.lb = options.lb;
            obj.ub = options.ub;
%
%           Generate initial solution
%
            params = [];
            for node_i = 1 : numel(obj.nodes)
                params = [params, obj.nodes{node_i}.parameters()];
            end
            obj.n_params = numel(params);
            obj.particles = repmat(struct('x', zeros(size(params)), ...
                                          'loss', inf), ...
                                   obj.pop_size, 1);
%
%           Generate bounds if required
%
            if isempty(obj.lb)
                obj.lb = rempmat(-100, 1, obj.n_params);
            end
            if isempty(obj.ub)
                obj.ub = rempmat(100, 1, obj.n_params);
            end
%
%           Give each particle a random starting position
%
            for p_i = 1 : obj.pop_size
                obj.particles(p_i).x = obj.lb + rand(1, obj.n_params) .* (obj.ub - obj.lb);
            end
            obj.particles_prev = obj.particles;
            obj.best_particle = obj.particles(1);
        end
%
        function backward(obj)
%
%           Evaluate cost function for particles
%
            for p_i = 1 : obj.pop_size
                obj.particles(p_i).loss = obj.loss_fcn(obj.particles(p_i).x);
            end
        end
%
        function step(obj)
%
%           Global best update
%
            [~, min_idx] = min([obj.particles.loss]);
            if obj.particles(min_idx).loss < obj.best_particle.loss
                obj.best_particle = obj.particles(min_idx);
            end
%
%           Loop over all particles
%
            for p_i = 1 : obj.pop_size
%
%               Calculate probability of rejection
%
                if obj.particles(p_i).loss < obj.particles_prev(p_i).loss
                    reject_prob = 1;
                else
                    reject_prob = exp((obj.particles(p_i).loss - obj.particles_prev(p_i).loss) / obj.T);
                end
%
%               Accept or reject new solution
%
                if rand() > reject_prob
                    obj.particles(p_i) = obj.particles_prev(p_i);
                end
%
%               Generate new candidate solution
%
                obj.particles(p_i).x = obj.particles(p_i).x + ...
                                       0.1 * 2 * (rand(1, obj.n_params) - 0.5) .* (obj.ub - obj.lb);
%
%               Apply position limits
%
                obj.particles(p_i).x = max(min(obj.particles(p_i).x, obj.ub), obj.lb);
            end
%
%           Update temeperature
%
            obj.T = obj.T * 0.9;
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%