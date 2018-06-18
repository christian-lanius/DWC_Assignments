function [H_est] = estimate_channel(baseband_recv_signal,baseband_signal)
%ESTIMATE_CHANNEL Summary of this function goes here
%   Detailed explanation goes here
H_est = baseband_recv_signal./baseband_signal;
end

