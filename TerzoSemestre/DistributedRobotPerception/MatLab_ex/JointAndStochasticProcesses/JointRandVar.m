clear all;
close all;
clc;

% Desired corraltion coefficient
rho = 0.5;

n = 1e5;

% Mean value
mu = [1; 10];
% Covariance matrix
sigma = [1, 3];
C = [sigma(1)^2, rho*sigma(1)*sigma(2); rho*sigma(1)*sigma(2), sigma(2)^2];

Data = mvnrnd(mu, C, n);

for i=1:2
    disp(['Th mean ', num2str(i), ': ', num2str(mu(i)), '; Numerical mean ', num2str(i), ': ', num2str(sum(Data(:,i))/n)]);
    disp(['Th variance ', num2str(i), ': ', num2str(sigma(i)^2), '; Numerical variance ', num2str(i), ': ', num2str(sum((Data(:,i) - sum(Data(:,i))/n).^2)/(n-1))]);
end
disp(['Th Covariance: ', num2str(rho*sigma(1)*sigma(2)), '; Numerical Covariance: ', num2str(sum(Data(:,1).*Data(:,2))/n - sum(Data(:,1))/n*sum(Data(:,2))/n)]);
disp(['Th rho: ', num2str(rho), '; Numerical rho: ', num2str((sum(Data(:,1).*Data(:,2))/n - sum(Data(:,1))/n*sum(Data(:,2))/n)/(sqrt(sum((Data(:,1) - sum(Data(:,1))/n).^2)/(n-1)*sum((Data(:,2) - sum(Data(:,2))/n).^2)/(n-1))))]);

% Linear dependency
sigma_z = 2;
if abs(rho) > 1e-3
    a = sigma(2)/sigma(1)*rho;
    c = sqrt(a^2*sigma(1)^2*(1 - rho^2)/(sigma_z^2*rho^2));
else
    c = sqrt(sigma(2)^2/sigma_z^2*(1 - rho^2));
    a = c*sigma_z*rho/(sqrt(1 - rho^2)*sigma(1));
end
if abs(rho) == 1
    mu_z = 0;
    b = mu(2) - a*mu(1);
else
    b = 0;
    mu_z = (mu(2) - a*mu(1) - b)/c;
end
Data2 = a*Data(:,1) + b + c*(randn(n,1)*sigma_z + mu_z);

%% Plot

FigID = 0;

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(Data(:,1), Data(:,2), 'bx');
plot(Data(:,1), Data2, 'ro');
axis equal;