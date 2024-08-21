%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Gradient descent based optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef GD < Optimiser
%
    properties
        h
    end
%
    methods
        function obj = GD(nodes, adjacency, h)
%
%           Call super class instatiation method
%
            obj = obj@Optimiser(nodes, adjacency);
            obj.h = h;
        end
%
        function step(obj)
%
%           Loop through nodes and update weights
%
            for node_i = 1 : obj.n_nodes
                param_update = -obj.h * obj.param_grad{node_i};
                obj.nodes{node_i}.update(param_update);
            end
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%