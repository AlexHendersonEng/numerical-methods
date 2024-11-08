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
        data; % Data values
    end
%
    properties (Access = private)
        n_data double; % Number of data entries
    end
%
    methods (Access = public)
        function obj = LogData(time, data)
%
%           Input handling
%
            arguments
                time double; % Time values
                data; % Data values
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