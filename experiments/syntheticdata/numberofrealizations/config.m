function param = config(expName)
%% PARAMETRIC FILTER ESTIMATION CONFIGURATIONS
%% INPUTS
outputRootFolder = 'output';
logFolder = 'log';
if nargin < 1
    expName = 'ParFiltEstSynthetic';
end

param.numOfExperiments = 20;
param.paramVect = [15 25 50 100 500 1000 5000 10000];   % number of realizations


param.laplacianType = 'Normalized';

%%
param.timeVertexProcess.noiseStd = 0.073;
param.timeVertexProcess.T = 100;

param.timeVertexProcess.bQM = [0.5; 0.5];
param.timeVertexProcess.aPK = [ 1 0; -0.5 0.5 ];
%%
dateString = datestr(now,'yyyymmdd_HHMMSS');
param.expName = expName;
param.outputFolder = fullfile(outputRootFolder,expName,dateString);
param.outputFilename = 'output.mat';
param.parameterSearchExp = 'paramSearch.mat';
param.logFolder =  fullfile(param.outputFolder,logFolder);
%%  filter estimation parameter

param.filterEst.muA = 1e-5;
param.filterEst.muB = 1e-5;
param.filterEst.Q = size(param.timeVertexProcess.bQM,1)-1;
param.filterEst.M = size(param.timeVertexProcess.bQM,2)-1;
param.filterEst.P = size(param.timeVertexProcess.aPK ,1)-1;
param.filterEst.K = size(param.timeVertexProcess.aPK ,2)-1;
param.filterEst.sigmaX = inf;
param.filterEst.sigmaY = inf;
end
