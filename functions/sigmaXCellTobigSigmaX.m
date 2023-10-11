function bigSigmaX = sigmaXCellTobigSigmaX(N, T, SigmaXCell)
n = N*T;
bigSigmaX = zeros(n,n);
for i = 0:(T-1)
    for j = 0:(T-1)
        idxRow = (i*N + 1):((i+1)*N);
        idxCol = (j*N + 1):((j+1)*N);
        tau = abs(j-i);
        bigSigmaX(idxRow,idxCol) = SigmaXCell{tau + 1};
    end
end
end