%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% particle_swarm function for implementation of the particle swarm
% optimisation algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = particle_swarm(f, n_vars, options)
%
%   Input validation
%
    arguments
        f
        n_vars
        options.max_iter = 100
        options.w = 0.5
        options.c1 = 2
        options.c2 = 2
        options.swarm_size = 100
        options.lb = repmat(-100, size(1, n_vars))
        options.ub = repmat(100, size(1, n_vars))
        options.display = true
    end
%
%   Initial setup
%
    v_max = 0.1 * norm(options.ub - options.lb);
%
%   Initialise particles
%
    particles = repmat(struct('x', zeros(1, n_vars), ...
                              'v', zeros(1, n_vars), ...
                              'loss', inf), ...
                       options.swarm_size, 1);
    best_particle = particles(1);
    for p_i = 1 : options.swarm_size
        particles(p_i).x = options.lb + rand(1, n_vars) .* (options.ub - options.lb);
        particles(p_i).loss = f(particles(p_i).x);
    end
    particles_best = particles;
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
%       Loop over all particles
%
        for p_i = 1 : options.swarm_size
%
%           Personal best update
%
            if particles(p_i).loss < particles_best(p_i).loss
                particles_best(p_i) = particles(p_i);
            end
%
%           Velocity update
%
            particles(p_i).v = options.w * particles(p_i).v + ...
                               options.c1 * rand() * (particles_best(p_i).x - particles(p_i).x) + ...
                               options.c2 * rand() * (best_particle.x - particles(p_i).x);
%
%           Apply velocity limits
%
            if norm(particles(p_i).v) > v_max
                particles(p_i).v = v_max * (particles(p_i).v / norm(particles(p_i).v));
            end
%
%           Position update
%
            particles(p_i).x = particles(p_i).x + particles(p_i).v;
%
%           Apply position limits
%
            particles(p_i).x = max(min(particles(p_i).x, options.ub), options.lb);
%
%           Get particle loss
%
            particles(p_i).loss = f(particles(p_i).x);
        end
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