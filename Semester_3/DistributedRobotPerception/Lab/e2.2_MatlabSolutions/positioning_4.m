
% 2D Localization with 3 anchors and multiple anchors

% Clear workspace and command window
clear;
clc;

% Define the positions of the anchors (x, y)
anchors = [0, 0; 10, 0; 5, 8.66]; % Example positions for 3 anchors

% Define the true position of the target (not know, the position that 
% we want to estimate) 
master_true_position = [4, 2];


% Add more anchors for multiple anchor localization
anchors = [anchors; 2, 7; 8, 3]; % Adding more anchors
distances = sqrt(sum((anchors - master_true_position).^2, 2));

% Estimate position using multiple anchors
[H2, b2] = trilateration(anchors, distances);
disp('Display H:');
disp(H2);

% Moore-Penrose pseudoinverse
pinv_H2 = (H2' * H2)^-1 * H2';

estimated_position_multi = pinv_H2 * b2;
disp('Estimated position with multiple anchors:');
disp(estimated_position_multi);

% Plotting the results
figure;
hold on;
plot(anchors(:,1), anchors(:,2), 'ro', 'MarkerSize', 10, 'DisplayName', 'Anchors');
plot(master_true_position(1), master_true_position(2), 'bx', 'MarkerSize', 10, 'DisplayName', 'True Position');
plot(estimated_position_multi(1), estimated_position_multi(2), 'ms', 'MarkerSize', 10, 'DisplayName', 'Estimated Position (Multiple Anchors)');
legend;
xlabel('X Position');
ylabel('Y Position');
title('2D Localization with Multiple Anchors');
grid on;
hold off;


% trilateration function 
function [H, b] = trilateration(anchors, distances)
    % Number of anchors
    n = size(anchors, 1);
    
    % Initialize matrices
    H = zeros(n-1, 2);
    b = zeros(n-1, 1);
    
    % Iterate over all anchors
    for i = 1:n-1
        % Fill the matrices
        H(i, :) = 2*[anchors(i+1, 1) - anchors(i, 1), anchors(i+1, 2) - anchors(i, 2)];
        b(i) = - distances(i+1)^2  + distances(i)^2 + anchors(i+1, 1)^2 - anchors(i, 1)^2 + anchors(i+1, 2)^2 - anchors(i, 2)^2;
    end
end