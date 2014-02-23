function pca_orl(subDim)
%
% PROTOTYPE
% function pca_new (subDim)
% 
% Does not use Turk-Pentland tricks
% USAGE EXAMPLE(S)
% pca_new (200);
%  
% INPUTS:
% subDim        - Numer of dimensions to be retained (the desired subspace
%                 dimensionality). if this argument is ommited, maximum
%                 non-zero dimensions will be retained, i.e. (number of training images) - 1
%
% OUTPUTS:
% Function will generate and save to the disk the following outputs:
% DATA          - matrix where each column is one image reshaped into a vector
%               - this matrix size is (number of pixels) x (number of images), uint8
% imSpace       - same as DATA but only images in the training set
% psi           - mean face (of training images)
% zeroMeanSpace - mean face subtracted from each row in imSpace
% pcaEigVals    - eigenvalues
% w             - lower dimensional PCA subspace
% pcaProj       - all images projected onto a subDim-dimensional space


global imloadfunc;

imloadfunc =  'pgma_read'; 

disp(' ')

DATA = orldata_train;
save DATA DATA;

[imSize, numImages] = size(DATA);

% Creating training images space
dim = numImages;
imSpace = zeros (imSize, dim);

for i = 1 : dim
    imSpace(:, i) = DATA(:, i);
end;
save imSpace imSpace;
clear DATA;

% Calculating mean face from training images
fprintf('Zero mean\n')
psi = mean(double(imSpace'))';
save psi psi;

% Zero mean
zeroMeanSpace = zeros(size(imSpace));
for i = 1 : dim
    zeroMeanSpace(:, i) = double(imSpace(:, i)) - psi;
end;
save zeroMeanSpace zeroMeanSpace;
clear imSpace;

% PCA
fprintf('PCA\n')
% We will find the original eigenvectors, by not using Turk-Pentland Trick
% and thus finding the eigenvectors of a 10304x10304 matrix in this case.
L = zeroMeanSpace * zeroMeanSpace';
[eigVecs, eigVals] = eig(L);

diagonal = diag(eigVals);
[diagonal, index] = sort(diagonal);
index = flipud(index);
 
pcaEigVals = zeros(size(eigVals));
for i = 1 : size(eigVals, 1)
    pcaEigVals(i, i) = eigVals(index(i), index(i));
    pcaEigVecs(:, i) = eigVecs(:, index(i));
end;

pcaEigVals = diag(pcaEigVals);
pcaEigVals = pcaEigVals / (dim-1);
pcaEigVals = pcaEigVals(1 : subDim);        % Retaining only the largest subDim ones

save pcaEigVals pcaEigVals;

% Normalisation to unit length
fprintf('Normalising\n')
for i = 1 : dim
    pcaEigVecs(:, i) = pcaEigVecs(:, i) / norm(pcaEigVecs(:, i));
end;
save pcaEigVecs pcaEigVecs;

% Dimensionality reduction. 
fprintf('Creating lower dimensional subspace\n')
w = pcaEigVecs(:, 1:subDim);
save w w;
clear w;

% Subtract mean face from all images
load DATA;
load psi;
zeroMeanDATA = zeros(size(DATA));
for i = 1 : size(DATA, 2)
    zeroMeanDATA(:, i) = double(DATA(:, i)) - psi;
end;
clear psi;
clear DATA;

% Project all images onto a new lower dimensional subspace (w)
fprintf('Projecting all images onto a new lower dimensional subspace\n')
load w;
pcaProj = w' * zeroMeanDATA;
clear w;
clear zeroMeanDATA;
save pcaProj pcaProj;
