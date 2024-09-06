%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% bayes_optim function for implementation of the Bayesian optimisation
% algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [x, f_val] = bayes_optim(f, n_vars, options)
%
%   Input validation
%
    arguments
        f
        n_vars
        options.max_iter = 100;
        options.n_train = 100
        options.n_test = 10
        options.sigma_f = 1;
        options.l = 1;
        options.lb = repmat(-100, size(1, n_vars))
        options.ub = repmat(100, size(1, n_vars))
        options.display = true
    end
%
%   Initialise training data
%
    x_train = options.lb + rand(options.n_train, n_vars) .* (options.ub - options.lb);
    y_train = zeros(options.n_train, 1);
    for train_i = 1 : options.n_train
        y_train(train_i) = f(x_train);
    end
    [f_val, min_idx] = min(y_train);
    x = x_train(min_idx, :);
%
%   Solve loop
%
    for iter = 1 : options.max_iter
%
%       Compute training covariance matrix with added noise for
%       numerical stability and inverse
%        
        K_11 = kernel(x_train, x_train, options.sigma_f, options.l);
        K_11 = K_11 + 1e-6 * eye(size(K_11));
        K_11_inv = inv(K_11);
%
%       Use multi point gradient descent on acquisition function to
%       determine next training point
%
        x0 = x + 0.01 * rand(options.n_test, n_vars) .* (options.ub - options.lb);
        best_f_val = inf;
        for test_i = 1 : options.n_test
            [x_next, f_val_next] = adam_optim(@(x) lower_confidence_bound(x_train, x, y_train, K_11_inv, options.sigma_f, options.l), ...
                                              x0(test_i, :), ...
                                              'max_iter', 100, ...
                                              'h', 0.01, ...
                                              'dx', 1e-6, ...
                                              'beta1', 0.9, ...
                                              'beta2', 0.999, ...
                                              'lb', options.lb, ...
                                              'ub', options.ub, ...
                                              'display', false);
            if f_val_next < best_f_val
                best_f_val = f_val_next;
                best_x = x_next;
            end
        end
%
%       Update training points
%
        x_train(end + 1, :) = best_x;
        y_train(end + 1) = f(best_x);
%
%       Global best update
%
        if y_train(end) < f_val
            f_val = y_train(end);
            x = x_next;
        end
%
%       Command window output
%
        if options.display
            disp("Iter: " + num2str(iter) + ", f_val: " + num2str(f_val));
        end
    end
end
%
function K = kernel(x1, x2, sigma_f, l)
%
%   Squared distance
%
    sqdist = zeros(size(x1, 1), size(x2, 1));
    for x1_i = 1 : size(x1, 1)
        for x2_i = 1 : size(x2, 1)
            sqdist(x1_i, x2_i) = sum((x1(x1_i, :) - x2(x2_i, :)) .^ 2);
        end
    end
%
%   Radial basis function
%
    K = sigma_f ^ 2 * exp(-0.5 * sqdist / l ^ 2);
end
%
function [mu, K] = gp(x_train, x_test, y_train, K_11_inv, sigma_f, l)
%
%   Compute the covariance between training and test data
%
    K_12 = kernel(x_train, x_test, sigma_f, l);
%
%   Compute the covariance of the test data
%
    K_22 = kernel(x_test, x_test, sigma_f, l);
%
%   Mean prediction
%
    mu = K_12' * K_11_inv * y_train;
%
%   Covariance prediction
%
    K = K_22 - K_12' * K_11_inv * K_12;
end
%
function lcb = lower_confidence_bound(x_train, x_test, y_train, K_11_inv, sigma_f, l)
%
%   Compute GP mean and covariance for the test points
%
    [mu, K] = gp(x_train, x_test, y_train, K_11_inv, sigma_f, l);
%
%   Calculate lower confidence bound
%
    lcb = mu - 0.01 * K;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%