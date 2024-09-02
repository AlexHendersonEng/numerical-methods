%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% genetic_algorithm function for implementation of the genetic algorithm
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = genetic_algorithm(f, n_vars, options)
%
%   Input validation
%
    arguments
        f
        n_vars
        options.max_iter = 100
        options.pop_size = 100
        options.elitism = true
        options.mutation_rate = 0.1
        options.lb = repmat(-100, size(1, n_vars))
        options.ub = repmat(100, size(1, n_vars))
        options.display = true
    end
%
%   Initialise particles
%
    particles = repmat(struct('x', zeros(1, n_vars), ...
                              'loss', inf), ...
                       options.pop_size, 1);
    best_particle = particles(1);
    for p_i = 1 : options.pop_size
        particles(p_i).x = options.lb + rand(1, n_vars) .* ...
                           (options.ub - options.lb);
        particles(p_i).loss = f(particles(p_i).x);
    end
%
%   Get best particle
%
    [~, min_idx] = min([particles.loss]);
    if particles(min_idx).loss < best_particle.loss
        best_particle = particles(min_idx);
    end
%
%   Solve loop
%
    for iter = 1 : options.max_iter
%
%       Pre-allocate new population
%
        new_particles = particles;
%
%       Generate selection probabilities
%
        weights = 1 ./ ([particles.loss] + 1e-8);
%
%       Loop over all particles
%
        for p_i = 1 : options.pop_size
%
%           Elitism
%
            if p_i == 1 && options.elitism
                new_particles(1) = best_particle;
                continue
            end
%
%           Selection
%
            parents_idx = randsample(options.pop_size, ...
                                     2, ...
                                     true, ...
                                     weights);
%
%           Crossover
%
            cross_array = rand(1, n_vars) > 0.5;
            new_particles(p_i).x(cross_array) = particles(parents_idx(1)).x(cross_array);
            new_particles(p_i).x(~cross_array) = particles(parents_idx(2)).x(~cross_array);
%
%           Mutation
%
            mutation_array = rand(1, n_vars) < options.mutation_rate;
            new_particles(p_i).x(mutation_array) = new_particles(p_i).x(mutation_array) + ...
                                                   0.01 * 2 * (rand(1, sum(mutation_array)) - 0.5) .* ...
                                                   (options.ub(mutation_array) - options.lb(mutation_array));
%
%           Apply position limits
%
            new_particles(p_i).x = max(min(new_particles(p_i).x, options.ub), options.lb);
        end
%
%       Update particles
%
        particles = new_particles;
%
%       Get new particle loss
%
        particles(p_i).loss = f(particles(p_i).x);
%
%       Global best update
%
        [~, min_idx] = min([particles.loss]);
        if particles(min_idx).loss < best_particle.loss
            best_particle = particles(min_idx);
        end
        x = best_particle.x;
        f_val = best_particle.loss;
%
%       Command window output
%
        if options.display
            disp("Iter: " + num2str(iter) + ", f_val: " + num2str(f_val));
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%