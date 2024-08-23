level = 3;
threshold_type = 'sqtwolog';
data = mean(phi_fit_data.phi_fits_6, 2, 'omitnan')
x = mean(phi_fit_data.time_stamps_6, 2, 'omitnan')
smoothed_data = wdenoise(data, level, 'Wavelet', 'db4', 'DenoisingMethod', 'Sure', 'ThresholdRule', threshold_type);


%%
figure;
hold on;
plot(x, data)
plot(x, smoothed_data)