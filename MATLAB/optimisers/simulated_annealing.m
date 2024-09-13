%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% simulated_annealing function for implementation of the simulated
% annealing optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = simulated_annealing(f, n_vars, options)
%
%   Input validation
%
    arguments
        f
        n_vars
        options.max_iter = 100
        options.pop_size = 100
        options.T = 10
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
    particles_prev = particles;
%
%   Solve loop
%
    for iter = 1 : options.max_iter
%
%       Loop over all particles
%
        for p_i = 1 : options.pop_size
%
%           Generate new candidate solution
%
            particles(p_i).x = particles(p_i).x + ...
                               0.01 * 2 * (rand(1, n_vars) - 0.5) .* (options.ub - options.lb);
%
%           Apply position limits
%
            particles(p_i).x = max(min(particles(p_i).x, options.ub), options.lb);
%
%           Get new candidate particle loss
%
            particles(p_i).loss = f(particles(p_i).x);
%
%           Calculate probability of acceptance
%
            if particles(p_i).loss < particles_prev(p_i).loss
                accept_prob = 0;
            else
                accept_prob = exp(-(particles(p_i).loss - particles_prev(p_i).loss) / options.T);
            end
%
%           Accept or reject new solution
%
            if rand() < accept_prob
                particles(p_i) = particles_prev(p_i);
            end
        end
%
%       Set current particles as previous particles
%
        particles_prev = particles;
%
%       Update temeperature
%
        options.T = options.T * 0.99;
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