function laplacianMat = calculateLaplacianMatrix(weightMat,laplacianType)
if nargin == 1 
    laplacianType = 'normalized';
end

d = sum(weightMat,2);
%disp(strcat('Laplacian Type : ' , laplacianType));
if strcmpi(laplacianType,'unnormalized')
    laplacianMat = diag(d)-weightMat;
else
    if strcmpi(laplacianType,'normalized')
         Dn = diag(d.^(-0.5));
        laplacianMat = speye(length(d)) -  Dn * weightMat * Dn;
    else
        laplacianMat = [];
        disp('Laplacian Type : ' +  laplacianType);
    end   
end

end