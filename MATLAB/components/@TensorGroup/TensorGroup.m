%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TensorGroup class for implementation of a group of tensor objects
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef TensorGroup < handle & matlab.mixin.Copyable
%
    properties (Access = public)
        tensors Tensor;
    end
%
    methods (Access = public)
        function obj = TensorGroup(tensors)
%
%           Input handling
%
            arguments (Repeating)
                tensors Tensor;
            end
%
%           Assign values
%
            obj.tensors = repmat(Tensor(0), 1, nargin);
            for n = 1 : nargin
                obj.tensors(n) = tensors{n};
            end
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%