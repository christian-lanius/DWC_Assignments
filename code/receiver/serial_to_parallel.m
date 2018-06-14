function [parallel_signal] = serial_to_parallel(recv_signal, num_subcarriers, num_guard_samples)
%SERIAL_TO_PARALLEL Summary of this function goes here
%   Detailed explanation goes here
num_eb_n0 = size(recv_signal,1);
parallel_signal = reshape(recv_signal, num_eb_n0, num_subcarriers+num_guard_samples, []);
parallel_signal = permute(parallel_signal, [1,3,2]);

end

