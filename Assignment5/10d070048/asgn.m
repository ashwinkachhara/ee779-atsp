% EE779 Assignment 5
% Ashwin Kachhara, 10d070048
% Note: To run this, you mush have FastICA toolbox already added to your
% MATLAB PATH
close all
% Loading the Scenario 1 data
load('mixedsig_set2.mat')

figure
subplot(2,1,1)
plot(mixedsig(1,:))
title('x1')
subplot(2,1,2)
plot(mixedsig(2,:))
title('x2')

% Scatter Plot
figure
scatter(mixedsig(1,:), mixedsig(2,:))
title('scatter plot x1-x2')

% Histograms (80 bins)
figure
subplot(2,1,1)
hist(mixedsig(1,:),80)
title('hist x1')
subplot(2,1,2)
hist(mixedsig(2,:),80)
title('hist x2')

% Applying FastICA, getting the mixture matrix and the original signals
[s1, A1, W1] = fastica(mixedsig);

figure
subplot(2,1,1)
plot(s1(1,:))
title('s1')
subplot(2,1,2)
plot(s1(2,:))
title('s2')

% Scatter plot
figure
scatter(s1(1,:), s1(2,:))
title('scatter s1-s2')

% Histograms
figure
subplot(2,1,1)
hist(s1(1,:),80)
title('hist s1')
subplot(2,1,2)
hist(s1(2,:),80)
title('hist s2')
A1

% Only whitening
[whitesig, WM, DWM] = fastica(mixedsig, 'only', 'white');
figure
scatter(whitesig(1,:),whitesig(2,:));
title('scatter whitesig')

% Only PCA. We get the eigenvectors and eigenvalues
[E, D] = fastica(mixedsig, 'only', 'pca');

% Projecting the current data onto the eigenvectors
pcaproj = mixedsig'*E;
pcaproj = pcaproj';

% Scatter plot of this new data
figure
scatter(pcaproj(1,:), pcaproj(2,:))
title('pca eigenvector projections of x1-x2')

% Loading data for scenario 2
w1 = wavread('mix1_set2.wav');
w2 = wavread('mix2_set2.wav');
w=[w1 w2]';

figure
subplot(2,1,1)
plot(w(1,:))
title('speech x1')
subplot(2,1,2)
plot(w(2,:))
title('speech x2')

% Scatter plots
figure
scatter(w(1,:), w(2,:))
title('speech scatter plot x1-x2')

% Histograms
figure
subplot(2,1,1)
hist(w(1,:),80)
title('speech hist x1')
subplot(2,1,2)
hist(w(2,:),80)
title('speech hist x2')

% Applying FastICA. the resultant speech signals have been saved in working
% directory as 's1speech.wav' and 's2speech.wav'
[s2, A2, W2] = fastica(w);

wavwrite(s2(1,:)/max(abs(s2(1,:))), 's1speech.wav')
wavwrite(s2(2,:)/max(abs(s2(2,:))), 's2speech.wav')

figure
subplot(2,1,1)
plot(s2(1,:))
title('speech s1')
subplot(2,1,2)
plot(s2(2,:))
title('speech s2')

% Scatter plot
figure
scatter(s2(1,:), s2(2,:))
title('speech scatter plot s1-s2')

% Histogram
figure
subplot(2,1,1)
hist(s2(1,:),80)
title('speech hist s1')
subplot(2,1,2)
hist(s2(2,:),80)
title('speech hist s2')


