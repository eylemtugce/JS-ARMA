function [rank1A, rank1B, aPK, bQM]= rankOneConverterOfAandB(A, B, P, K, Q, M)
if issparse(A)
    A = full(A);
end
if issparse(B)
    B = full(B);
end
% Original A

%         disp('A')
%         disp(A);
%         disp('Singular values of A')
%         disp(svd(A));
% Original B

%         disp('B')
%         disp(B);
%         disp('Singular values of B')
%         disp(svd(B));
%% Make them rank-1
[eigVec, value] = eig(A);
[value, idx] = sort(diag(value),'descend');
rank1A = value(1)*eigVec(:,idx(1))*eigVec(:,idx(1))';
a = sqrt(value(1))*eigVec(:,idx(1));
if a(1) < 0
    a = -1*a;
end
aPK = reshape(a,[K + 1, P + 1]).';
%disp('Rank-1 approximation of A:')
%disp(A)
%disp('aPK')
%disp(aPK )
[eigVec, value] = eig(B);
[value, idx] = sort(diag(value),'descend');
rank1B = value(1)*eigVec(:,idx(1))*eigVec(:,idx(1))';
b = sqrt(value(1))*eigVec(:,idx(1));
if b(1) < 0
    b = -1*b;
end
bQM = reshape(b,[ M + 1,Q + 1]).';
%disp('Rank-1 approximation of B:')
%disp(B)
%disp('bQM')
%disp(bQM)
end