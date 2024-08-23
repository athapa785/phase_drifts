start_date = datetime(2023, 6,8, 0, 0, 0, 0); %set start date
end_date = datetime(2023, 6, 10, 0 , 0, 0, 0); %set end date

t=start_date:end_date;

for i=1:length(t)
    [y,m,d,h,M,s]=datevec(t(i));

    dirname = sprintf('/u1/lcls/matlab/data/%d/%d-%02d/%d-%02d-%02d/SRFFine*.mat',...
    y, y, m, y, m, d);
    files = dir(dirname);    