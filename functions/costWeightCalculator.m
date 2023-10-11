function costWeight = costWeightCalculator(sigmaX, sigmaY, lambda, omega)
N = length(lambda);
T = length(omega);
costWeight = zeros(N,T);
for tau=1:(T/2+1)
    for n=1:N
        costWeight(n,tau)= exp(-((omega(tau)^2)/sigmaY+(lambda(n)^2)/sigmaX));
    end
end
for tau = 2:(T/2)
    costWeight(:,end - tau + 2) = costWeight(:,tau);
end

end

