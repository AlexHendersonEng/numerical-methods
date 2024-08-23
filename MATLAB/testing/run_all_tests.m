%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% run_all_tests script for running all tests in the numerical methods
% repository
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Get current file directory information
%
file_path = mfilename('fullpath');
[path, ~, ~] = fileparts(file_path);
dir_names = {dir(path).name};
%
% Get all class directories
%
test_array = {};
for name_i = 1 : numel(dir_names)
    token = regexp(dir_names{name_i}, ...
                   '^@(.*)', ...
                   'tokens');
    if ~isempty(token)
        test_array{end + 1} = token{1}{1};
    end
end
%
% Run tests
%
results = runtests(test_array);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%