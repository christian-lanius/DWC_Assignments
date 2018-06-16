function [binary_gt] = create_input_signal(input_length)
%CREATE_INPUT_SIGNAL Creates a baseband modulated signal of the given
%length
%   Detailed explanation goes here

% Create random bit sequence
binary_gt = randi([0 1], input_length, 1);
% binary_gt = ones(1, input_length);
% binary_gt(2:2:end) = 0;
end

