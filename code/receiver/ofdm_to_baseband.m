function [baseband_signal] = ofdm_to_baseband(time_signal)
%SYMBOL_TO_TIME_DOMAIN Summary of this function goes here
%   Detailed explanation goes here

baseband_signal = fft(time_signal);
baseband_signal = reshape(baseband_signal,size(time_signal,1), [], 1);
% time_signal = sum(time_signal, 1);
end

