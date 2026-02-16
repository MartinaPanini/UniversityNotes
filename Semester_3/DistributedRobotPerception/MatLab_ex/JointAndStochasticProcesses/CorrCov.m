clear all;
close all;
clc;

% Number of samples
n = 1e6;

% First pdf: Gaussian
mu = 10;
sigma = 0.5;
x = randn(1,n)*sigma + mu;

% Second pdf: Uniform
a = -2;
b = 5;
y = rand(1,n)*(b-a) + a;

%% Comparison between theory and empirical evidence

disp(['Mean of x: ', num2str(mu), ' - Type A: ', num2str(sum(x)/n)]);
disp(['Mean of y: ', num2str((b+a)/2), ' - Type A: ', num2str(sum(y)/n)]);

gx = sum((x - sum(x)/n).^2)/n;
gy = sum((y - sum(y)/n).^2)/n;

disp(['Variance of x: ', num2str(sigma^2), ' - Type A: ', num2str(gx)]);
disp(['Variance of y: ', num2str((b-a)^2/12), ' - Type A: ', num2str(gy)]);

% Covariance
gxy = sum((x - sum(x)/n).*(y - sum(y)/n))/n;
C = cov(x,y);

disp(['Covariance of x and y: ', num2str(C(1,2)), ' - Type A: ', num2str(gxy)]);

% Correlation
gxy = sum(x.*y)/n;

disp(['Correlation of x and y: ', num2str(C(1,2) + mu*(b+a)/2), ' - Type A: ', num2str(gxy)]);


%% Plots

FigID = 0;

% Gaussian
FigID = FigID + 1;
figure(FigID), clf, hold on;
nBins = 30;
HX = histogram(x, nBins);
title('Normal Pdf')

FigID = FigID + 1;
figure(FigID), clf, hold on;
DeltaX = HX.BinEdges(2) - HX.BinEdges(1);
RelFreqX = HX.Values/sum(HX.Values);
TypeAPdfX = RelFreqX/DeltaX;

RangeTheoX = HX.BinEdges(1):DeltaX:HX.BinEdges(end);
TheoPdfX = 1/(sqrt(2*pi)*sigma)*exp(-((RangeTheoX - mu).^2)/(2*sigma^2));
stem(HX.BinEdges(1:end-1)+DeltaX/2, TypeAPdfX, 'b');
plot(RangeTheoX, TheoPdfX, 'r--');
legend('Type A', 'Theoretical');
title('Normal Pdf')


% Uniform
FigID = FigID + 1;
figure(FigID), clf, hold on;
HY = histogram(y, nBins);
title('Uniform Pdf')

FigID = FigID + 1;
figure(FigID), clf, hold on;
DeltaY = HY.BinEdges(2) - HY.BinEdges(1);
RelFreqY = HY.Values/sum(HY.Values);
TypeAPdfY = RelFreqY/DeltaY;

RangeTheoY = HY.BinEdges(1):DeltaY:HY.BinEdges(end);
TheoPdfY = 1/(RangeTheoY(end) - RangeTheoY(1))*ones(1, length(RangeTheoY));
stem(HY.BinEdges(1:end-1)+DeltaY/2, TypeAPdfY, 'b');
plot(RangeTheoY, TheoPdfY, 'r--');
legend('Type A', 'Theoretical');
title('Uniform Pdf')

sum(DeltaX*TheoPdfX)
sum(DeltaY*TheoPdfY)


% Joint PDF
FigID = FigID + 1;
figure(FigID), clf, hold on;
X = RangeTheoX;
Y = RangeTheoY;
[X,Y] = meshgrid(X,Y);
PdfXY = (1/(sqrt(2*pi)*sigma)*exp(-((X - mu).^2)/(2*sigma^2))) .* (1/(RangeTheoY(end) - RangeTheoY(1))*ones(size(Y)));
mesh(X, Y, PdfXY);





