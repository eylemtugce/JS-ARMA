function estFilter = parametricPsdEstimation(psd,lambda,omega,...
    filterEstParam)
costWeightStruct = struct;
costWeightStruct.costWeightBoolean = false;
[N, T] = size(psd);

currentParamStruct = filterEstParam;

currentParamStruct.omega = omega;
currentParamStruct.N = N;
currentParamStruct.T = T;
%currentParamStruct.psd = estimateJointPSD(N, T, signalInputStruct.bigSigmaX, metadata.UJ, metadata.UJHermitian);
%currentParamStruct.psdNew = (reshape(psd.',[N*T,1]));
currentParamStruct.h = psd;
currentParamStruct.lambda = lambda; 

P = currentParamStruct.P;
K = currentParamStruct.K;
nv = (P+1) * (K+1);
Q = currentParamStruct.Q;
M = currentParamStruct.M;
nu = (Q+1) * (M+1);

[currentParamStruct.UThreeDimensional, currentParamStruct.VThreeDimensional] = calcFilterEstCoeff(currentParamStruct);

%%  Solve The optimization problem
%costWeightNew = vec(costWeights.');
%currentParamStruct.costWeightNew = costWeightNew;
if costWeightStruct.costWeightBoolean
currentParamStruct.costWeights = costWeightCalculator(costWeightStruct.sigmaX,costWeightStruct.sigmaY,lambda,omega);
aleph = construct_quad_UV_costWeighty(currentParamStruct);
else
aleph = construct_quad_UV(currentParamStruct);
end

cvx_begin quiet
variable A((P+1)*(K+1),(P+1)*(K+1)) 
variable B((Q+1)*(M+1),(Q+1)*(M+1)) 
minimize(costFuncARMA(A, B, aleph, currentParamStruct.muA, currentParamStruct.muB))
subject to
A == semidefinite((P+1)*(K+1)); %#ok<*EQEFF>
B == semidefinite((Q+1)*(M+1));
A(1,1) == 1;
A(2:K+1,:) == 0;
A(K+2:end,2:K+1) == 0;
cvx_end

% disp(cvx_status)
%%
[rank1A, rank1B, estFilter.aPK, estFilter.bQM]= rankOneConverterOfAandB(A, B, P, K, Q, M);
estFilter.psd = real(reshape(sum(conj(currentParamStruct.UThreeDimensional) .* (pagemtimes(rank1B,currentParamStruct.UThreeDimensional)), 1) ./ ...
    sum(conj(currentParamStruct.VThreeDimensional) .* (pagemtimes(rank1A,currentParamStruct.VThreeDimensional)), 1),[T,N]).');
end