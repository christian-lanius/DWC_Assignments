clearvars;
%% Settings
num_subcarriers = 256;
num_guard_samples = 0;
input_length_awgn = num_subcarriers*100;
max_eb_n0_awgn = 50;
%% Do calculations for BPSK and AWGN
channel_model = 'AWGN';
modulation_mode = 'BPSK';
max_eb_n0 = max_eb_n0_awgn;
input_length = input_length_awgn;

eb_n0 = 0:1:max_eb_n0;

eb_n0 = [0,1000];
binary_input = create_input_signal(input_length);
baseband_signal = map_to_symbol(binary_input, modulation_mode);
% [baseband_signal, pilot_sequence] = add_pilot_sequence(baseband_signal);
parallel_signal = symbol_to_ofdm(baseband_signal, num_subcarriers);
% parallel_signal = add_cyclic_prefix(parallel_signal, num_guard_samples);
time_signal = parallel_to_serial(parallel_signal);

%% CHANNEL
% recv_signal = apply_channel(time_signal, modulation_mode, channel_model, eb_n0);
recv_signal = time_signal;
%% Receiver
parallel_recv_signal = serial_to_parallel(recv_signal, num_subcarriers, num_guard_samples);
parallel_recv_signal = conj(parallel_recv_signal);
% parallel_recv_signal = remove_cyclic_prefix(parallel_recv_signal, num_guard_samples);
baseband_recv_signal = ofdm_to_baseband(parallel_recv_signal);
% [baseband_recv_signal, channel_resp] = remove_pilot_sequence(baseband_recv_signal, pilot_sequence);
binary_recv_signal = apply_lld(baseband_recv_signal', modulation_mode, eb_n0, 1);
measured_ber = calculate_measured_ber(binary_input, binary_recv_signal)
% scatter(real(baseband_recv_signal), imag(baseband_recv_signal), 5, 'filled'); 

%%CHANNEL
% channel_resp = fade(1, 10e5, 1, 2e-4*3.84e6, 1, 1/3.84e6);
% time_signal_rec = zeros(1009999,num_subcarriers);
% for sub_carrier=1:num_subcarriers
%     time_signal_rec(:,sub_carrier) = conv(channel_resp, time_signal(:,sub_carrier));
% end
% % time_signal_rec = conv(channel_resp, time_signal);
% %%Receiver side
% baseband_received = ofdm_to_baseband(time_signal_rec);
% scatter(real(baseband_received), imag(baseband_received), 5, 'filled'); 
% grid on
% grid minor
% xlim([-2 2])
% ylim([-2 2])
% pbaspect([1 1 1])
