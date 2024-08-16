%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Adam optimiser
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Adam < Optimiser
%
    properties
        h
        beta1
        beta2
        m
        v
        step_num = 1
    end
%
    methods
        function obj = Adam(nodes, adjacency, h, beta1, beta2)
%
%           Input handling
%
            arguments
                nodes
                adjacency
                h
                beta1 = 0.9
                beta2 = 0.999
            end
%
%           Call super class instatiation method and assign variables
%
            obj = obj@Optimiser(nodes, adjacency);
            obj.h = h;
            obj.beta1 = beta1;
            obj.beta2 = beta2;
            obj.m = zeros(numel(nodes), 1);
            obj.v = zeros(numel(nodes), 1);
        end
%
        function step(obj)
%
%           Loop through nodes and update params
%
            for node_i = 1 : obj.n_nodes
%
%               Update biased first and second moment estimate
%
                obj.m(node_i) = obj.beta1 * obj.m(node_i) + (1 - obj.beta1) * obj.param_grad(node_i);
                obj.v(node_i) = obj.beta2 * obj.v(node_i) + (1 - obj.beta2) * obj.param_grad(node_i) ^ 2;
%
%               Compute bias corrected first and second moment estimate 
%
                m_hat = obj.m(node_i) / (1 - obj.beta1 ^ obj.step_num);
                v_hat = obj.v(node_i) / (1 - obj.beta2 ^ obj.step_num);
%
%               Calculate param update
%
                param_update = -obj.h * m_hat / (sqrt(v_hat) + 1e-8);
%
%               Update node param
%
                obj.nodes{node_i}.update(param_update);
            end
%
%           Increment step number
%
            obj.step_num = obj.step_num + 1;
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%