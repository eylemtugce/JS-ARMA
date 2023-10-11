function SigmaXCell = originalJwssCovEstimator(data)
%% covestimator
% copied from experiments/syntheticdata/number_of_realizations/gpvar_estmt.m
% Covariance matrix estimator handling the missing data
%% Input
% data: Signal array
% Missing values are labeled as NaN. (NxTxn_real array)
%% Output
% SigmaX: covariance matrix.
[N, T, R] = size(data);
samplesT = data;
samplesT = reshape(samplesT,[N,T*R]);
meanVec = zeros(N,1);
for i = 1:N
    meanVec(i,1) = mean(samplesT(i,:),'omitnan');
end

%% Code
data(isnan(data)) = 0;
SigmaXCell = cell(T,1);
for tau = 0:(T-1)
    samplesT = data;
    samplesTpTau = circshift(samplesT,tau,2);
    samplesTpTau = reshape(samplesTpTau,[N,T*R]) - meanVec;
    samplesT = reshape(samplesT,[N,T*R]) - meanVec;
    covMat = samplesT*samplesTpTau'/(T*R - 1);

    SigmaXCell{tau+1} = covMat;
end
end