function [] = create_scatter_plots(fig, eb_n0, recv_signal, modulation_mode, channel_model, H, row_idx, num_rows, num_cols)
%CREATE_SCATTER_PLOTS Summary of this function goes here
%   Detailed explanation goes here
ds_factor = floor(length(eb_n0)/num_cols);
idx_to_show = 3:ds_factor:length(eb_n0);
if length(idx_to_show) > num_cols
    idx_to_show = idx_to_show(1:num_cols);
end
set(0, 'currentfigure', fig);
for idx=idx_to_show
    subplot(num_rows, num_cols, num_cols*(row_idx-1) + find(idx_to_show==idx));
    title_string = sprintf('%s/%s - E_b/N_0: %d dB',modulation_mode,channel_model, eb_n0(idx));
    
    data_to_show = recv_signal(idx, :);
    data_to_show = data_to_show./H(idx,:); % Equalizing with the known channel response
    scatter(real(data_to_show), imag(data_to_show), 5,'filled');
    
    title(title_string)
    grid on
    grid minor
    xlim([-2 2])
    ylim([-2 2])
    pbaspect([1 1 1])
    
end
end

