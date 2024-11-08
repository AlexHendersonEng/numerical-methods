%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Input block class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef Input < Block
%
    properties (Access = public)
        u_t double; % Column vector of time values (s) 
        u double;   % Column vector of values where each new column is a new
                    % signal
    end
%
    methods (Access = public)
        function obj = Input(u_t, u)
%
%           Input handling
%
            arguments
                u_t double;
                u double;
            end
%
%           Call block superclass
%
            obj = obj@Block();
%
%           Assign properties
%
            obj.u_t = u_t;
            obj.u = u;
        end
%
        update(obj, t);
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%