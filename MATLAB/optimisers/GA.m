%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Genetic algorithm optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef GA < Optimiser
%
    properties
        loss_fcn % Cost function
        particles; % Particles struct
        best_particle % Best particle struct
        n_params % Number of parameters
        pop_size % Number of particles in population
        lb % Lower bound for particle positions
        ub % Upper bound for particle positions
    end
%
    methods
        function obj = GA(nodes, adjacency, loss_fcn, options)
%
%           Handle inputs
%
            arguments
                nodes
                adjacency
                loss_fcn
                options.pop_size = 50
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
            obj.lb = options.lb;
            obj.ub = options.ub;
%
%           Generate population
%
            params = [];
            for node_i = 1 : numel(obj.nodes)
                params = [params, obj.nodes{node_i}.parameters()];
            end
            obj.n_params = numel(params);
            obj.particles = repmat(struct('x', zeros(size(params)), ...
                                          'loss', inf), ...
                                   obj.pop_size, 1);
            obj.best_particle = obj.particles(1);
%
%           Generate bounds if required and assign maximum velocity
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
                for x_i = 1 : obj.n_params
                    obj.particles(p_i).x = obj.lb + rand(1, obj.n_params) .* (obj.ub - obj.lb);
                end
            end
        end
%
        function backward(obj)
%
%           Evaluate cost function for each particles
%
            for p_i = 1 : obj.pop_size
                obj.particles(p_i).loss = obj.loss_fcn(obj.particles(p_i).x);
            end
        end
%
        function step(obj)
%
%           Pre-allocate new population
%
            new_particles = obj.particles;
%
%           Global best update
%
            [~, min_idx] = min([obj.particles.loss]);
            if obj.particles(min_idx).loss < obj.best_particle.loss
                obj.best_particle = obj.particles(min_idx);
            end
%
%           Generate selection probabilities
%
            
            weights = 1 ./ ([obj.particles.loss] + 1e-8);
%
%           Generate new probabilities
%
            for p_i = 1 : obj.pop_size
%
%               Selection
%
                parents_idx = randsample(obj.pop_size, ...
                                         2, ...
                                         true, ...
                                         weights);
%
%               Crossover
%
                n_cross = randi([1, obj.n_params]);
                cross_idx = randsample(obj.n_params, n_cross, false);
                cross_array = false(1, obj.n_params);
                cross_array(cross_idx) = true;
                new_particles(p_i).x(cross_array) = obj.particles(parents_idx(1)).x(cross_array);
                new_particles(p_i).x(~cross_array) = obj.particles(parents_idx(1)).x(~cross_array);
%
%               Mutation
%
                new_particles(p_i).x = new_particles(p_i).x + 0.01 * 2 * (rand(1, obj.n_params) - 0.5) .* (obj.ub - obj.lb);
%
%               Apply position limits
%
                new_particles(p_i).x = max(min(new_particles(p_i).x, obj.ub), obj.lb);
                obj.particles = new_particles;
            end
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%