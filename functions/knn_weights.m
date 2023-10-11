function newW=knn_weights(K,N,t,dist)
%KNN_WEIGHTS Summary of this function goes here
%   Detailed explanation goes here
i=1;
W=exp(-(dist.^2)/t);
W=double(W~=1).*W;

cond=(t==inf);
cond=double(cond);
newW=zeros(N);

if cond
    dist(dist==0)=inf;
    [~,midx]=mink(dist,K+1);

else
    [~,midx]=maxk(W,K);

end
while i<=N
    temp=midx(:,i);
    newW(i,temp)=W(temp,i)*(1-cond)+cond;
    newW(temp,i)=W(temp,i)*(1-cond)+cond;

    i=i+1;
end


end

