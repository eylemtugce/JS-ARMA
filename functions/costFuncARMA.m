function total_cost = costFuncARMA(A, B, aleph, muA, muB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
C = [B(:);A(:)];
total_cost = C'*aleph*C + muA*trace(A) + muB*trace(B);
end

