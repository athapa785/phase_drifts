%Standardize the phi_fit_values
phi_fit_values_std = (phi_fit_values - mean(phi_fit_values))/std(phi_fit_values);

%Perform PCA
X = [phi_fit_values_std, time_stamps]; %concatenate standardized phi_fit_values with time_stamps
coeff = pca(X); %perform PCA on concatenated matrix

%Extract princiapl components
pc1 = coeff(:,1); %First principal component
pc2 = coeff(:,2); %Second principal component

%Plot the PCA results
figure;
scatter(pc1, pc2);
xlabel('Principle Component 1');
ylabel('Principle Component 2');
title('PCA on \Delta\Phi');