function [dist_signal, H_measured] = apply_channel(input_signal, modulation_mode, channel_model, eb_n0)
%APPLY_CHANNEL Distortes the channel according to the channel model

variance = 10.^(-eb_n0/10);

% If QPSK, the energy per bit is halfed, so the variance is halfed as well
if strcmp(modulation_mode, 'QPSK')
   variance = 0.5*variance; 
end

% Create white noise. The vector is replicated for each time step.
% N is a matrix of size Number of Simulation Points x Length of time
% sequence
var_matrix = repmat(sqrt(variance'/2), [1 length(input_signal)]);
N = var_matrix.*(randn(length(variance), length(input_signal)) + ...
                 randn(length(variance), length(input_signal))*1j);

if strcmp(channel_model,'AWGN')
    % Channel impulse response is constant 1 for AWGN
    H = ones(length(variance), length(input_signal));
end
if strcmp(channel_model,'Rayleigh')
    % Model channel as rayleigh fading channel
    H = sqrt(0.5)*randn(length(variance), length(input_signal)) + ...
        sqrt(0.5)*randn(length(variance), length(input_signal))*1j;
end

H_measured = H;
dist_signal = H.*input_signal + N;
% end

end
