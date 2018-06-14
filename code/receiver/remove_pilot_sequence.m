function [baseband_signal, channel_estimate] = remove_pilot_sequence(extended_baseband_signal, pilot_sequence)
%REMOVE_PILOT_SEQUENCE Summary of this function goes here
%   Detailed explanation goes here
num_pilot_samples = length(pilot_sequence);
recv_pilot_sequence = extended_baseband_signal(1:num_pilot_samples);
baseband_signal = extended_baseband_signal(num_pilot_samples+1:end);
channel_estimate = recv_pilot_sequence'/pilot_sequence;

end

