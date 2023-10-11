function x = createTimeVertexProcess(jointFilterTheoric,eigenVectors,N,T,numTrials)
% This function works correctly, checked with toolbox results, OK!
x = zeros(N,T,numTrials);
eps = 1e-10;
for jj = 1:numTrials
  W = randn(N,T);
  WHat = jointFourierTransform(W, eigenVectors);
  XFiltered = inverseJointFourierTransform((jointFilterTheoric).*WHat,eigenVectors);
  x(:,:,jj) = XFiltered;
end

if max(abs(imag(x))) < eps
  x = real(x);
  disp('Real valued time vertex process created.');
else
  disp('Complex valued time vertex process created.');
end
end