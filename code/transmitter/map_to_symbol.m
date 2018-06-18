function [input_signal] = map_to_symbol(binary_signal, modulation_mode)

if strcmp(modulation_mode, 'BPSK')
    % Binary NRZ
    input_signal = 2*binary_signal-1;
    return
end
input_length = length(binary_signal);
if strcmp(modulation_mode, 'QPSK')
    % Map two consecutive bits to I and Q phase
    % Scale with sqrt(.5) to obtain unit vector length
    input_signal = 2*binary_signal(1:2:(input_length))-1 + ...
                   (2*binary_signal(2:2:(input_length))-1)*1j;
    input_signal = input_signal*sqrt(0.5);
end
end

