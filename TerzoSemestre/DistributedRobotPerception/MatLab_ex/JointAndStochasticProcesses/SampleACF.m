clear all;
clc;

%% Generate model

a1 = 0.1;
b0 = 1;
b1 = 2;
b2 = 3;
n = 1e2;

u = randn(1, n);

x = zeros(1,n);
for i=3:n
    x(i) = a1*x(i-1) + b0*u(i) + b1*(u(i-1)) + b2*(u(i-2));
end

% Sample ACF
mu = 1/n*sum(x);
Lags = 20;
g = zeros(1,Lags+1);
for l=1:Lags+1
    k = l-1;
    for i=1:n-k
        g(l) = g(l) + (x(i) - mu)*(x(i+k) - mu);
    end
    % Correlation: mean of g(l)
    g(l) = g(l)/n;
end

%% Plot

figure(1), clf, hold on;
plot(x, 'b')

figure(2), clf, hold on;
autocorr(x, Lags);
stem(0:Lags, g/g(1), 'k--x');
legend('Matlab', 'Tolerance', 'Our')

