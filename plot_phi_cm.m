%Author: Adi (aaditya)

%plot_size
plotWidth = 2000; %in pixels
plotHeight = 500; %in pixels

figure('Position', [100, 100, plotWidth, plotHeight]);

for label_indx = 1:4
    plot(phi_fit_data.time_stamps(:,label_indx), phi_fit_data.phi_fit_values(:,label_indx), 'o-', 'DisplayName', cavity_names{label_indx})
    hold on;
end


for label_indx = 5:length(phi_fit_values(1,:))
    plot(phi_fit_data.time_stamps(:,label_indx), phi_fit_data.phi_fit_values(:,label_indx), 'o--', 'DisplayName', cavity_names{label_indx})
    hold on;
end

hold off;

xlabel('Days');
ylabel('\Delta\Phi');
datetick('x', 'mm/dd')

%if length(cavity_names) == 8
title(['\Delta\Phi values for CM ', cryomodule]);
%else
%    title(['\Delta\Phi values for cavities ', cavity_names]);
%end

legend('Location', 'eastoutside');
grid on;

%save plot as png
filename = strcat('cm_', cryomodule, '_', datestr(start_date, 'mm_dd_yy'),'_to_', datestr(end_date, 'mm_dd_yy'), '.png');
saveas(gcf, filename, 'png');