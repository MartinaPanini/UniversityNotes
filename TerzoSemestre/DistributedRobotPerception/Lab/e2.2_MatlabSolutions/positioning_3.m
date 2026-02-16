
% 2D Localization with 3 anchors and multiple anchors

% Clear workspace and command window
clear;
clc;

% Define the positions of the anchors (x, y)
anchors = [0, 0; 10, 0; 5, 8.66]; % Example positions for 3 anchors


% Define the true position of the target (not know, the position that 
% we want to estimate) 
master_true_position = [4, 2];



% Calculate distances from the target to each anchor
distances = sqrt(sum((anchors - master_true_position).^2, 2));

% Display the distances
disp('Distances to each anchor:');
disp(distances);



% Estimate position using 3 anchors
[H,b] = trilateration(anchors, distances);

% Check if the matrix S is invertible: QUESTO CHECK E' SBAGLIATO
if det(H) == 0
    error('Matrix H is not full rank and cannot be inverted');
end

estimated_position_3 = H^-1 * b;
disp('Estimated position with 3 anchors:');
disp(estimated_position_3);



% Plotting the results
figure;
hold on;
plot(anchors(:,1), anchors(:,2), 'ro', 'MarkerSize', 10, 'DisplayName', 'Anchors');
plot(master_true_position(1), master_true_position(2), 'bx', 'MarkerSize', 10, 'DisplayName', 'True Position');
plot(estimated_position_3(1), estimated_position_3(2), 'g+', 'MarkerSize', 10, 'DisplayName', 'Estimated Position (3 Anchors)');
legend;
xlabel('X Position');
ylabel('Y Position');
title('2D Localization with 3 Anchors');
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