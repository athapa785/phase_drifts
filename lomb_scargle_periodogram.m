figure;
for itr = 1:35

    v_phi = sprintf('phi_fits_%d', itr);
    v_time = sprintf('time_stamps_%d', itr);

    [power, frequency] = periodogram(phi_fit_data.(v_phi)(:, itr), phi_fit_data.(v_time)(:, itr));

    plot(frequency, power)
end


%{
errors:

lomb_scargle_periodogram
Error using periodogram
Expected x to be finite.

Error in computeperiodogram>validateinputs (line 174)
validateattributes(x2,{'single','double'}, {'finite','nonnan'},'periodogram','x');

Error in computeperiodogram (line 61)
[x1,~,y,is2sig,win1] = validateinputs(x,win,nfft);

Error in periodogram (line 215)
[Sxx,w2,RSxx,wc] = computeperiodogram(x,win,nfft,esttype,Fs,options);

Error in lomb_scargle_periodogram (line 7)
    [power, frequency] = periodogram(phi_fit_data.(v_phi)(:, itr), phi_fit_data.(v_time)(:, itr));

%}