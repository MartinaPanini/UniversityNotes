clear all;
clc;

% d = (t1 -t0) / 2*c

t0 = 3; % Actual time of the emitting signal

%% Time measurements

% Number of collected measurements 
n = 1e5;

%Bias of the measurements
b=1e-1; % [s]

t0_m = t0 + randn(1, n)*1e-2 + b * ones(1,n); % histogram with gaussian
%t0_m = t0 + (rand(1, n)-0.5)*2e-2 + b * ones(1,n); % histogram of uniform
                                                    % distribution
% In the two distributions the randomness is completelly different

% Plots are different between the two computations of t0_m. 
% To know what representation is better you define a set of intervals [t0
% +/_ delta_t] around t0 and counting how many points are in that
% intervals.
% So I compute a relative frequency Ni/n --> Frequentist definiton of
% probability

%% Bias Removal

MeanTime = sum(t0_m)/n; % average
b_est = MeanTime - t0; % bias estimated

% Calibrated measurements
t0_c = t0_m - b_est; % t0 calibrated

%% Plot

figure(1), clf, hold on;
plot(1:n, t0*ones(1,n), 'r--', 'LineWidth', 2);
plot(1:n, t0_m, 'b-','LineWidth', 2);
plot(1:n, t0_c, 'k:','LineWidth', 4);
set(gca, 'FontSize', 20);
legend('Actual time', 'Measured Time', 'Calibrated Time', 'Location', 'best');

figure(2), clf, hold on;
histogram(t0_c - t0); % For a calibrated sensor, uncertainties are
                      % centered in 0, otherwise is centered in 0.1 (bias)
                  
% If i dont know that the sensor is calibrated you compute t0_m - MeanTime,
% in the sensor is calibrated the difference (?) is zero.
figure(3), clf, hold on;
histogram(t0_m - MeanTime, 1e5); % Increasing number of bins (1e5) the 
                                 % histogram is less and less clear. A
                                 % trade-off must be reach between number
                                 % of data and number of bins