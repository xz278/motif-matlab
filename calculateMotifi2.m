%% calculateMotifi: function description
%% INPUT: data = [locationID, dayID, lat, lon, abstime]
%% OUTPUT: motfs, motifsFreqency, percentages, cumulated percentages in sorted order
function [motifs,motifsFreq,pct,cpct,motifsS,motifsSFreq,pctS,cpctS] = calculateMotifi2(fData,dailyNetWork, correspDayID,locIds)

	% [dailyNetWork, correspDayID, locIds] = formAdjMat2(fData);

	% motifs
	nDays = length(unique(fData(:,2)));
	motifs = {};
	motifsFreq = [];
	countMotif = 0;
	countMotifSpec = 0;
	motifsSFreq = [];
	motifsS = {};
	motifSLoc = {};
	for i=1:nDays
		if countMotif==0
			[newMotifi, reorderedLoc] = reorderMatrix2(dailyNetWork{i},locIds{i});
			countMotif = countMotif+1;
			motifs{countMotif} = newMotifi;
			motifsFreq(countMotif) = 1;
			
			countMotifSpec = countMotifSpec+1;
			motifsS{1} = newMotifi;
			motifsSFreq(1) = 1;
			motifSLoc{1} = reorderedLoc;
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

		motifsSExist = 0;
		for j=1:countMotifSpec
			[isISM, locIDs2] = compareGraph2(dailyNetWork{i},motifsS{j});
			if (isISM==1) && issame(locIDs2,motifSLoc{j})>0
				motifsSExist = 1;
				motifsSFreq(j) = motifsSFreq(j)+1;
				break;
			end
		end
		if motifsSExist==0
			[newMotifi,reorderedLoc] = reorderMatrix2(dailyNetWork{i},locIds{i});
			countMotifSpec = countMotifSpec+1;
			motifsS{countMotifSpec} = newMotifi;
			motifsSFreq(countMotifSpec) = 1;
			motifSLoc{countMotifSpec} = reorderedLoc;
		end



	end

	[sortedValues,sortedIdx] = sort(motifsFreq,'descend');
	numMotif = sum(motifsFreq);
	pct = sortedValues/numMotif;
	motifs = motifs(sortedIdx);
	motifsFreq = motifsFreq(sortedIdx);
	cpct = cumsum(pct);

	[sortedValues,sortedIdx] = sort(motifsSFreq,'descend');
	numMotif = sum(motifsSFreq);
	pctS = sortedValues/numMotif;
	motifsS = motifsS(sortedIdx);
	motifsSFreq = motifsSFreq(sortedIdx);
	cpctS = cumsum(pctS);
end