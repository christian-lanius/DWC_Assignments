function [dist_signal, H] = apply_channel(input_signal, modulation_mode, channel_model, eb_n0, num_subcarriers, num_guard_samples)
%APPLY_CHANNEL Distortes the channel according to the channel model

variance = 10.^(-eb_n0/10);
% variance = variance/((num_subcarriers+num_guard_samples)/(num_subcarriers^2));
% variance =variance/(num_subcarriers+num_guard_samples);
eb = ((num_subcarriers+num_guard_samples)/(num_subcarriers^2))^(-1);
variance = variance/eb;

num_samples_delay = 0;
imp_resp = zeros(num_samples_delay+1, 1);
imp_resp(end) = (1+1j)/sqrt(2);
input_signal = conv2(imp_resp, input_signal);
input_signal = input_signal(1:end-num_samples_delay,:);

% If QPSK, the energy per bit is halfed, so the variance is halfed as well
if strcmp(modulation_mode, 'QPSK')
   variance = 0.5*variance; 
end

% Create white noise. The vector is replicated for each time step.
% N is a matrix of size Number of Simulation Points x Length of time
% sequence. bin_is_pilot marks the samples corresponding to the pilot
% symbols, which have no noise applied to them. Thus the variance is set to
% 0.
var_matrix = repmat(sqrt(variance'/2), [1 length(input_signal)]);
bin_is_pilot = mod(ceil([1:length(input_signal)]/(num_subcarriers+num_guard_samples)), 2) ~= 0;
var_matrix(:, bin_is_pilot) = 0;
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

if strcmp(channel_model, 'Jake')
    num_path = 1;
    decay = 1;
    f_interval = 1/3.84e6;
    f_doppler = 0.2e-4*f_interval;
    H = fade( 1, length(input_signal), num_path, f_doppler, decay, 1/f_interval );
    H = repmat(H, [length(variance), 1]);
    
end

% H_measured = H';
dist_signal = H'.*input_signal + N';

end

