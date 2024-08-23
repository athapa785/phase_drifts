start_date = datetime(2023, 6,8, 0, 0, 0, 0); %set start date
end_date = datetime(2023, 6, 10, 0 , 0, 0, 0); %set end date

t=start_date:end_date;

for i=1:length(t)
    [y,m,d,h,M,s]=datevec(t(i));

    dirname = sprintf('/u1/lcls/matlab/data/%d/%d-%02d/%d-%02d-%02d/SRFFine*.mat',...
    y, y, m, y, m, d);
    files = dir(dirname);

    
    for j = 1:length(files)
        load([files(j).folder '/' files(j).name])
        %phi_cav.d{j,1} = data.name(end-3:end); %gives cavity name
        %phi_cav.d{j,2} = data.cav.phi_fit; %gives me the delta in phase
        
        cav{j} = data.name(end-3:end);
        phi(j) = data.cav.phi_fit;
        
        %cav{j} = data.name(end-3:end);
        %phi(j) = data.cav.phi_fit;   
        
        phi_dict = containers.Map(cav, phi);
    end
end

for k = 1:length(t)
    plot(t, phi_dict{k})
    hold on
end