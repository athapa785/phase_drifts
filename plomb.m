figure;

for i = 1:35

    cell_array_name_phi = sprintf('phi_fits_%d', i)
    cell_array_name_time = sprintf('time_stamps_%d', i);


    [pxx, f] = periodogram(mean(phi_fit_data.(cell_array_name_phi), 2, 'omitnan'), mean(phi_fit_data.(cell_array_name_time), 2, 'omitnan'));
    %plot(f, pxx, 'DisplayName', strcat('CM',num2str(i)))
    
    %hold on;

%%

    filter_mask = ones(size(pxx));
    idx1 = find(f >= 1.89, 1);
    idx2 = find(f >= 0.03, 1);
    filter_mask(idx1) = 0;
    filter_mask(idx2) = 0;

    filtered_pxx = pxx .* filter_mask;

    filtered_x = ifft(filtered_pxx);
    
    plot(f, filtered_x, 'DisplayName', strcat('CM',num2str(i)))
    hold on;
end 

legend('Location', 'eastoutside');
grid on;