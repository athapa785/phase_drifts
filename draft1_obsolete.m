start_date = datetime(2023, 6,8, 0, 0, 0, 0); %set start date
end_date = datetime(2023, 6, 10, 0 , 0, 0, 0); %set end date

t=start_date:end_date;

%need to make a different cell array for each i iteration

phi_cav = struct(); %initialize a structure to stroe the phi_fit values
    
for i=1:length(t)
    [y,m,d,h,M,s]=datevec(t(i));

    dirname = sprintf('/u1/lcls/matlab/data/%d/%d-%02d/%d-%02d-%02d/SRFFine*.mat',...
    y, y, m, y, m, d);
    files = dir(dirname);

    
    phi_fit_array = {}; %initialize an empty array to store phi_fit values for a day
    %cavity_name_array = {}; %initialize an empty cell array to store cavity names for a day
    
    for j = 1:length(files)
        load([files(j).folder '/' files(j).name]);
        
        %store cavity name
        phi_fit_array{j,1} = data.name(end-3:end); %gives cavity name
        
        %Extract phi_fit and store it in the array
        phi_fit_array{j,2} = data.cav.phi_fit; %gives me the delta in phase
        
        %Extract timestamps for phi_fit
        phi_fit_array{j,3} = data.ts;
    end
    
    phi_cav.d{i}.phit_fit = phi_fit_array; %store the phi_fit array for the day
    
end


