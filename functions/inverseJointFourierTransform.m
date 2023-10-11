function X = inverseJointFourierTransform(XHat,UG,nPoint)

if nargin < 3 
    nPoint = size(XHat,2);
end

normalize = 1/sqrt(nPoint);
X = ifft(inverseGraphFourierTransform(XHat,UG),nPoint,2)/normalize;

end
