%% formAdjMat: form the adjacency matrix
% INPUT: data = [locationID,dayID,...]
function [dailyNetWork, correspDayID] = formAdjMat(fData)
	dailyNetWork = {};
	nDays = length(unique(fData(:,2))); % number of feasbile daily networks
	correspDayID = zeros(nDays,1);
	nEntry = size(fData,1);
	count = 0;
	st = 1;
	for i=2:nEntry-1
		if fData(i,2)~=fData(i-1,2)
			count = count + 1;
			tempNodes = unique(fData(st:i-1,1));
			numNodes = length(tempNodes);
			ntw = zeros(numNodes,numNodes);
			if numNodes>1
				for j=st+1:i-1
					locid = fData(j,1);
					preLocid = fData(j-1,1);
					if locid~=preLocid
						idx1 = find(tempNodes==preLocid);
						idx2 = find(tempNodes==locid);
						ntw(idx1,idx2) = 1;
					end
				end
			end
			dailyNetWork{count} = ntw;
			correspDayID(count) = fData(i-1,2);
			st = i;
		end
	end

	if nEntry==1
		dailyNetWork{1} = 0;
		correspDayID(1) = fData(1,2);
		return;
	end
	if fData(nEntry-1,2)==fData(nEntry,2)
		count = count + 1;
		tempNodes = unique(fData(st:nEntry,1));
		numNodes = length(tempNodes);
		ntw = zeros(numNodes,numNodes);
		if numNodes>1
			for j=st+1:nEntry
				locTo = fData(j,1);
				locFrom = fData(j-1,1);
				if locTo~=locFrom
					idxTo = find(tempNodes==locTo);
					idxFrom = find(tempNodes==locFrom);
					ntw(idxFrom,idxTo) = 1;
				end
			end
		end
		dailyNetWork{count} = ntw;
		correspDayID(count) = fData(end,2);
	else
		count = count + 1;
		tempNodes = unique(fData(st:nEntry-1,1));
		numNodes = length(tempNodes);
		ntw = zeros(numNodes,numNodes);
		if numNodes>1
			for j=st+1:nEntry-1
				locTo = fData(j,1);
				locFrom = fData(j-1,1);
				if locTo~=locFrom
					idxTo = find(tempNodes==locTo);
					idxFrom = find(tempNodes==locFrom);
					ntw(idxFrom,idxTo) = 1;
				end
			end
		end
		dailyNetWork{count} = ntw;
		correspDayID(count) = fData(end-1,2);

		count = count + 1;
		ntw = 0;
		dailyNetWork{count} = ntw;
		correspDayID(count) = fData(end,2);

	end
	% count = count + 1;
	% tempNodes = unique(fData(st:nEntry,1));
	% numNodes = length(tempNodes);
	% ntw = zeros(numNodes,numNodes);
	% if numNodes>1
	% 	for j=st+1:nEntry
	% 		locid = fData(j,1);
	% 		preLocid = fData(j-1,1);
	% 		if locid~=preLocid
	% 			idx1 = find(tempNodes==preLocid);
	% 			idx2 = find(tempNodes==locid);
	% 			ntw(idx1,idx2) = 1;
	% 		end
	% 	end
	% end
	% dailyNetWork{count} = ntw;
	% correspDayID
	% fData(i-1,2)
	% correspDayID(count) = fData(i-1,2);
end