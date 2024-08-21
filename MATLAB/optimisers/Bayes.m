%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Bayes optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Bayes < Optimiser
%
    properties
        loss_fcn % Cost function
        n_params % Number of parameters
        particles; % Particles struct
        best_particle % Best particle struct
        n_computed % Number of particles with computed losses
        n_train % Number of training points to start with
        n_test % Number of testing points
        lb % Lower bound for particle positions
        ub % Upper bound for particle positions
        sigma_f % Gaussian process variance
        l % Gaussian process length scale
    end
%
    methods
        function obj = Bayes(nodes, adjacency, loss_fcn, options)
%
%           Handle inputs
%
            arguments
                nodes
                adjacency
                loss_fcn
                options.n_train = 20
                options.n_test = 5
                options.lb
                options.ub
                options.sigma_f = 1
                options.l = 1
            end
%
%           Call superclass constructor
%
            obj = obj@Optimiser(nodes, adjacency);
%
%           Assign variables
%
            obj.loss_fcn = loss_fcn;
            obj.n_train = options.n_train;
            obj.n_test = options.n_test;
            obj.lb = options.lb;
            obj.ub = options.ub;
            obj.sigma_f = options.sigma_f;
            obj.l = options.l;
%
%           Calculate number of parameters
%
            params = [];
            for node_i = 1 : numel(obj.nodes)
                params = [params, obj.nodes{node_i}.parameters()];
            end
            obj.n_params = numel(params);
%
%           Generate bounds if required and assign maximum velocity
%
            if isempty(obj.lb)
                obj.lb = repmat(-100, 1, obj.n_params);
            end
            if isempty(obj.ub)
                obj.ub = repmat(100, 1, obj.n_params);
            end
%
%           Generate training points
%
            obj.particles = repmat(struct('x', zeros(size(params)), ...
                                          'loss', inf), ...
                                   obj.n_train, 1);
            obj.best_particle = obj.particles(1);
            for p_i = 1 : obj.n_train
                obj.particles(p_i).x = obj.lb + rand(1, obj.n_params) .* (obj.ub - obj.lb);
            end
            obj.n_computed = 0;
        end
%
        function backward(obj)
%
%           Evaluate cost function at each new training point
%
            for p_i = obj.n_computed + 1 : numel(obj.particles)
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
%           Extract training variables
%
            x_train = cat(1, obj.particles.x);
            y_train = cat(1, obj.particles.loss);
%
%           Compute training covariance matrix with added noise for
%           numerical stability and inverse
%        
            K_11 = obj.kernel(x_train, x_train);
            K_11 = K_11 + 1e-6 * eye(size(K_11));
            K_11_inv = inv(K_11);
%
%           Use multi point gradient descent on acquisition function
%           to determine next training point
%
            x_test = zeros(obj.n_test, obj.n_params);
            x_test(1 : end - 1, :) = obj.lb + rand(obj.n_test - 1, obj.n_params) .* (obj.ub - obj.lb);
            x_test(end, :) = obj.best_particle.x;
            best_f_val = inf;
            for test_i = 1 : obj.n_test
                [x, f_val] = adam_optim(@(x) obj.lower_confidence_bound(x_train, x, y_train, K_11_inv), ...
                                        x_test(test_i, :), ...
                                        'lb', obj.lb, ...
                                        'ub', obj.ub, ...
                                        'h', 1, ...
                                        'max_iter', 1e3, ...
                                        'Display', false);
                if f_val < best_f_val
                    best_f_val = f_val;
                    x_next = x;
                end
            end
%
%           Update training points
%
            obj.particles(end + 1).x = x_next;     
        end
%
        function K = kernel(obj, x1, x2)
%
%           Squared distance
%
            sqdist = zeros(size(x1, 1), size(x2, 1));
            for x1_i = 1 : size(x1, 1)
                for x2_i = 1 : size(x2, 1)
                    sqdist(x1_i, x2_i) = sum((x1(x1_i, :) - x2(x2_i, :)) .^ 2);
                end
            end
%
%           Radial basis function
%
            K = obj.sigma_f ^ 2 * exp(-0.5 * sqdist / obj.l ^ 2);
        end
%
        function [mu, K] = gp(obj, x_train, x_test, y_train, K_11_inv)
%
%           Compute the covariance between training and test data
%
            K_12 = obj.kernel(x_train, x_test);
%
%           Compute the covariance of the test data
%
            K_22 = obj.kernel(x_test, x_test);
%
%           Mean prediction
%
            mu = K_12' * K_11_inv * y_train;
%
%           Covariance prediction
%
            K = K_22 - K_12' * K_11_inv * K_12;
        end
%
        function ei = expected_improvement(obj, x_train, x_test, y_train, f_min, K_11_inv)
%
%           Compute GP mean and covariance for the test points
%
            [mu, K] = obj.gp(x_train, x_test, y_train, K_11_inv);
        
            % Standardize improvement
            u = (f_min - mu) ./ sqrt(diag(K));
            
            % Calculate expected improvement
            ei = (mu - f_min)' * mvncdf(u) - sqrt(diag(K))' * normpdf(u);
        end
%
        function lcb = lower_confidence_bound(obj, x_train, x_test, y_train, K_11_inv)
%
%           Compute GP mean and covariance for the test points
%
            [mu, K] = obj.gp(x_train, x_test, y_train, K_11_inv);
            
            % Calculate lower confidence bound
            lcb = mu - 2 * K;
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%