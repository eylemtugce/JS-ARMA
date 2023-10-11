function H = getJointFilterFromCoeff(timeVertexProcessStruct)
N = timeVertexProcessStruct.N;
T = timeVertexProcessStruct.T;
% Rows represent lag in the graph, columns represent lag in the time.
% However, change in the coefficient vector is graph privileged. Hence,
% take transpose of the coefficient vector then vectorize it.
bQM_vect = timeVertexProcessStruct.bQM.';
aPK_vect = timeVertexProcessStruct.aPK.';
bQM_vect = bQM_vect(:);
aPK_vect = aPK_vect(:);
[U, V] = calcFilterEstCoeff(timeVertexProcessStruct);
H = reshape(sum(bQM_vect  .* U, 1) ./ sum(aPK_vect  .* V, 1),[T,N]).';
end