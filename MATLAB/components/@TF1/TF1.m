%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TF1 (first order transfer function) block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef TF1 < Block
%
    properties (Access = public)
        blocks cell; % Sub-blocks
        n_blocks double; % Number of sub-blocks
        connections double; % Sub-block connection graph
        order double; % Execution order
    end
%
    methods (Access = public)
        function obj = TF1(state, param)
%
%           Input handling
%
            arguments
                state Tensor = 0;
                param Tensor = 1;
            end
%
%           Call block superclass
%
            obj = obj@Block(1, 1);
%
%           Assign properties
%
            obj.blocks = {Operator('+-');
                          Gain(param);
                          Integrator(state)};
            obj.n_blocks = numel(obj.blocks);
            obj.connections = [1, 1, 2, 1;
                               2, 1, 3, 1;
                               3, 1, 1, 2];
            obj.order = [3, 1]; % Add blocks 3 and 1 to execution order to
                                % ensure correct execution of exec_order
                                % function
            obj.exec_order();
        end
%
        update(obj, t);
%
        exec_order(obj);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%