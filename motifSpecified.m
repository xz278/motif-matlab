%% motifSpecified: function description
%% INPUT: data = [locationID, dayID, lat, lon, abstime]
%% OUTPUT: motifs, motifFreq, percentages, cumulated percentages in sorted order
function [motifsS, motifFreqS ,pctS, cpctS] = motifSpecified(data)

	nEntry = size(data,1);
	motifsS = {};
	motifFreqS = [];
	cnt = 0;
	days = unique(data(:,2));
	nDays = length(days);
	for d = 1:nDays
		currDayIdx = find(data(:,2)==days(d));
		nEntryCurrDay = length(currDayIdx);
		currData = data(currDayIdx,:);
		nodes = [];
		cntNodes = 0;
		ntw = zeros(nEntryCurrDay,1);
		for i=1:nEntryCurrDay
			if ismember(currData(i,1),nodes)==1
				ntw(i) = find(nodes==currData(i,1));
			else
				cntNodes = cntNodes+1;
				nodes(cntNodes) = currData(i,1);
				ntw(i) = cntNodes;
			end
		end

		motifExist = 0;
		for j = 1:cnt
			if issame(motifsS{j},ntw)==0
				continue;
			else
				motifExist = 1;
				motifFreqS(j) = motifFreqS(j)+1;
				break;
			end
		end
		if motifExist==0
			cnt = cnt+1;
			motifsS{cnt} = ntw;
			motifFreqS(cnt) = 1;
		end
	end


	[sortedValues,sortedIdx] = sort(motifFreqS,'descend');
	numMotifsS = sum(motifFreqS);
	pctS = sortedValues/numMotifsS;
	motifsS = motifsS(sortedIdx);
	motifFreqS = motifFreqS(sortedIdx);
	cpctS = cumsum(pctS);

end