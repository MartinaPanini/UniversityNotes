clear all;
clc;

%% Define a stochastic process

% Sampling time
Dt = 0.001; % [s]

% Time interval
t = 0:Dt:100;

% White stochastic process
sigma = 2;
n_realizations = 100;
u = randn(n_realizations,length(t))*sigma;
% u = (rand(n_realizations,length(t))-0.5)*2*sigma;

% Compute the mean
% Average = zeros(1,length(t));
% for i=1:length(t)
%     Average(i) = sum(u(:,i))/n_realizations;
% end
Average = mean(u,1);
Variance = var(u,1);

% Check if it is white
% Correlation = 0;
% for i=1:length(t)-1
%     Correlation = Correlation + u(1,i)*u(1,i+1);
% end
% Correlation = Correlation/(length(t)-1)
% Correlation = sum(u(1,1:end-2).*u(1,3:end))/(length(t)-2)


%% Random walk

% State
s = zeros(n_realizations,length(t));
g = 1;
for j=1:n_realizations
    for i=1:length(t)-1
        s(j,i+1) = g*s(j,i) + Dt*u(j,i);
    end
end


%% Plot

figure(1), clf, hold on;
plot(t, u(1,:), 'b');
xlabel('[s]');
ylabel('Random variable');
set(gca, 'FontSize', 18);

figure(2), clf, hold on;
plot(t, Average, 'b');
xlabel('[s]');
ylabel('Average');
set(gca, 'FontSize', 18);

% figure(3), clf, hold on;
% plot(t, Variance, 'b');
% xlabel('[s]');
% ylabel('Variance');
% set(gca, 'FontSize', 18);

figure(4), clf, hold on;
crosscorr(s(1,:), s(1,:), "NumLags", 10);
set(gca, 'FontSize', 18);

figure(5), clf, hold on;
for i=1:n_realizations
    plot(t, s(i,:));
end
xlabel('[s]');
ylabel('State');
set(gca, 'FontSize', 18);
