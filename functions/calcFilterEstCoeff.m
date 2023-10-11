function [U, V, nu, nv] = calcFilterEstCoeff(currentParamStruct)
Q = currentParamStruct.Q;
M = currentParamStruct.M;
P = currentParamStruct.P;
K = currentParamStruct.K;
N = currentParamStruct.N;
T = currentParamStruct.T;

%% Faster of the naiv approach
nu = (M+1)*(Q+1);
nv = (P+1)*(K+1);
U = zeros(nu, T, N);
V = zeros(nv, T, N);
[exponent_matrixU, exponent_matrixV] = exponentMatrixCreator(currentParamStruct);
powerToTake = max([M,K]);
lambdaAllPowers = bsxfun(@power,currentParamStruct.lambda,0:powerToTake).'; 

for index = 1 : N
U(:,:,index) = bsxfun(@times,exponent_matrixU,repmat(lambdaAllPowers(1:M+1,index),Q+1,1)); % Construct the (U_n,1:T) matrix. Derived by hand in the pdf.
V(:,:,index) = bsxfun(@times,exponent_matrixV,repmat(lambdaAllPowers(1:K+1,index),P+1,1));
end

%% True naiv approach
% nu = (M+1)*(Q+1);
% nv = (P+1)*(K+1);
% U2 = zeros(nu, T, N);
% V2 = zeros(nv, T, N);
% for indexn = 1 : N
%     for indextau = 1 : T
%         indexnu = 1;
%         indexnv = 1;
%         for indexq = 0 : Q
%             for indexm = 0 : M
%                 U2(indexnu, indextau,indexn ) = currentParamStruct.lambda(indexn)^indexm * exp(-1j*currentParamStruct.omega(indextau)*indexq);
%                 indexnu = indexnu + 1;
%             end
%         end
%          for indexp = 0 : P
%             for indexk = 0 : K
%                 V2(indexnv, indextau, indexn) = currentParamStruct.lambda(indexn)^indexk * exp(-1j*currentParamStruct.omega(indextau)*indexp);
%                 indexnv = indexnv + 1;
%             end
%          end
%     end
% end


end