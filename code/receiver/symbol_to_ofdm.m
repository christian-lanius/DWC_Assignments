function [time_signal] = symbol_to_ofdm(input_signal, num_subcarriers)
%SYMBOL_TO_TIME_DOMAIN Summary of this function goes here
%   Detailed explanation goes here
% 
% parallelized = reshape(input_signal, num_subcarriers, []);
time_signal = ifft(input_signal, num_subcarriers);

% time_signal = sum(time_signal, 1);
end

