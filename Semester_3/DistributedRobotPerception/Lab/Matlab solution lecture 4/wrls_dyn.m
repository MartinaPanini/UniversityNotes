% Recursive Least Squares for Positioning Problem
% Master and 3 Anchors
close all;
clear;
clc;

% Define the positions of the anchors (x, y)
anchors = [2, 0; 7, 1; 5, 4; 1, 4]; % Example positions for 3 anchors
n_anchor = size(anchors, 1);


% Number of noisy measurements
K = 100;

% Define the system dynamics
A = [0, 1; -1, 0];  % Example system matrix
state = [1; 0];  % Initial state
dt = 0.1;  % Time step

% Calculate distances from the target to each anchor
distances = sqrt(sum((anchors - state').^2, 2));

% Add noise to the distances
distances_noisy = distances + 0.1 * randn(n_anchor, 1);

% Initialize the recursive least squares
[H,z,C] = trilateration(anchors, distances_noisy, 0.1);
P = (H'*C^-1*H)^-1;
x_ls = P*H'*C^-1*z;

x_values = zeros(K, 2);
x_values(1,:) = x_ls;
P_values = P;

% Initialize the plot
figure;
hold on;
line_handle = plot(NaN, NaN, 'bo-', 'MarkerSize', 5, 'DisplayName', 'Ground truth');
plot(anchors(:,1), anchors(:,2), 'ro', 'MarkerSize', 10, 'DisplayName', 'Anchors');
line_handle_est = plot(NaN, NaN, 'g+', 'MarkerSize', 10, 'DisplayName', 'Estimated Position');
%xlim([-2, 2]);
%ylim([-2, 2]);
legend;
title('Real-Time Dynamical System Trajectory');
xlabel('x');
ylabel('y');
grid on;
hold off;

% Real-time update
x_data = [];
y_data = [];
for k = 2:2*K
    state = state + dt * A * state;
    disp("state");
    disp(state);
    x_data = [x_data, state(1)];
    y_data = [y_data, state(2)];

    % Calculate distances from the target to each anchor
    distances = sqrt(sum((anchors - state').^2, 2)) + 0.1 * randn(n_anchor, 1);

    % Update the recursive least squares
    [H,z,C] = trilateration(anchors, distances, 0.1);
    [x_ls, P] = recursive_wls(x_ls, P, z, H, C);
    x_values(k,:) = x_ls;

    % Update the plot
    set(line_handle_est, 'XData', x_values(1:k,1), 'YData', x_values(1:k,2));
    set(line_handle, 'XData', x_data, 'YData', y_data);
    drawnow;
    pause(0.05);  
end



% Iterative solution for the recursive least squares
function [x_k_1, P_k_1] = recursive_wls(x_k, P_k, z_k_1, H_k_1, C_new)
    S_k_1 = H_k_1*P_k*H_k_1' + C_new;   % Covariance of the residuals
    W_k_1 = P_k*H_k_1'*S_k_1^-1;        % Update gain
    x_k_1 = x_k + W_k_1*(z_k_1 - H_k_1*x_k);
    P_k_1 = (eye(size(P_k)) - W_k_1*H_k_1)*P_k;
end

% trilateration function 
function [H,z,C] = trilateration(anchors, distances, noise_std)
    % Number of anchors
    n = size(anchors, 1);
    
    % Initialize matrices
    H = zeros(n-1, 2);
    z = zeros(n-1, 1);
    C = zeros(n-1);
    
    % Iterate over all anchors
    for i = 1:n-1
        % Fill the matrices
        H(i, :) = 2*[anchors(i+1, 1) - anchors(i, 1), anchors(i+1, 2) - anchors(i, 2)];
        z(i) = - distances(i+1)^2  + distances(i)^2 + anchors(i+1, 1)^2 - anchors(i, 1)^2 + anchors(i+1, 2)^2 - anchors(i, 2)^2;
        % Fill the covariance matrix
        if i == 1
            C(i,i) = 4 * noise_std^2 * (distances(i+1)^2 + distances(i)^2);
            if n > 2
                C(i,i+1) = -4 * noise_std^2 * distances(i+1)^2;
            end
        elseif i < n-1
            C(i,i-1) = -4 * noise_std^2 * distances(i)^2;
            C(i,i) = 4 * noise_std^2 * (distances(i+1)^2 + distances(i)^2);
            C(i,i+1) = -4 * noise_std^2 * distances(i+1)^2;
        else
            C(i,i-1) = -4 * noise_std^2 * distances(i)^2;
            C(i,i) = 4 * noise_std^2 * (distances(i+1)^2 + distances(i)^2);
        end
    end
end