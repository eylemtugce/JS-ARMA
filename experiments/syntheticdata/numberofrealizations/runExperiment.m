function runExperiment(param)
if ~exist(param.outputFolder,'dir')
    mkdir(param.outputFolder)
end

syntGraph = create_grid(0.9, 3, 0.6, 10, 5, [0,5],[0,5],true);
weightMat = syntGraph.W;
laplacianMat = calculateLaplacianMatrix(weightMat,param.laplacianType);
[graphEigenVectors,lambda] = getEigenValuesAndVectors(laplacianMat);
param.timeVertexProcess.lambda = lambda;
param.timeVertexProcess.P = param.filterEst.P ;
param.timeVertexProcess.K = param.filterEst.K ;
param.timeVertexProcess.Q = param.filterEst.Q ;
param.timeVertexProcess.M = param.filterEst.M ;

N = size(graphEigenVectors,1);
param.timeVertexProcess.N = N;
T = param.timeVertexProcess.T;
param.filterEst.costWeight = zeros(N,T);
sigmaX = param.filterEst.sigmaX;
sigmaY = param.filterEst.sigmaY;
omega = 2*pi*(0:(T-1))/T;
param.timeVertexProcess.omega = omega;
disp(['sigma tau : ' num2str(sigmaY) ' sigma n : ' num2str(sigmaX)]);
for tau=1:(length(omega)/2+1)
    for n=1:length(lambda)
        param.filterEst.costWeight(n,tau)= exp(-((omega(tau)^2)/sigmaY+(lambda(n)^2)/sigmaX));
    end
end
for tau = 2:(length(omega)/2)
    param.filterEst.costWeight(:,end - tau + 2) = param.filterEst.costWeight(:,tau);
end
omega = 2*pi*(0:T-1)/T;
%% original filter
origFilter.bQM = zeros((param.filterEst.Q+1),(param.filterEst.M+1));
origFilter.bQM(1:size(param.timeVertexProcess.bQM,1),...
    1:size(param.timeVertexProcess.bQM,2)) = param.timeVertexProcess.bQM;
origFilter.aPK = zeros((param.filterEst.P+1),(param.filterEst.K+1));
origFilter.aPK(1:size(param.timeVertexProcess.aPK,1),...
    1:size(param.timeVertexProcess.aPK,2)) = param.timeVertexProcess.aPK;
origFilter.jointFilter = getJointFilterFromCoeff(param.timeVertexProcess);
origFilter.psd = (abs(origFilter.jointFilter)).^2;


figure;
imagesc(origFilter.psd);
saveCurrentFigure(fullfile(param.outputFolder,'OriginalPSD'));
output = cell(param.numOfExperiments, length(param.paramVect));
for iExp = 1:param.numOfExperiments
    for iParam = 1:length(param.paramVect)
        disp(['Exp no : ' num2str(iExp) '-' num2str(param.numOfExperiments)]);
        disp(['Param no : ' num2str(iParam) '-' num2str(length(param.paramVect))]);
        % frequency domain
        param.filterEst.numOfRealizations = param.paramVect(iParam);
        disp(['Number of Realizations to Estimate Filter : ' num2str(param.filterEst.numOfRealizations)]);
        output{iExp,iParam} = jointFilterEstimationInSyntheticData(origFilter,lambda,omega,...
            N,T,graphEigenVectors,param);
    end
	%% save output
	save(fullfile(param.outputFolder,param.outputFilename),'output');
end
plotOutput(output, param.outputFolder);
end