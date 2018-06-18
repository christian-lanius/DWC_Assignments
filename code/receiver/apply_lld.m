function binary_seq = apply_lld(recv_signal, modulation_mode, eb_n0, H_measured)
%APPLY_LLD Calculates the log likelihood ratios.
% variance = 10.^(eb_n0/10);
% 
% if strcmp(modulation_mode, 'QPSK')
%     variance = 0.5*variance;
% end

% Mapping for BPSK
S_n1 = -1;
S_p1 = 1;

% Mapping for QPSK, Grey Coding. Technically completly arbitrary, has to
% match the mapping on the sender side
S_00 = (+1 + 1j)*sqrt(0.5);
S_01 = (-1 + 1j)*sqrt(0.5);
S_10 = (+1 - 1j)*sqrt(0.5);
S_11 = (-1 - 1j)*sqrt(0.5);

% var_matrix = repmat(variance', [1 length(recv_signal)]);
recv_signal = recv_signal';
if strcmp(modulation_mode, 'BPSK')
%     L_p1 = exp(-(abs(recv_signal-H_measured*S_p1).^2)./var_matrix);
%     L_n1 = exp(-(abs(recv_signal-H_measured*S_n1).^2)./var_matrix);
    
    L_p1 = abs(recv_signal-H_measured'*S_p1).^2;
    L_n1 = abs(recv_signal-H_measured'*S_n1).^2;
    
    ratio = L_p1./L_n1;
    binary_seq = (ratio<1);
    return;
end

if strcmp(modulation_mode, 'QPSK')
    % Calculate log likelihood ratios for both bits
    L_p1 = (abs(recv_signal-H_measured'*S_00).^2) + (abs(recv_signal-H_measured'*S_01).^2);
    L_n1 = (abs(recv_signal-H_measured'*S_10).^2) + (abs(recv_signal-H_measured'*S_11).^2);
%     
%     L_p1 = exp(-(abs(recv_signal-H_measured*S_00).^2)./var_matrix) + ...
%            exp(-(abs(recv_signal-H_measured*S_01).^2)./var_matrix);
%     L_n1 = exp(-(abs(recv_signal-H_measured*S_10).^2)./var_matrix) + ...
%            exp(-(abs(recv_signal-H_measured*S_11).^2)./var_matrix);
    ratio_1 = L_p1./L_n1;
    
    L_p2 = (abs(recv_signal-H_measured'*S_00).^2) + (abs(recv_signal-H_measured'*S_10).^2);
    L_n2 = (abs(recv_signal-H_measured'*S_01).^2) + (abs(recv_signal-H_measured'*S_11).^2);
    
%     L_p2 = exp(-(abs(recv_signal-H_measured*S_00).^2)./var_matrix) + ...
%            exp(-(abs(recv_signal-H_measured*S_10).^2)./var_matrix);
%     L_n2 = exp(-(abs(recv_signal-H_measured*S_01).^2)./var_matrix) + ...
%            exp(-(abs(recv_signal-H_measured*S_11).^2)./var_matrix);
    ratio_2 = L_n2./L_p2;   

    % Serialize bits with reshape, kind of ugly
    data = cat(3, ratio_2, ratio_1);
    data = permute(data, [1 3 2]);
    num_eb_n0 = size(recv_signal,1);
    data = reshape(data, [num_eb_n0, 2*length(recv_signal)]);
    % Hard decision boundary => makes LLR kind of useless. Ratio should
    % be used by the FEC decoder/ soft decoder to minimize error
    binary_seq = (data>1);
    return;
end
error('Not implemented');
end

