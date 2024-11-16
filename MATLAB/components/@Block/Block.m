%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Block superclass
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Block < handle
%
    properties (Access = public)
        input Tensor;  % Block input
        output Tensor; % Block output
    end
%
    methods (Access = public)
        function obj = Block(n_in, n_out)
%
%           Input handling
%
            arguments
                n_in double = 0;
                n_out double = 0;
            end
%
%           Block superclass constructor method
%
            obj.input = repmat(Tensor([]), 1, n_in);
            obj.output = repmat(Tensor([]), 1, n_out);
        end
%
        update(~, ~);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%