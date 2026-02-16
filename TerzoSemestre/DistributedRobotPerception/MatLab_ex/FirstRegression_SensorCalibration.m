clear all;
clc;

%% Sensor definition

% Sensor parameters
order = 3; % this define a third order polynomial. 
a = (rand(1,order)-0.5)*10; % random coefficients of the polynomial

% Time delta range
Dt.max = 10;
Dt.min = -10;

% Define the input data
dt = Dt.min:0.1:Dt.max; % set di dati di input, a time serie

% Number of samples
n = length(dt);

% Actual sensor readings
H_model = [];
for i=1:order
    H_model = [H_model, dt.^(i-1)']; % construct H matrix
end
z = H_model*a'; % the real measurements of the sensor, the ones that we 
                % try to estimate


%% Regression

% Testing points, a little set of points that allow to do a limited number
% of measures to try to understand the general behaviour of the system
m = 20;
dt_test = (rand(1,m)*(Dt.max - Dt.min)) + Dt.min;

% First order hypothesis
order_est = 2; % at the beginning we dont know the order of the polynomia

% Maximum tolerable fitting error
MaxTolError = 1e-1;

MaxOrder = m;
for Ord = 2:MaxOrder

    % Reference with accurate sensor
    H_model_test = [];
    for i=1:order % use the REAL order
        H_model_test = [H_model_test, dt_test.^(i-1)']; % create the matrix
                                                        % based on real
                                                        % order
    end
    z_test = H_model_test*a(1:order)'; % compute REAL measurements that 
                                       % sensor should generate for inputs 
                                       % dt_test

    % Go with the regression!!
    H = [];
    for i=1:Ord % use HYPOTHETICAL order
        H = [H, dt_test.^(i-1)']; % build matrix based on hypotesis
    end

    % Solve the regression
    a_est = inv(H'*H)*H'*z_test; % compute the coefficient of the 
                                 % polynomia a_est that produce the minimum
                                 % quadratic error for the current
                                 % hypotesis

    % Squared Error
    Error = (z_test - H*a_est)'*(z_test - H*a_est)/m;
    if Error < MaxTolError %The objective is not to find the PERFECT model,
                           %but the simplest model of which the estimation 
                           %is the best
        break;
    end
end



%% Plot

figure(1), clf, hold on;
plot(dt, z, 'b--', 'LineWidth', 2);
grid on;
set(gca, 'FontSize', 30);
z_est = H_model(:,1:Ord)*a_est;
plot(dt, z_est, 'r:', 'LineWidth', 2);
legend('Actual', 'Estimated', 'Location', 'best');


Ord

order