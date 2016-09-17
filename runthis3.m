i = 22;

% EPSILON = 10;
% MINPTS = 10;


fprintf('Current user ID: %s, count = %d...\n',usrID{validID(i)},i);
fprintf('\n');
currData = data3{i};
% remove moving points
[X,~] = removeMoving(currData);
motifAllt = {};
motifSAllt = {};

motifFreqAllt = {};
motifFreqSAllt = {};

pctAllt = {}; % percentage	
cpctAllt = {};
pctSAllt = {};
cpctSAllt = {};
userClustert = {};
nodeDistt = {};
for s=1:4
	fprintf('season %d... \n',s)
	sIdx = find(X(:,end)==s);
	if length(sIdx)==0
		if s==4
			motifAllt{s} = [];
			motifSAllt{s} = [];

			motifFreqAllt{s} = [];
			motifFreqSAllt{s} = [];

			pctAllt{s} = 0; % percentage
			cpctAllt{s} = 0;
			pctSAllt{s} = 0;
			cpctSAllt{s} = 0;

			nodeDistt{s} = [];
		end
		continue;
	end
	seasons = currData(sIdx,:);
	disp('DBSCAN running...')
	% [locId,~] = DBSCAN2(dataInit(:,2:3),MINPTS,EPSILON);
	locId = DBSCAN(seasons(:,3:4),MINPTS,EPSILON);
	disp('DBSCAN done.');
	% locId = locId';
	% uniqueIds = unique(locId)
	dataWOSeq = filterData(seasons,locId);
	userClustert{s} = dataWOSeq;
	[dailyNetWork, correspDayID,locIds] = formAdjMat2(dataWOSeq);
	% [dailyNetWork, correspDayID] = formAdjMat(dataWOSeq);
	% length(dailyNetWork)
	% length(locIds)
	count = length(unique(dataWOSeq(:,2)));
	disNodes = zeros(count,1); % number of nodes for everyday network
	maxNumNodes = -1;
	distribution = zeros(10000,1);
	for d=1:count
		currSize = size(dailyNetWork{d},2);
		disNodes(d)=currSize;
		if currSize>maxNumNodes
			maxNumNodes = currSize;
		end
		if currSize>size(distribution,1)
			distribution = [distribution;zeros(10000,1)];
		end
		distribution(currSize) = distribution(currSize)+1;
	end
	distribution = distribution(1:maxNumNodes,1);
	nodeDistt{s} = distribution;

	% h2 = histogram(disNodes);

	[motifs,motifsFreq,pct,cpct,motifsS,motifFreqS,pctS,cpctS] = calculateMotifi2(dataWOSeq,dailyNetWork, correspDayID,locIds);

	% [motifs,motifsFreq,pct,cpct] = calculateMotifi(dataWOSeq);
	% [motifsS, motifFreqS ,pctS, cpctS] = motifSpecified(dataWOSeq);
	motifAllt{s} = motifs;
	motifSAllt{s} = motifsS;

	motifFreqAllt{s} = motifsFreq;
	motifFreqSAllt{s} = motifFreqS;

	pctAllt{s} = pct; % percentage
	cpctAllt{s} = cpct;
	pctSAllt{s} = pctS;
	cpctSAllt{s} = cpctS;

end

nodeDist{i} = nodeDistt;

userCluster{i} = userClustert;
motifAll{i} = motifAllt;
motifSAll{i} = motifSAllt;

motifFreqAll{i} = motifFreqAllt;
motifFreqSAll{i} = motifFreqSAllt;

pctAll{i} = pctAllt; % percentage
cpctAll{i} = cpctAllt;
pctSAll{i} = pctSAllt;
cpctSAll{i} = cpctSAllt;