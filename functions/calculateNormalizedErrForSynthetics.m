function err = calculateNormalizedErrForSynthetics(gt,est)
assert(size(gt,1) == size(est,1),'Number of rows of estimated and gt should be same');
assert(size(gt,2) == size(est,2),'Number of columns of estimated and gt should be same');
err = norm((gt - est), 'fro')./norm(gt, 'fro');
end