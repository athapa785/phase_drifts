%author: Adi (aaditya)

start_date = datetime(2023, 5, 1, 0, 0, 0, 0); %set start date
end_date = datetime('today'); %set end date
t=start_date:end_date;

disp('Gathering data... This will take a while. Go for a walk or something.')


%plot setup

%plot_size
plotWidth = 2000; %in pixels
plotHeight = 500; %in pixels
figure('Position', [100, 100, plotWidth, plotHeight]);


for grand_iterator = 1:35
    
    
if grand_iterator < 10
    cryomodule = strcat('0', num2str(grand_iterator)) %'03'; %set cryomodule to for all eight cavities of a single CM
else
    cryomodule = strcat(num2str(grand_iterator))
end


%comment out last line and the loop below; and fill in the array below if
%you don't want an entire cryomodule or want cavities from different
%cryomo
cavity_names = {};


for c = 1:8
    cavity_names{c} = strcat(cryomodule, num2str(10*c)); %set cavity name
end

%cavity_name = '0210';

%cavity_names = {'0810', '0820', '0830'}

phi_fit_values = [];
time_stamps = [];

for cav_indx = 1:length(cavity_names)
    cavity_name = cavity_names(cav_indx);
    for i = 1:length(t)
        [y,m,d,h,M,s]=datevec(t(i));

        dirname = sprintf('/u1/lcls/matlab/data/%d/%d-%02d/%d-%02d-%02d/SRFFine*.mat',...
        y, y, m, y, m, d);
        files = dir(dirname);

        for j = 1:length(files)
            if strcmp(files(j).name(38:41), cavity_name)
                load([files(j).folder '/' files(j).name]);
                phi_fit_values(i, cav_indx) = abs(data.cav.phi_fit);
                time_stamps(i, cav_indx) = datenum(data.ts);
            end
        end
    end
end



%%

%find and remove rows of zeros
rowstoRemove_phi = all(phi_fit_values == 0, 2);
phi_fit_values(rowstoRemove_phi, :) = [];
rowstoRemove_time = all(time_stamps == 0, 2);
time_stamps(rowstoRemove_time, :) = [];

%remove unreal datapoints
phi_fit_values(phi_fit_values == 0) = NaN;
time_stamps(time_stamps == 0) = NaN;

%%
%
%uncomment this if you wish to save the phi_fit and time_stamp arrays

cell_array_name_phi = sprintf('phi_fits_%d', grand_iterator);
cell_array_name_time = sprintf('time_stamps_%d', grand_iterator);

phi_fit_data.(cell_array_name_phi) = phi_fit_values;
phi_fit_data.(cell_array_name_time) = time_stamps;


%{
json_phi = jsonencode(phi_fit_data);

filename_matlab = strcat('cm_', cryomodule, '_', datestr(start_date, 'mm_dd_yy'),'_to_', datestr(end_date, 'mm_dd_yy'));
filename_json = strcat('cm_', cryomodule, '_', datestr(start_date, 'mm_dd_yy'),'_to_', datestr(end_date, 'mm_dd_yy'), '.json');

save(filename_matlab, 'phi_fit_data');
disp('MAT file saved successfully.')


fileID = fopen(filename_json, 'w');
fprintf(fileID, '%s', json_phi);
fclose(fileID);
disp('JSON file saved successfully.')

%plot this using file plot_phi_cm.m in my directory

%which ver_line
%}
%%

%Plotting the data now


%plot_size
plotWidth = 2000; %in pixels
plotHeight = 500; %in pixels


%figure('Position', [100, 100, plotWidth, plotHeight]);


plot(mean(phi_fit_data.(cell_array_name_time), 2, 'omitnan'), mean(phi_fit_data.(cell_array_name_phi), 2, 'omitnan'), 'o--','DisplayName', strcat('CM', cryomodule))
hold on;


%{
for label_indx = 5:length(phi_fit_values(1,:))
    plot(phi_fit_data.(cell_array_name_time)(:,label_indx), phi_fit_data.(cell_array_name_phi)(:,label_indx), 'o--', 'DisplayName', cavity_names{label_indx})
    hold on;
end
%}

xlabel('Days');
ylabel('\Delta\Phi');
datetick('x', 'mm/dd')

%if length(cavity_names) == 8
%title(['\Delta\Phi values for CM ', cryomodule]);
title(['\Delta\Phi values for all cryomodules']);
%else
%    title(['\Delta\Phi values for cavities ', cavity_names]);
%end

legend('Location', 'eastoutside');
grid on;
hold on;

%{
%save plot as png
filename = strcat('cm_', cryomodule, '_', datestr(start_date, 'mm_dd_yy'),'_to_', datestr(end_date, 'mm_dd_yy'), '.png');
saveas(gcf, filename, 'png');
%}

end

%hold off;

disp('Are you back from your walk? Data has been gathered, plotted, and saved as MAT and JSON files. You are welcome! :)')
