function output = jointFilterEstimationInSyntheticData(origFilter,lambda,omega,...
    N,T,graphEigenVectors,param)

output = struct;
x = createTimeVertexProcess(origFilter.jointFilter,graphEigenVectors,N,T,...
    param.filterEst.numOfRealizations);
noiseTerm = param.timeVertexProcess.noiseStd*randn(N,T,param.filterEst.numOfRealizations);
signalPow = (norm(x(:),'fro')).^2;
noisePow = (norm(noiseTerm(:),'fro').^2);
output.snr = 10*log10(signalPow/noisePow);
UJ = kron(conj(dftmtx(T)),graphEigenVectors)/sqrt(T);
UJHermitian = UJ';
x = x + noiseTerm;
%% natheneal psd estimator
disp('---- PSD Estimation Using Sample Covariance (JWSS) ----');
% samplecovariance, samplejpsdestimator, jwsscovariance
sigmaXCell = originalJwssCovEstimator(x);
output.jwssCov.psd = estimateJointPSD(N, T,jwssCovCoherentWithGraphMaker(sigmaXCell,graphEigenVectors, N, T), UJ, UJHermitian);
output.jwssCov.err = calcError(origFilter,output.jwssCov);
disp(output.jwssCov.err);
%% parametric joint filter estimator with psd estimation from jwss cov
disp('---- PSD Estimation Using JWSS Covariance (A Parametric ARMA Model Assumption - Convex) ----');
output.parJointFiltWJWSSCovPsd = parametricPsdEstimation(output.jwssCov.psd,lambda,omega,param.filterEst);
output.parJointFiltWJWSSCovPsd.err = calcError(origFilter,output.parJointFiltWJWSSCovPsd);
disp(output.parJointFiltWJWSSCovPsd.aPK);
disp(output.parJointFiltWJWSSCovPsd.bQM);
disp(output.parJointFiltWJWSSCovPsd.err);
end