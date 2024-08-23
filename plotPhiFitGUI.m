function plotPhiFitGUI()
    %Create a figure for the GUI
    fig = figure('Position', [100,100,400,300]);
    
    %Create UI controls for start date, end date. and cavity names
    uicontrol('Style',  'text', 'Position', [50,220,80,20], 'String', 'Start Date:');
    startDateEdit = uicontrol('Style', 'edit', 'Position', [150,220,120,20]);
    
    uicontrol('Style',  'text', 'Position', [50,180,80,20], 'String', 'End Date:');
    endDateEdit = uicontrol('Style', 'edit', 'Position', [150,180,120,20]);
    
    uicontrol('Style',  'text', 'Position', [50,140,80,20], 'String', 'Cavity Name:');
    cavityNameEdit = uicontrol('Style', 'edit', 'Position', [150,140,120,20]);
    
    %Create a button to trigger the plot
    plotButton = uicontrol('Style', 'pushbutton', 'Position', [150,100,80,30], 'String', 'Plot', 'Callback', @plotButtonCallback);
    
    %Callback function for the plot button
    function plotButtonCallback(~, ~)
        %Get the input calues from the GUI controls
        start_date = datetime(startDateEdit.string, 'InputFormat', 'yyyy/MM/dd'); 
        end_date = datetime(endDateEdit.string, 'InputFormat', 'yyyy/MM/dd'); 
        cavity_names = strsplit(cavityNameEdit.String, ',');
        cavity_names = strtrim(cavity_names);
        
        %plot the phi_fit values
        plotPhiFit(start_date, end_date, cavity_names);
    end

%Function to plot the phi_fit values for the specified cavities
    function plotPhiFit(start_date, end_date, cavity_names)
        %Initialize arrays to store phi_fit and timestamps
        phi_fit_values = [];
        time_stamps = [];
        
        %Iterate through the files and filter data based on data range and
        %cavity names
        dirname = sprintf('/u1/lcls/matlab/data/%d/%d-%02d/%d-%02d-%02d/SRFFine*.mat',...
        y, y, m, y, m, d);
        files = dir(dirname);
        
        for fileIndex = 1:length(files)
            load([files(fileIndex).folder '/' files(fileIndex).name]);
            
            %Filter data based on data range
            data_dates = datetime(data.ts, 'ConvertFrom', 'datenum');
            within_date_range = data_dates >= start_date & data_dates <= end_date;
            
            if any(within_date_range)
                %filter data based on cavity names
                cavity_match = ismember(data.name(:, end), cavity_name);
                
                if any(cavity_match)
                    %Append the filter phi_fit values and timestamps
                    phi_fit_values = [pih_fit_values; data.cav.phi_fit(within_date_range & cavity_match)];
                    time_stamps = [time_stamps; data.ts(within_date_range & cavity_match)];
                end
            end
        end
        %Plot the phi_fit vales with respect to timestamps for the
        %selected cavities
        figure;
        plot(time_stamps, phi_fit_values, 'o-');
        
        %Customize the plot
        xlabel('Time Stamp');
        ylabel('\Delta\Phi');
        grid on;
    end
end
