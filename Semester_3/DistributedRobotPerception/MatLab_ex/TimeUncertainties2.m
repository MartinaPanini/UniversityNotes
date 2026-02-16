clear all;
clc;

% d = (t1-t0)/2*c

% Actual time of the emitting signal
t0 = 10e-3; % [s]
t1 = t0 + 2e-8;  % [s]

% Actual distance 
c = 3e8; %[m/s]
d = (t1 - t0)/2 * c; %[m]

%% Time measurments

% Number of collected measurment
n = 1e5;

% Bias of the measurment
%b = 1e-1; % [s]
b = 0;
t0_m = t0 + randn(1, n) * 1e-9 + b * ones(1, n);
% t0_m = t0 + (rand(1, n) - 0.5) * 2e-2 + b * ones(1, n);

t1_m = t1 + randn(1, n) * 1e-9 + b * ones(1, n);
% t1_m = t1 + (rand(1, n) - 0.5) * 2e-2 + b * ones(1, n);

% Measured Distance
d_m = (t1_m - t0_m)/2 * c; 

%% Bias Removal (calibration)

% Average
%mean_time = sum(t0_m) / n;

% Estimated Bias
%b_est = mean_time - t0;

% Calibrated measuremnts
%t0_c = t0_m - b_est;

% Sample Mean
d_m_mean = sum(d_m)/length(d_m);

% Mean Squared Error
MSE_d = sum((d_m - d_m_mean).^2)/length(d_m); 

% Root Mean Squared Error
RMSE_d = sqrt(MSE_d);

% Avearages
% VectorOfAverages = zeros(1,n); 
% for i=1:n
%     VectorOfAverages(i) = sum(d_m(1:i))/i;
% end

VectorOfAverages = cumsum(d_m)./(1:n);

%% Plot

figure(1), clf, hold on;
plot(1:n, t0_m, 'b-');
plot(1:n, t0 * ones(1, n), 'r--');
plot(1:n, t1_m, 'k-');
plot(1:n, t1 * ones(1, n), 'g--');
xlabel("Samples");
ylabel("t0 [s]")
%plot(1:n, t0_c, 'k:');
legend('Actual time t_0', 'Calibrated time t_0', 'Actual time t_1', 'Calibrated time t_1', 'Location', 'best');

figure(2), clf, hold on;
h = histogram(t0_m*1e3, 1e2);
h1 = histogram(t1_m*1e3, 1e2);
xlabel(("t0 [ms]"));
ylabel("Number of Samples")
% histogram(t0_m - mean_time); % Check: if the sensor is calibrated must be
% centered in zero

% Histogram Generation 

Prob = h.Values/sum(h.Values);
Prob1 = h1.Values/sum(h1.Values);

figure(3), clf, hold on;
stem(h.BinEdges(1:end-1)+h.BinWidth/2, Prob, 'b');
stem(h1.BinEdges(1:end-1)+h1.BinWidth/2, Prob1, 'r');
legend('t_0', 't_1')
xlabel(("t0 [ms]"));
ylabel("Probability")



% Plotting the distance 
figure(4), clf, hold on;
plot(1:n, d_m, 'b-');
plot(1:n, d * ones(1, n), 'r--');
xlabel("Samples");
ylabel("d [m]")
%plot(1:n, t0_c, 'k:');
legend('Actual  d', 'Calibrated d', 'Location', 'best');

figure(5), clf, hold on;
hd = histogram(d_m, 1e2);
xlabel(("d [m]"));
ylabel("Number of Samples")
% histogram(t0_m - mean_time); % Check: if the sensor is calibrated must be
% centered in zero

% Histogram Generation 
Probd = hd.Values/sum(hd.Values);

figure(6), clf, hold on;
stem(hd.BinEdges(1:end-1)+hd.BinWidth/2, Probd, 'b');
xlabel(("d [m]"));
ylabel("Probability")

% Plot the avarages
figure(7), clf, hold on;
plot(1:n, VectorOfAverages, 'b');
plot(1:n, d*ones(1,n), 'r--');
legend("Estimated d", "Actual d", "Location","best");
xlabel("Number of averaged samples");
ylabel("[m]")

figure(8), clf, hold on;
plot(1:n, abs(d-VectorOfAverages), 'b');
set(gca, "Yscale", "log");
legend("Estimation error d", "Location","best");
xlabel("Number of averaged samples");
ylabel("[m]")
