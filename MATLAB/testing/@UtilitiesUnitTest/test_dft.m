%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_dft method for testing the discrete Fourier transform algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_dft(test_case)
%
%   Time varying signal
%
    Fs = 1e3;                 
    T = 1 / Fs;     
    t = (0 : T : 1)';
    omega = 100;
    x = sin(2 * omega * pi * t);
    f_x = (Fs / numel(x)) * (0 : numel(x) - 1);
%
%   Extract main frequency in signal using discrete Fourier transform
%
    X = dft(x);
    [~, max_idx] = max(X(1 : (end + 1) / 2));
    omega_p = f_x(max_idx);
%
%   Verify results
%
    test_case.verifyEqual(omega, omega_p, ...
                          'AbsTol', 0.1);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%