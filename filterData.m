%% filterData: function description
% INPUT: raw data = [day,time,lat,lon,...], location Id = Idx
% OUTPUT: rearrange data in the form of [locationID, dayID, lat, lon, abstime] excluding noisy points
% containing sequence of the places visited or not
function [dataWOSeq] = filterData(dataInit,locId)

	[h,w] = size(dataInit);

	nonNoiseIdx = find(locId~=-1);
	% nonNoiseIdx = find(locId~=0);
	fprintf('number of clusters: %d \n', length(unique(locId(nonNoiseIdx))));
	if length(nonNoiseIdx)==0
		dataWOSeq = zeros(0,w);
		return;
	end
	nonNoiseData = dataInit(nonNoiseIdx,:);
	dataWithSeq = [locId(nonNoiseIdx), nonNoiseData(:,1), ...
				   nonNoiseData(:,3:4),nonNoiseData(:,2)];


	dayOffSet = dataWithSeq(1,2)-1;
	dataWithSeq(:,2) = dataWithSeq(:,2)-dayOffSet;

	nDataWithSeq = size(dataWithSeq,1);
	idxWOSeq = zeros(nDataWithSeq);
	idxWOSeq(1) = 1;
	preLoc = dataWithSeq(1,1);
	for i=2:nDataWithSeq
		if dataWithSeq(i,2)~=dataWithSeq(i-1,2)
			preLoc = dataWithSeq(i,1);
			idxWOSeq(i) = 1;
			continue;
		end
		if dataWithSeq(i,1)==preLoc
			continue;
		else
			preLoc = dataWithSeq(i,1);
			idxWOSeq(i) = 1;
		end
	end

	dataWOSeqIdx = find(idxWOSeq==1);
	dataWOSeq = dataWithSeq(dataWOSeqIdx,:);

end