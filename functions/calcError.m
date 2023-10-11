function err = calcError(origFilter,estFilter)
    if(isfield(estFilter,'aPK'))
        [pOrig, kOrig] = size(origFilter.aPK);
        [pEst,kEst] = size(estFilter.aPK);
        maxP = max(pOrig,pEst);
        maxK = max(kOrig,kEst);
        aPK = zeros(maxP, maxK);
        aPK(1:pEst,1:kEst) = estFilter.aPK;
        estFilter.aPK = aPK;
        err.aPK =  calculateNormalizedErrForSynthetics(origFilter.aPK,estFilter.aPK);
        %disp([ 'aPK error : ' num2str(err.aPK)]) ; 
    end
    if(isfield(estFilter,'bQM'))
        [qOrig, mOrig] = size(origFilter.bQM);
        [qEst,mEst] = size(estFilter.bQM);
        maxQ = max(qOrig,qEst);
        maxM = max(mOrig,mEst);
        bQM = zeros(maxQ, maxM);
        bQM(1:qEst,1:mEst) = estFilter.bQM;
        estFilter.bQM = bQM;
        err.bQM =  calculateNormalizedErrForSynthetics(origFilter.bQM,estFilter.bQM);
        %disp([ 'bQM error : ' num2str(err.bQM)]);
    end
    if(isfield(estFilter,'jointFilter'))
        err.jointFilter =  calculateNormalizedErrForSynthetics(origFilter.jointFilter,estFilter.jointFilter);
        %disp([ 'jointFilter error : ' num2str(err.jointFilter)]);
    end
    if(isfield(estFilter,'psd'))
        err.psd =  calculateNormalizedErrForSynthetics(origFilter.psd,estFilter.psd);
        %disp([ 'psd error : ' num2str(err.psd)]);
    end
    end