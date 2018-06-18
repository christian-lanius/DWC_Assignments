function [extended_baseband, pilot_sequence] = add_pilot_sequence(baseband_signal)
%ADD_PILOT_SEQUENCE Summary of this function goes here
%   Detailed explanation goes here
% pilot_sequence = randi([0 1], 1, 512);
num_subcarriers = size(baseband_signal,1);
num_symbols = size(baseband_signal, 2);
pilots = ones(num_subcarriers, num_symbols);
extended_baseband = [pilots; baseband_signal];
extended_baseband = reshape(extended_baseband, num_subcarriers, []);
% pilot_sequence = ones(1,num_subcarriers);
% extended_baseband = [pilot_sequence, baseband_signal];
end

