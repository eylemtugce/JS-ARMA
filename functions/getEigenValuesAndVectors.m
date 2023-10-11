function [eigenVectors,lambda] = getEigenValuesAndVectors(laplacianMat)
[eigenVectors,eigenValues] = eig(laplacianMat);
lambda = diag(eigenValues);
[lambda,idx] = sort(lambda);
eigenVectors = eigenVectors(:,idx);
end