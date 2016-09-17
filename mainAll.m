%% mainAll: function description
function [motifAll,pathAll,motifSAll,...
		  motifFreqAll,pathFreqAll,motifFreqSAll,...
		  pctAll,cpctAll,pctpAll,cpctpAll,pctSAll,cpctSAll,nodeDist] = mainAll(usrCnt,usrData,usrID)

EPSILON = 10;
MINPTS = 10;

motifAll = {};
pathAll = {};
motifSAll = {};

motifFreqAll = {};
pathFreqAll = {};
motifFreqSAll = {};

pctAll = {}; % percentage
cpctAll = {};
pctpAll = {};
cpctpAll = {};
pctSAll = {};
cpctSAll = {};
nodeDist = {};




for u=1:usrCnt
	fprintf('Current user ID: %s, count = %d...\n',usrID{u},u);
	fprintf('\n');
	dataInit = usrData{u};
	locId = DBSCAN(dataInit(:,2:3),EPSILON,MINPTS);
	% uniqueIds = unique(locId)
	[dataWithSeq,dataWOSeq] = filterData(dataInit, locId);
	[dailyNetWork, correspDayID] = formAdjMat(dataWOSeq);
	count = length(unique(dataWOSeq(:,2)));
	disNodes = zeros(count,1); % number of nodes for everyday network
	maxNumNodes = -1;
	distribution = zeros(10000,1);
	for i=1:count
		currSize = size(dailyNetWork{i},2);
		disNodes(i)=currSize;
		if currSize>maxNumNodes
			maxNumNodes = currSize;
		end
		if currSize>size(distribution,1)
			distribution = [distribution;zeros(10000,1)];
		end
		distribution(currSize) = distribution(currSize)+1;
	end
	distribution = distribution(1:maxNumNodes,1);
	nodeDist{u} = distribution;
	numberOfNodes = maxNumNodes

	% h2 = histogram(disNodes);

	[motifs,motifsFreq,pct,cpct] = calculateMotifi(dataWOSeq);
	[paths,pathFreq,pctp,cpctp] = pathAnalysis(dataWOSeq);
	[motifsS, motifFreqS ,pctS, cpctS] = motifSpecified(dataWOSeq);
	motifAll{u} = motifs;
	pathAll{u} = paths;
	motifSAll{u} = motifsS;

	motifFreqAll{u} = motifsFreq;
	pathFreqAll{u} = pathFreq;
	motifFreqSAll{u} = pctp;

	pctAll{u} = pct; % percentage
	cpctAll{u} = cpct;
	pctpAll{u} = pctp;
	cpctpAll{u} = cpctp;
	pctSAll{u} = pctS;
	cpctSAll{u} = cpctS;
end



end