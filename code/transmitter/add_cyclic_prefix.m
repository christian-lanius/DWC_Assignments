function [prefixed_signal] = add_cyclic_prefix(parallel_signal, num_guard_samples)
%ADD_CYCLIC_PREFIX Summary of this function goes here
%   Detailed explanation goes here
% output_shape = size(parallel_signal);
% output_shape(2) = output_shape(2) + num_guard_samples;
% prefixed_signal = zeros(output_shape);
% prefixed_signal(:,num_guard_samples+1:end) = parallel_signal;
% prefixed_signal(:, 1:num_guard_samples) = parallel_signal(:, end-num_guard_samples+1:end);

parallel_signal = parallel_signal';
output_shape = size(parallel_signal);
output_shape(2) = output_shape(2) + num_guard_samples;
prefixed_signal = zeros(output_shape);
prefixed_signal(:,num_guard_samples+1:end) = parallel_signal;
prefixed_signal(:, 1:num_guard_samples) = parallel_signal(:, end-num_guard_samples+1:end);
prefixed_signal = prefixed_signal';
end

