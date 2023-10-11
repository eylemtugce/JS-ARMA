function [exponent_matrixU, exponent_matrixV] = exponentMatrixCreator(currentParamStruct)
P = currentParamStruct.P;
K = currentParamStruct.K;
Q = currentParamStruct.Q;
M = currentParamStruct.M;
T = currentParamStruct.T;
exponent_matrixU = exp(-1j*(currentParamStruct.omega .* repmat(reshape(repmat((0:Q),M+1,1),[],1),1,T))); % U. 
% Repeat as M+1 because lambda powers goes 0 to M.
exponent_matrixV = exp(-1j*(currentParamStruct.omega .* repmat(reshape(repmat((0:P),K+1,1),[],1),1,T))); % V.
% Repeat as K+1 because lambda powers goes 0 to K.
end