function bigSigmaX = jwssCovCoherentWithGraphMaker(SigmaXCell, UG, N, T)
UG_transpose = UG';
for tau = 0 : T-1
   SigmaXCell{tau + 1} = UG*(real(diag(UG_transpose*SigmaXCell{tau + 1}*UG)).*UG_transpose);
end
%%
bigSigmaX = sigmaXCellTobigSigmaX(N, T, SigmaXCell);
end