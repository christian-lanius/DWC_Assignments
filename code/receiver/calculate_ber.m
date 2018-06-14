function [theo_ber] = calculate_ber(eb_n0, channel_model)
%CALCULATE_BER Calculates the theoretical BER
%   This function takes a vector of eb_n0 ratios, a string describing the
%   channel model and a string describing the modulation type and
%   calculates the theoretical bit error rate. It is assumed that the eb_n0
%   ratio is given in dB
%   The value is the same for BPSK and QPSK, as they can be thought of as
%   two orthogonal carriers, thus they don't interfere with each other. The
%   reduced Eb_N0 is perfectly compensated by the increased amount of bits
%   sent in a single T_s/decreased T_s

eb_n0_lin = 10.^(eb_n0/10);
%% Calculation for BPSK/QPSK with AWGN
% Taken from the lecture slides
if strcmp(channel_model,'AWGN')
    error_prob = 1/2 .* erfc(sqrt(eb_n0_lin));
    theo_ber = error_prob;
    return
end

%% Calculation for BPSK/QPSK with Rayleigh
% Taken from the lecture slides
if strcmp(channel_model,'Rayleigh')
    error_prob = 0.5*(1-sqrt(eb_n0_lin./(1+eb_n0_lin)));
    theo_ber = error_prob;
    return
end
% This point should never be reached, the channel_model string was invalid
% in this case.
error('Not implemented');

end

