function [baseband_signal] = ofdm_to_baseband(time_signal, num_subcarriers)
%SYMBOL_TO_TIME_DOMAIN Summary of this function goes here
%   Detailed explanation goes here
num_eb_n0 = size(time_signal,3);
baseband_signal = fft(time_signal, num_subcarriers);
% baseband_signal = baseband_signal([1,end:-1:2], :);
baseband_signal = reshape(baseband_signal,[], num_eb_n0);
% time_signal = sum(time_signal, 1);
end

