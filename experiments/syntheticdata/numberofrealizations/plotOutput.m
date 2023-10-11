function plotOutput(outputMat, outputPath)
figureNames = {'aPKErr','bQMErr','jpsdErr'};
fontSize = 15;
lineWidth = 1.5;
paramVect = [15 25 50 100 500 1000 5000 10000];
paramName = 'Number of realizations (L)';
marker = ['*', 'x','>','<','d','s'];
legends_jpsd = {'JS-ARMA','JWSS'};
legends_ab = {'JS-ARMA'};

for iMethod = 1:2
    disp(legends_jpsd{iMethod})
    %% aPK
    aPKErr{1} = getOutputs(outputMat,'parJointFiltWJWSSCovPsd.err.aPK');
    %% bPK
    bQMErr{1} = getOutputs(outputMat,'parJointFiltWJWSSCovPsd.err.bQM');
    %% psd
    psdErr{1} = getOutputs(outputMat,'parJointFiltWJWSSCovPsd.err.psd');
    psdErr{2} = getOutputs(outputMat,'jwssCov.err.psd');
    if iMethod < 2
        %% aPK
        figure(1);
        semilogx(paramVect,mean(aPKErr{iMethod}),[marker(iMethod) '-'],'LineWidth',lineWidth)
        hold on;
        ylabel('Estimation Error of a')
        
        %% bPK
        figure(2);
        semilogx(paramVect,mean(bQMErr{iMethod}),[marker(iMethod) '-'],'LineWidth',lineWidth)
        hold on;
        ylabel('Estimation Error of b')
        
    end
    %% psd
    figure(3);
    semilogx(paramVect,mean(psdErr{iMethod}),[marker(iMethod) '-'],'LineWidth',lineWidth)
    hold on;
    ylabel('Estimation Error of JPSD')
end

for i = 1:3
    figure(i)
    xlabel(paramName)
    set(gca,'FontSize',fontSize)
    if i < 3
        legend(legends_ab)
    else
        legend(legends_jpsd)      
    end
    set(gca,'FontSize',fontSize)
    saveCurrentFigure(fullfile(outputPath, figureNames{i}));  
end