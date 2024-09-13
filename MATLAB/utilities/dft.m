%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% dft function for computing the discrete Fourier transform
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function X = dft(x)
%
%   Pre-allocation
%
    N = numel(x);
    X = zeros(size(x));
%
% Compute discrete Fourier transform
%
    for k = 1 : N
        for n = 1 : N
            X(k) = X(k) + x(n) * exp(-2j * pi * (k - 1) * (n - 1) / N);
        end
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%