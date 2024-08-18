%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Particle swarm optimisation optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef PSO < Optimiser
%
    properties
        loss_fcn % Cost function
        particles; % Particles struct
        particles_best; % Particles personal best struct
        best_particle % Best particle struct
        n_params % Number of parameters
        w % Particle inertia
        c1 % Cognitive coefficient
        c2 % Social coefficient
        swarm_size % Number of particles in swarm
        lb % Lower bound for particle positions
        ub % Upper bound for particle positions
        v_max % Maximum velocity for particles
    end
%
    methods
        function obj = PSO(nodes, adjacency, loss_fcn, options)
%
%           Handle inputs
%
            arguments
                nodes
                adjacency
                loss_fcn
                options.w = 0.5
                options.c1 = 2
                options.c2 = 2
                options.swarm_size = 10
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
            obj.w = options.w;
            obj.c1 = options.c1;
            obj.c2 = options.c2;
            obj.swarm_size = options.swarm_size;
            obj.lb = options.lb;
            obj.ub = options.ub;
%
%           Generate swarm
%
            params = [];
            for node_i = 1 : numel(obj.nodes)
                params = [params, obj.nodes{node_i}.parameters()];
            end
            obj.n_params = numel(params);
            obj.particles = repmat(struct('x', zeros(size(params)), ...
                                          'v', zeros(size(params)), ...
                                          'loss', inf), ...
                                   obj.swarm_size, 1);
            obj.particles_best = obj.particles;
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
            obj.v_max = 0.1 * norm(obj.ub - obj.lb);
%
%           Give each particle a random starting position
%
            for p_i = 1 : obj.swarm_size
                obj.particles(p_i).x = obj.lb + rand(1, obj.n_params) .* (obj.ub - obj.lb);
            end
        end
%
        function backward(obj)
%
%           Evaluate cost function for each particles
%
            for p_i = 1 : obj.swarm_size
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
            for p_i = 1 : obj.swarm_size
%
%               Personal best update
%
                if obj.particles(p_i).loss < obj.particles_best(p_i).loss
                    obj.particles_best(p_i) = obj.particles(p_i);
                end
%
%               Velocity update
%
                obj.particles(p_i).v = obj.w * obj.particles(p_i).v + ...
                                       obj.c1 * rand() * (obj.particles_best(p_i).x - obj.particles(p_i).x) + ...
                                       obj.c2 * rand() * (obj.best_particle.x - obj.particles(p_i).x);
%
%               Apply velocity limits
%
                if norm(obj.particles(p_i).v) > obj.v_max
                    obj.particles(p_i).v = obj.v_max * (obj.particles(p_i).v / norm(obj.particles(p_i).v));
                end
%
%               Position update
%
                obj.particles(p_i).x = obj.particles(p_i).x + obj.particles(p_i).v;
%
%               Apply position limits
%
                obj.particles(p_i).x = max(min(obj.particles(p_i).x, obj.ub), obj.lb);
            end
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%