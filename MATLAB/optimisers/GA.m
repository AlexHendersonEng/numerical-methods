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
        pop_size % Number of particles in population
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
                options.pop_size = 50;
                options.lb = [];
                options.ub = [];
            end
%
%           Call superclass constructor
%
            obj = obj@Optimiser(nodes, adjacency, options.lb, options.ub);
%
%           Assign variables
%
            obj.loss_fcn = loss_fcn;
            obj.pop_size = options.pop_size;
%
%           Generate population
%
            obj.particles = repmat(struct('x', zeros(1, obj.n_params), ...
                                          'loss', inf), ...
                                   obj.pop_size, 1);
            obj.best_particle = obj.particles(1);
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
%
%           Global best update
%
            [~, min_idx] = min([obj.particles.loss]);
            if obj.particles(min_idx).loss < obj.best_particle.loss
                obj.best_particle = obj.particles(min_idx);
            end
        end
%
        function step(obj)
%
%           Pre-allocate new population
%
            new_particles = obj.particles;
%
%           Generate selection probabilities
%
            weights = 1 ./ ([obj.particles.loss] + 1e-8);
%
%           Loop over all particles
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