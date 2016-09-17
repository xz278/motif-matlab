% load testUser.mat

epss = [5,8,10,15,20,30,3,50];
minptss = [5,8,10,15,20];
% MA = {};
% MAF = {};
% MAS = {};
% MAFS = {};
% figure
% hold on
% y = -24;
% for epsi=1:length(epss)
% EPSILON = epss(epsi);
% 	for mpsi=1:length(minptss)
for epsi=7:8
EPSILON = epss(epsi);
	for mpsi=1:length(minptss)

% if (epsi==1) && (mpsi<=4)
% 	continue;
% end



MINPTS = minptss(mpsi);
ccnt = length(MA);
ccnt = ccnt + 1;

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
n = length(testUser);
userCluster = {};
motifData = [];
for i=1:n
	fprintf('user #%d...\n',i);
	fprintf('\n');
	currData = testUser{i};
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
		[locId,~] = DBSCAN2(seasons(:,3:4),MINPTS,EPSILON);
		locId = locId';
		% locId = DBSCAN(seasons(:,3:4),EPSILON,MINPTS);
		disp('DBSCAN done.');
		% uniqueIds = unique(locId)
		dataWOSeq = filterData(seasons,locId);

		userClustert{s} = dataWOSeq;

		% -------------------------------------------------------
		% [dailyNetWork, correspDayID] = formAdjMat(dataWOSeq);
		% -------------------------------------------------------

		if size(dataWOSeq,1)==0
			nodeDistt{s} = [];
			motifAllt{s} = {};
			motifSAllt{s} = {};

			motifFreqAllt{s} = [];
			motifFreqSAllt{s} = [];

			pctAllt{s} = []; % percentage
			cpctAllt{s} = [];
			pctSAllt{s} = [];
			cpctSAllt{s} = [];
			continue;
		end

		[dailyNetWork, correspDayID,locIds] = formAdjMat2(dataWOSeq);
		% -------------------------------------------------------

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
	% s1Idx = find(X(:,end)==1);
	% s1 = currData(s1Idx,:);
	% s2Idx = find(X(:,end)==2);
	% s1 = currData(s1Idx,:);
	% s3Idx = find(X(:,end)==3);
	% s3 = currData(s1Idx,:);
	% s4Idx = find(X(:,end)==4);
	% s4 = currData(s1Idx,:);
end

MA{ccnt} = motifAll;
MAF{ccnt} = motifFreqAll;
MAS{ccnt} = motifSAll;
MAFS{ccnt} = motifFreqSAll;

% generate motif statistics
n = length(testUser); % 87 users

overAllMotifs = {};
overAllMotifFreq = [];
cnt = 0;
for u=1:n
	currUserMotifs = motifAll{u};
	currUserMotifFreq = motifFreqAll{u};
	for s=1:4
		currSeasonMotif = currUserMotifs{s};
		currSeasonMotifFreq = currUserMotifFreq{s};
		numMotifs = length(currSeasonMotif);
		for i=1:numMotifs
			if cnt==0
				cnt = 1;
				overAllMotifs{1} = currSeasonMotif{i};
				overAllMotifFreq(1) = currSeasonMotifFreq(i);
				continue;
			end
			motifExist = 0;
			for j=1:cnt
				if compareGraph(overAllMotifs{j},currSeasonMotif{i})==1
					overAllMotifFreq(j) = overAllMotifFreq(j) + currSeasonMotifFreq(i);
					motifExist = 1;
					break;
				end
			end
			if motifExist==0
				cnt = cnt + 1;
				overAllMotifs{cnt} = currSeasonMotif{i};
				overAllMotifFreq(cnt) = currSeasonMotifFreq(i);
			end
		end		
	end
end

% sort motifs according to frequency
[v,i] = sort(overAllMotifFreq,'descend');
overAllMotifs = overAllMotifs(i);
overAllMotifFreq = overAllMotifFreq(i);

overAllPercentage = overAllMotifFreq / sum(overAllMotifFreq);
overAllCumPercentage = cumsum(overAllPercentage);

% draw motifs
x = 0;
y = y + 24;
x2 = 0;
y2 = y -12;
% figure
% hold on
% axis equal
numOverAllMotif = length(overAllMotifs);
endIdx = find(overAllCumPercentage>0.9,1);
for i=1:endIdx
	[~,nx,ny] = drawMotif(x,y,overAllMotifs{i});
	text((x+nx)/2,ny-4,num2str(i),'HorizontalAlignment','center','FontSize',8)
	x = nx;
	y = ny;
	[~,x2,y2] = drawRect(x2,y2,overAllPercentage(i));
end

end
end



% plot individual motifs cumulative 

% hold on
% for u=1:n
% 	% currUserMotifs = motifAll{u};
% 	% currUserMotifFreq = motifFreqAll{u};
% 	currUserCpct = cpctSAll{u};
% 	for s=1:4
% 		% currSeasonMotif = currUserMotifs{s};
% 		% currSeasonMotifFreq = currUserMotifFreq{s};
% 		currSeasonCpct = currUserCpct{s};
% 		% numMotifs = length(currSeasonMotif);
% 		l = length(currSeasonCpct);
% 		for i=1:l
% 			x = [1:l];
% 			y = currSeasonCpct;
% 			plot(x,y)
% 		end		
% 	end
% end