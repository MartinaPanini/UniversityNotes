clear all;
clc;

% Number of samples
n = 1e4;

% Epsilon
Epsilon.mean = 0;
Epsilon.StdDev = 2;

% Eta
Eta.mean = 0;
Eta.StdDev = 1;

% Random sequence
Epsilon.Values = randn(n,1)*Epsilon.StdDev + Epsilon.mean;
Eta.Values = randn(n,1)*Eta.StdDev + Eta.mean;

%% Our stochastic processes: distance

% Sampling time
DeltaT = 0.01;  % [s]

% Actual distance
rho = 10;   % [m]

% Measurements
rho_bar = zeros(n,1);

% For each time step
for i=1:n
    rho_bar(i) = rho + rand(1)*Epsilon.StdDev + Epsilon.mean;
end


%% Our stochastic processes: angles

% Initial angle
Theta0 = 0;

% Angle increase
DeltaTheta = .005;

% Measurements
Theta_k = zeros(n,1);
Theta_k(1) = Theta0;

% For each time step
a = 1;
for i=1:n-1
    Theta_k(i+1) = a*Theta_k(i) + DeltaTheta + randn(1)*Eta.StdDev + Eta.mean;
end


%% Our stochastic processes: unicycle wheels

% Radii
Radii = .2;     % [m]

% Initial angle
Theta_R0 = 0;
Theta_L0 = 0;

% Angle increase
DeltaThetaR = .005;
DeltaThetaL = .005;

% Measurements
ThetaR_k = zeros(n,1);
ThetaR_k(1) = Theta_R0;
ThetaL_k = zeros(n,1);
ThetaL_k(1) = Theta_L0;

% For each time step
a = 1;
for i=1:n-1
    ThetaR_k(i+1) = a*ThetaR_k(i) + DeltaThetaR + randn(1)*Eta.StdDev + Eta.mean;
    ThetaL_k(i+1) = a*ThetaL_k(i) + DeltaThetaL + randn(1)*Eta.StdDev + Eta.mean;
end

% Wheels' velocity
Omega_R = diff(ThetaR_k)/DeltaT;


%% Plots

FigId = 0;

FigId = FigId + 1;
figure(FigId), clf, hold on;
plot(1:n, Epsilon.Values);
xlabel('Number of samples');
legend('\epsilon', 'Location', 'best');

FigId = FigId + 1;
figure(FigId), clf, hold on;
crosscorr(Eta.Values, Epsilon.Values, 'NumLags', 10);

FigId = FigId + 1;
figure(FigId), clf, hold on;
plot(DeltaT*[1:n], rho_bar);
xlabel('Time [s]');
ylabel('[m]')
legend('\rho', 'Location', 'best');

FigId = FigId + 1;
figure(FigId), clf, hold on;
autocorr(rho_bar, 'NumLags', 10);
title('\rho autocorrelation function');

FigId = FigId + 1;
figure(FigId), clf, hold on;
plot(DeltaT*[1:n], Theta_k);
xlabel('Time [s]');
ylabel('[°]')
legend('\theta', 'Location', 'best');

FigId = FigId + 1;
figure(FigId), clf, hold on;
autocorr(Theta_k, 'NumLags', 100);
title('\theta autocorrelation function');

FigId = FigId + 1;
figure(FigId), clf, hold on;
autocorr(Omega_R, 'NumLags', 100);
title('\omega autocorrelation function');
