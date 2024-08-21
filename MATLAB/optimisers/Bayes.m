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
        x_train % Training points
        y_train % Training outputs
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
                options.n_train = 100
                options.n_test = 10
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
            obj.x_train = obj.lb + rand(obj.n_train, obj.n_params) .* (obj.ub - obj.lb);
        end
%
        function backward(obj)
%
%           Calculated number of currently computed points and update array
%           size
%
            n_total = size(obj.x_train, 1);
            n_computed = numel(obj.y_train);
            n_new = n_total - n_computed;
            obj.y_train = [obj.y_train;
                           zeros(n_new, 1)];
%
%           Evaluate cost function at each new training point
%
            for train_idx = n_computed + 1 : n_total
                obj.y_train(train_idx) = obj.loss_fcn(obj.x_train(train_idx, :));
            end
        end
%
        function step(obj)
%
%           Compute training covariance matrix with added noise for
%           numerical stability and inverse
%
            K_11 = obj.kernel(obj.x_train, obj.x_train);
            K_11 = K_11 + 1e-6 * eye(size(K_11));
            K_11_inv = inv(K_11);
%
%           Calculate current minimum y from training points
%
            [~, y_min_idx] = min(obj.y_train);
%
%           Use multi point gradient descent on acquisition function
%           to determine next training point
%
            x_test = zeros(obj.n_test, obj.n_params);
            x_test(1 : end - 1, :) = obj.lb + rand(obj.n_test - 1, obj.n_params) .* (obj.ub - obj.lb);
            x_test(end, :) = obj.x_train(y_min_idx, :);
            best_f_val = inf;
            for test_i = 1 : obj.n_test
                [x, f_val] = adam_optim(@(x) obj.lower_confidence_bound(x, K_11_inv), ...
                                        x_test(test_i, :), ...
                                        'lb', obj.lb, ...
                                        'ub', obj.ub, ...
                                        'h', 0.01, ...
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
            obj.x_train = [obj.x_train; x_next];     
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
        function [mu, K] = gp(obj, x_test, K_11_inv)
%
%           Compute the covariance between training and test data
%
            K_12 = obj.kernel(obj.x_train, x_test);
%
%           Compute the covariance of the test data
%
            K_22 = obj.kernel(x_test, x_test);
%
%           Mean prediction
%
            mu = K_12' * K_11_inv * obj.y_train;
%
%           Covariance prediction
%
            K = K_22 - K_12' * K_11_inv * K_12;
        end
%
        function ei = expected_improvement(obj, x_test, f_min, K_11_inv)
%
%           Compute GP mean and covariance for the test points
%
            [mu, K] = obj.gp(x_test, K_11_inv);
        
            % Standardize improvement
            u = (f_min - mu) ./ sqrt(diag(K));
            
            % Calculate expected improvement
            ei = (mu - f_min)' * mvncdf(u) - sqrt(diag(K))' * normpdf(u);
        end
%
        function lcb = lower_confidence_bound(obj, x_test, K_11_inv)
%
%           Compute GP mean and covariance for the test points
%
            [mu, K] = obj.gp(x_test, K_11_inv);
            
            % Calculate lower confidence bound
            lcb = mu - 3 * K;
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%