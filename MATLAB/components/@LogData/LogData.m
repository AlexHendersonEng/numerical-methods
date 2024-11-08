%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% LogData class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef LogData < handle
%
    properties (Access = public)
        time double; % Time values
        data double; % Data values
    end
%
    properties (Access = private)
        n_data; % Number of data entries
    end
%
    methods (Access = public)
        function obj = LogData(time, data)
%
%           Input handling
%
            arguments
                time double; % Time values
                data double; % Data values
            end
%
%           Assign properties
%
            obj.time = time;
            obj.data = data;
        end
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%