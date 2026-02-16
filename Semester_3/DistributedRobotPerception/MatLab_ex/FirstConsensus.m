clear all;
clc;

%% Problem formulation

T = rand(1)*5 + 20;

% Number of nodes
n = 6;

% Number of messages
n_msg = 20;

% Sensing uncertainties
Unc.mu = zeros(n,1);
Unc.std = rand(n,1);

% Collecting measurements
x0 = zeros(n,1);
y0 = zeros(n,1);
z0 = zeros(n,1);
for i=1:n
    x0(i) = T + randn(1)*Unc.std(i) + Unc.mu(i);
    y0(i) = x0(i)/Unc.std(i)^2;
    z0(i) = 1/Unc.std(i)^2;
end

%% Analysis

% Adjacency
A = rand(n,n) >= 0.5; 
A = A - diag(diag(A)); 
A = ceil((A + A')/2);
% Degree vector
D = A*ones(n,1);

% Define the matrix 'Q'
x = 0.3;
y = 0.8;
Q1 = [x + y - 1, 1 - x, 1 - y; 1 - x, x, 0; 1 - y, 0, y];

Q2 = [1/3, 1/3, 1/3; 1/2, 1/2, 0; 1/2, 0, 1/2];

% Storing the time evolution of the node values
% xStore = zeros(n,n_msg+1);
% xStore(:,1) = x0;
% for i=1:n_msg
%     xStore(:,i+1) = Q1*xStore(:,i);
% end


%% Implementation

xStore = zeros(n,n_msg+1);
xStore(:,1) = x0;
xStoreStep = zeros(n,1);

yStore = zeros(n,n_msg+1);
yStore(:,1) = y0;
yStoreStep = zeros(n,1);

zStore = zeros(n,n_msg+1);
zStore(:,1) = z0;
zStoreStep = zeros(n,1);

for i=1:n_msg
    for j=1:n
        % Available information of node 'j'
        xj = xStore(j,i);
        yj = yStore(j,i);
        zj = zStore(j,i);

        % Collecting data from neighbours
        xjCollectedData = zeros(1,n);
        yjCollectedData = zeros(1,n);
        zjCollectedData = zeros(1,n);
        qjk = zeros(1,n);
        for k=1:n
            if not(k == j)
                if A(j,k) == 1
                    xjCollectedData(k) = xStore(k,i);
                    yjCollectedData(k) = yStore(k,i);
                    zjCollectedData(k) = zStore(k,i);
                    qjk(k) = 1/(1 + max(D(j), D(k)));
                end
            end
        end

        % Computing the Consensus step
        for k=1:n
            xj = xj + qjk(k)*(xjCollectedData(k) - xStore(j,i));
            yj = yj + qjk(k)*(yjCollectedData(k) - yStore(j,i));
            zj = zj + qjk(k)*(zjCollectedData(k) - zStore(j,i));
        end
        xStoreStep(j) = xj;
        yStoreStep(j) = yj;
        zStoreStep(j) = zj;
    end

    % Finally store
    xStore(:,i+1) = xStoreStep;
    yStore(:,i+1) = yStoreStep;
    zStore(:,i+1) = zStoreStep;
end


%% Plot

figure(1), clf, hold on;
LegS = {};
for i=1:n
    plot(0:n_msg, xStore(i,:));
    LegS{end+1} = ['x_{', num2str(i), '}'];
end
plot(0:n_msg, ones(1,n_msg + 1)*T, 'r--');
LegS{end+1} = 'Actual Temp';
plot(0:n_msg, ones(1,n_msg + 1)*mean(x0), 'k.-');
xlabel('n msgs'); ylabel('°C');
legend(LegS, 'Location', 'best');

figure(2), clf, hold on;
LegS = {};
for i=1:n
    plot(0:n_msg, yStore(i,:)./zStore(i,:));
    LegS{end+1} = ['x_{', num2str(i), '}'];
end
plot(0:n_msg, ones(1,n_msg + 1)*T, 'r--');
LegS{end+1} = 'Actual Temp';
plot(0:n_msg, ones(1,n_msg + 1)*mean(x0), 'k.-');
xlabel('n msgs'); ylabel('°C');
legend(LegS, 'Location', 'best');
