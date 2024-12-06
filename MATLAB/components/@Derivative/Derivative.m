%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Derivative block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Derivative < Block
%
    properties (Access = public)
        blocks cell; % Sub-blocks
        n_blocks double; % Number of sub-blocks
        connections double; % Sub-block connection graph
        order double; % Execution order
    end
%
    methods (Access = public)
        function obj = Derivative(h)
%
%           Input handling
%
            arguments
                h double;
            end
%
%           Call block superclass
%
            obj = obj@Block(1, 1);
%
%           Assign properties
%
            obj.blocks = {Memory(Tensor(0));
                          Operator('+-');
                          Input([0, 1], [h, h])
                          Operator('+/')};
            obj.n_blocks = numel(obj.blocks);
            obj.connections = [1, 1, 2, 2;
                               2, 1, 4, 1;
                               3, 1, 4, 2];
            obj.order = [1, 2]; % Add blocks 3 and 1 to execution order to
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