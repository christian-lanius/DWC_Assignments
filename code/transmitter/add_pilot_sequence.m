function [extended_baseband, pilot_sequence] = add_pilot_sequence(baseband_signal)
%ADD_PILOT_SEQUENCE Summary of this function goes here
%   Detailed explanation goes here
% pilot_sequence = randi([0 1], 1, 512);
pilot_sequence = ones(1,512);
extended_baseband = [pilot_sequence, baseband_signal];
end

