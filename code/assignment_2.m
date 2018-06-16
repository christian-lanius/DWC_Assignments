clearvars;
addpath('receiver', 'transmitter');
%% Settings
num_subcarriers = 256;
num_guard_samples = 32;
input_length_awgn = num_subcarriers*100;
max_eb_n0_awgn = 20;
%% Do calculations for BPSK and AWGN
channel_model = 'AWGN';
modulation_mode = 'BPSK';
max_eb_n0 = max_eb_n0_awgn;
input_length = input_length_awgn;

eb_n0 = 0:1:max_eb_n0;

% eb_n0 = [15;1000]';
binary_input = create_input_signal(input_length);
baseband_signal = map_to_symbol(binary_input, modulation_mode);
% baseband_signal = [1:input_length_awgn]';
% [baseband_signal, pilot_sequence] = add_pilot_sequence(baseband_signal);
parallel_signal = symbol_to_ofdm(baseband_signal, num_subcarriers);
% parallel_signal = baseband_signal;
parallel_signal_with_prefix = add_cyclic_prefix(parallel_signal, num_guard_samples);
% foo = [1:(num_subcarriers+num_guard_samples)]';
% foo_rep = repmat(foo,1,100);
% parallel_signal_with_prefix = foo_rep;
time_signal = parallel_to_serial(parallel_signal_with_prefix);

%% CHANNEL
[recv_signal, H] = apply_channel(time_signal, modulation_mode, channel_model, eb_n0, num_subcarriers, num_guard_samples);

% recv_signal = time_signal;
%% Receiver
parallel_recv_signal_with_prefix = serial_to_parallel(recv_signal, num_subcarriers, num_guard_samples);

parallel_recv_signal = remove_cyclic_prefix(parallel_recv_signal_with_prefix, num_guard_samples);
baseband_recv_signal = ofdm_to_baseband(parallel_recv_signal, num_subcarriers);
% [baseband_recv_signal, channel_resp] = remove_pilot_sequence(baseband_recv_signal, pilot_sequence);

binary_recv_signal = apply_lld(baseband_recv_signal, modulation_mode, eb_n0, 1);
measured_ber = calculate_measured_ber(binary_input', binary_recv_signal)
scatter(real(baseband_recv_signal(:, 1)), imag(baseband_recv_signal(:, 1)), 8, 'filled'); 
grid on
grid minor
xlim([-2 2])
ylim([-2 2])
pbaspect([1 1 1])
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
