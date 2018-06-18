function [baseband_signal, channel_estimate] = remove_pilot_sequence(baseband_recv_signal_parallel)
%REMOVE_PILOT_SEQUENCE Summary of this function goes here
%   Detailed explanation goes here

num_eb_n0 = size(baseband_recv_signal_parallel, 3);
baseband_signal = baseband_recv_signal_parallel(:, 2:2:end, :);
baseband_signal = reshape(baseband_signal,[], num_eb_n0);
channel_estimate = baseband_recv_signal_parallel(:, 1:2:end, :);
channel_estimate = reshape(channel_estimate,[], num_eb_n0);

end

