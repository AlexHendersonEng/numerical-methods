%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% step method of noise class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function step(obj)
%
%   Step forward in time calculating new output and logging data 
%   (runs at every simulation step)
%
    obj.n_elapsed = obj.n_elapsed + 1;
    if obj.n_elapsed == obj.sample_n
        obj.output = obj.input + obj.mu + randn(size(obj.input)) * obj.sigma;
        obj.n_elapsed = 0;
    else
        obj.output = obj.input;
    end
%
%   Call superclass method
%
    step@Block(obj);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%