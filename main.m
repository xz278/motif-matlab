%% main: function description
% input file format: [time,lat,lon]
function [motifs,motifsFreq,pct,cpct,paths,pathFreq,pctp,cpctp,motifsS, motifFreqS ,pctS, cpctS, h2] = main(fileName)
	dataInit = formatData(fileName);
	[values,idx] = sort(dataInit(:,1));
	dataInit = dataInit(idx,:);
	% save dataInit.mat dataInit
	epsilon = 10;
	MinPts = 10;
	locId = DBSCAN(dataInit(:,2:3),epsilon,MinPts);

	[dataWithSeq,dataWOSeq] = filterData(dataInit, locId);
	[dailyNetWork, correspDayID] = formAdjMat(dataWOSeq);
	count = length(unique(dataWOSeq(:,2)));
	disNodes = zeros(count,1);
	for i=1:count
		disNodes(i)=size(dailyNetWork{i},2);
	end

	h2 = histogram(disNodes);

	[motifs,motifsFreq,pct,cpct] = calculateMotifi(dataWOSeq);
	[paths,pathFreq,pctp,cpctp] = pathAnalysis(dataWOSeq);
	[motifsS, motifFreqS ,pctS, cpctS] = motifSpecified(dataWOSeq);