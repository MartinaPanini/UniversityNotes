clear all;
clc;

% d = (t1 - t0)/2*c

% Actual time of the emitting signal
t0 = 10e-3;     % [s]
t1 = t0 + 2e-8;     % [s]

% Actual distance [m]
c = 3e8;    % [m/s]
d = (t1 - t0)/2*c;

%% Time measurements

% Number of collected measurements
n = 1e6;

% Bias of the measurements
b = 0;   % [s]

t0_m = t0 + randn(1,n)*1e-9 + b*ones(1,n);
% t0_m = t0 + (rand(1,n)-0.5)*1e-9 + b*ones(1,n);

t1_m = t1 + randn(1,n)*1e-9 + b*ones(1,n);
% t1_m = t1 + (rand(1,n)-0.5)*1e-9 + b*ones(1,n);

% Measured distance
d_m = (t1_m - t0_m)/2*c;

% Sample mean
d_m_mean = sum(d_m)/length(d_m);

% Mean squared error
MSE_d = sum((d_m - d_m_mean).^2)/length(d_m);

% Root measn squared error
RMSE_d = sqrt(MSE_d);

% Avearages
% VectorOfAvearges = zeros(1,n);
% for i=1:n
%     VectorOfAvearges(i) = sum(d_m(1:i))/i;
% end
VectorOfAvearges = cumsum(d_m)./(1:n);

%% Plot

figure(1), clf, hold on;
plot(1:n, t0_m, 'b-', 'LineWidth', 2);
plot(1:n, t0*ones(1,n), 'r--', 'LineWidth', 2);
plot(1:n, t1_m, 'k-', 'LineWidth', 2);
plot(1:n, t1*ones(1,n), 'g--', 'LineWidth', 2);
xlabel('Samples');
ylabel('t0 [s]');
set(gca, 'FontSize', 20);
legend('Calibrated t_0', 'Actual time t_0', 'Calibrated t_1', 'Actual time t_1', 'Location', 'best');

figure(2), clf, hold on;
h1 = histogram(t1_m*1e3, 1e2);
h = histogram(t0_m*1e3, 1e2);
set(gca, 'FontSize', 20);
xlabel('t0 [ms]');
ylabel('Number of samples');

% Histogram generation
Prob = h.Values/sum(h.Values);
Prob1 = h1.Values/sum(h1.Values);
figure(3), clf, hold on;
stem(h.BinEdges(1:end-1)+h.BinWidth/2, Prob, 'b', 'LineWidth', 2)
stem(h1.BinEdges(1:end-1)+h1.BinWidth/2, Prob1, 'r', 'LineWidth', 2)
legend('t_0', 't_1', 'Location', 'best');
xlabel('t [ms]');
ylabel('Probability');
set(gca, 'FontSize', 20);

% Plotting the distance
figure(4), clf, hold on;
plot(1:n, d_m, 'b-', 'LineWidth', 2);
plot(1:n, d*ones(1,n), 'r--', 'LineWidth', 2);
xlabel('Samples');
ylabel('d [m]');
set(gca, 'FontSize', 20);
legend('Calibrated d', 'Actual d', 'Location', 'best');

figure(5), clf, hold on;
hd = histogram(d_m, 1e2);
set(gca, 'FontSize', 20);
xlabel('d [m]');
ylabel('Number of samples');

% Histogram generation
Probd = hd.Values/sum(hd.Values);
figure(6), clf, hold on;
stem(hd.BinEdges(1:end-1)+hd.BinWidth/2, Probd, 'b', 'LineWidth', 2)
legend('d', 'Location', 'best');
xlabel('d [m]');
ylabel('Probability');
set(gca, 'FontSize', 20);

% Plot the averages!
figure(7), clf, hold on;
plot(1:n, VectorOfAvearges, 'b', 'LineWidth', 2);
plot(1:n, d*ones(1,n), 'r--', 'LineWidth', 2);
legend('Estimated d', 'Actual d', 'Location', 'best');
xlabel('Numer of averaged samples');
ylabel('[m]');
set(gca, 'FontSize', 20);

figure(7), clf, hold on;
plot(1:n, abs(d - VectorOfAvearges), 'b', 'LineWidth', 2);
set(gca, 'YScale', 'log');
legend('Estiamtion error', 'Location', 'best');
xlabel('Numer of averaged samples');
ylabel('[m]');
set(gca, 'FontSize', 20);