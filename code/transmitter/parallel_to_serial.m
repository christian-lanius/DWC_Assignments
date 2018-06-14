function [time_signal] = parallel_to_serial(parallel_signal)
%PARALLEL_TO_SERIAL Summary of this function goes here
%   Detailed explanation goes here
time_signal = reshape(parallel_signal', [], numel(parallel_signal));
end

