tic; % For timing analysis
% This time, we call pca_new  to get principle components
pca_new(200);
testDATA = orldata_test; % Get test images from orldata
load('pcaEigVecs.mat')
load('DATA.mat')
load('psi.mat')
% Case 1: Test using trained image

% Use one image from the training data set 
orlImgTrain = DATA(:, 150);
orlImgTrain1 = orlImgTrain - psi;
orlImgTrainEst = psi;
% Reconstruct the above image using 200 PCs by adding the projections of
% the zero mean images onto the eigenvectors
for i=1:200,
	orlImgTrainEst = orlImgTrainEst + (orlImgTrain1' * pcaEigVecs(:,i)) * pcaEigVecs(:,i);
end
trainMSE = (orlImgTrain - orlImgTrainEst)'*(orlImgTrain - orlImgTrainEst)/size(DATA,1)

% Case 2: Test using a test image from orl data base
orlImgTest = testDATA(:,150);
orlImgTest1 = orlImgTest - psi;
orlImgTestEst = psi;
for i=1:200,
	orlImgTestEst = orlImgTestEst + (orlImgTest1' * pcaEigVecs(:,i)) * pcaEigVecs(:,i);
end
testMSE = (orlImgTest - orlImgTestEst)'*(orlImgTest - orlImgTestEst)/size(DATA,1)


% Case 3: Test using my face image 
% Read in my image
myImg = imread('ashwin.jpg');
myImg = imgToVec(double(myImg));
myImg1 = myImg - psi;
myImgEst = psi;
for i=1:200,
	myImgEst = myImgEst + (myImg1' * pcaEigVecs(:,i)) * pcaEigVecs(:,i);
end
myImgMSE = (myImgEst - myImg)'*(myImgEst - myImg)/size(DATA,1)

% Generate plots to show original and reconstructed images
figure(1);
subplot(1,2,1), imshow(vecToImg(orlImgTrain),[0 255]);
subplot(1,2,2), imshow(vecToImg(orlImgTrainEst),[0 255]);

figure(2);
subplot(1,2,1), imshow(vecToImg(orlImgTest),[0 255]);
subplot(1,2,2), imshow(vecToImg(orlImgTestEst),[0 255]);

figure(3);
subplot(1,2,1), imshow(vecToImg(myImg),[0 255]);
subplot(1,2,2), imshow(vecToImg(myImgEst),[0 255]);
toc; % For timing analysis