%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor class for implementation of a tenosr object for value and gradient
% tracking
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Tensor < handle & matlab.mixin.Copyable
%
    properties
        value double
        local_grad cell;
        grad double = 0
        no_grad
    end
%
    methods
        function obj = Tensor(value, options)
%
%           Input handling
%
            arguments
                value
                options.no_grad = false
            end
%
%           Assign values
%
            obj.value = value;
            obj.no_grad = options.no_grad;
        end
%
        c = uplus(a);
%
        c = uminus(a);
%
        c = plus(a, b);
%
        c = minus(a, b);
%
        c = times(a, b);
%
        c = mtimes(a, b);
%
        c = power(a, b);
%
        c = mpower(a, b);
%
        c = rdivide(a, b);
%
        c = ldivide(b, a);
%
        c = mrdivide(b, a);
%
        c = mldivide(a, b);
%
        c = inv(a);
%
        c = transpose(a);
%
        c = ctranspose(a);
%
        backward(obj, grad);
%
        zero_grad(obj);
%
        reset_graph(obj);
%
        [s, t] = build_graph(obj);
%
        c = double(a);
%
        s = num2str(a);
%
        c = norm(a);
%
        c = abs(a);
%
        c = lt(a, b);
%
        c = gt(a, b);
%
        c = le(a, b);
%
        c = ge(a, b);
%
        c = max(a, b);
%
        c = min(a, b);
%
        c = exp(a);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%