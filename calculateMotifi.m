%% calculateMotifi: function description
%% INPUT: data = [locationID, dayID, lat, lon, abstime]
%% OUTPUT: motfs, motifsFreqency, percentages, cumulated percentages in sorted order
function [motifs,motifsFreq,pct,cpct] = calculateMotifi(fData)

	[dailyNetWork, correspDayID] = formAdjMat(fData);

	% motifs
	nDays = length(unique(fData(:,2)));
	motifs = {};
	motifsFreq = [];
	countMotif = 0;
	for i=1:nDays
		if countMotif==0
			newMotifi = reorderMatrix(dailyNetWork{i});
			countMotif = countMotif+1;
			motifs{countMotif} = newMotifi;
			motifsFreq(countMotif) = 1;
			continue;
		end
		motifsExist = 0;
		for j=1:countMotif
			if compareGraph(dailyNetWork{i},motifs{j})==1
				motifsExist = 1;
				motifsFreq(j) = motifsFreq(j)+1;
				break;
			end
		end
		if motifsExist==0
			newMotifi = reorderMatrix(dailyNetWork{i});
			countMotif = countMotif+1;
			motifs{countMotif} = newMotifi;
			motifsFreq(countMotif) = 1;
		end
	end

	[sortedValues,sortedIdx] = sort(motifsFreq,'descend');
	numMotif = sum(motifsFreq);
	pct = sortedValues/numMotif;
	motifs = motifs(sortedIdx);
	motifsFreq = motifsFreq(sortedIdx);
	cpct = cumsum(pct);

end