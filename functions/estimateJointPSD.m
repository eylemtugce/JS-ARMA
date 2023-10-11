function psd = estimateJointPSD(N, T, bigSigmaX, UJ, UJHermitian)
specCovMat = UJHermitian * bigSigmaX * UJ;
psd = real(diag(specCovMat));
psd = reshape(psd,[N,T]);
end