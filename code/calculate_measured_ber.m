function [measured_ber] = calculate_measured_ber(binary_input,binary_output)
%CALCULATE_MEASURED_BER Calculates the BER.

num_bits = length(binary_input);
measured_ber = (binary_input ~= binary_output);
% Sums number of errors along a time axis
measured_ber = sum(measured_ber, 2);
measured_ber = measured_ber./num_bits;
end

