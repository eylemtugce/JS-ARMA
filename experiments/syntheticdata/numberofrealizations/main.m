
clear
clc
close all
%% PARAMETRIC FILTER ESTIMATION
addpath(genpath('../../../functions'))
% run('../../../tools/cvx/cvx_startup.m')

expName = 'numOfRealizations';

%% 20 dB
rng(pi);
param = config([expName '_20dB_snr']);
if ~exist(param.outputFolder,'dir')
  mkdir(param.outputFolder)
end
if ~exist(param.logFolder,'dir')
  mkdir(param.logFolder)
end
diary([param.logFolder '/log.txt'])
rng(pi)
disp(['Starting running experiment: '  datestr(datetime('now'))])
runExperiment(param);
disp(['End of experiment: '  datestr(datetime('now'))])
diary off

