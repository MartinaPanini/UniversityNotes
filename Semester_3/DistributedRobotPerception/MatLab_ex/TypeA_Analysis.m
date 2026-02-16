clear all;
clc;

% d = (t1 - t0)/2*c

% Actual time of the emitting signal
t0 = 3;     % [s]

%% Time measurements

% Number of collected measurements
n = 1e5;

% Bias of the measurements
b = 1e-1;   % [s]

% t0_m = t0 + randn(1,n)*1e-2 + b*ones(1,n);
t0_m = t0 + (rand(1,n)-0.5)*2e-2 + b*ones(1,n);

%% Bias removal (i.e., calibration)

% Average
Mean_Time = sum(t0_m)/n;

% Estimated bias
b_est = Mean_Time - t0;

% Calibrated measurements
t0_c = t0_m - b_est;


%% Plot

figure(1), clf, hold on;
plot(1:n, t0_m, 'b-', 'LineWidth', 2);
plot(1:n, t0_c, 'k:', 'LineWidth', 4);
plot(1:n, t0*ones(1,n), 'r--', 'LineWidth', 2);
set(gca, 'FontSize', 20);
legend('Measured time', 'Calibrated', 'Actual time', 'Location', 'best');

figure(2), clf, hold on;
histogram(t0_c, 1e2);
set(gca, 'FontSize', 20);