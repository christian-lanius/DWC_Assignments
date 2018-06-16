function [trimmed_signal] = remove_cyclic_prefix(parallel_signal, num_guard_samples)
%REMOVE_CYCLIC_PREFIX Summary of this function goes here
%   Detailed explanation goes here
trimmed_signal = parallel_signal( num_guard_samples+1:end, :, :);
end

