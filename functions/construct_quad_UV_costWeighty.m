function aleph = construct_quad_UV_costWeighty(currentParamStruct)
%CONSTRUCT_QUAD_UV Summary of this function goes here
%   Detailed explanation goes here
[~,T,N] = size(currentParamStruct.UThreeDimensional);
% [~,~,~] = size(V_nt);

% U_vec_nt = zeros(U_size^2,1);
% V_vec_nt = zeros(V_size^2,1);
conjugated_h = conj(currentParamStruct.h);
sqrtCostWeights= sqrt(currentParamStruct.costWeights);
aleph = 0;
for n = 1 : N
    for t = 1 : T

        temp_U = currentParamStruct.UThreeDimensional(:,t,n);
        temp_V = currentParamStruct.VThreeDimensional(:,t,n);

        temp_U2 = temp_U * temp_U';
        temp_V2 = temp_V * temp_V';

        D = [temp_U2(:) * sqrtCostWeights(n,t); - temp_V2(:) * sqrtCostWeights(n,t) * conjugated_h(n,t)];

       aleph = aleph + real(D*D');

    end
end

end

