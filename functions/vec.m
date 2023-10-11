function [Xv] = vec(X)
[a,b] = size(X);

Xv = reshape(X,a*b,1);