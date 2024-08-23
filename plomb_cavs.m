figure;

for i = 1:8
    [pxx, f] = plomb(phi_fit_values(:,i), time_stamps(:,1));
    plot(f, pxx)
    hold on;
end

hold off;