%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Tensor class for implementation of a tenosr object for value and gradient
% tracking
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Tensor < handle
%
    properties
        value double
        local_grad cell;
        grad double = 0
        mode char
    end
%
    methods
        function obj = Tensor(value, options)
%
%           Input handling
%
            arguments
                value
                options.mode {mustBeMember(options.mode, {'forward', 'backward'})} = 'backward'
            end
%
%           Assign values
%
            obj.value = value;
            obj.mode = options.mode;
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
        compute_grad(obj, grad);
%
        zero_grad(obj);
%
        [s, t] = build_graph(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%