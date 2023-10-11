function XHat = jointFourierTransform(X,UG,nPoint)
if nargin < 3 
    nPoint = size(X,2);
end

normalize = 1/sqrt(nPoint);
XHat = fft(graphFourierTransform(X,UG),nPoint,2)*normalize;
end
