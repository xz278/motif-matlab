% preprocess data
% time, latitude, longtitude
% test: t = '2014-02-14T23:13:48.000Z,43.7066445,-72.2870903'


% fid = fopen(llldata.csv);
% fline = fgetl(fid);

% while ischar(fline)
% 	fields = strsplit(fline,','); % {time, latitude, longtitude}
% 	sTimes = strsplit(fields{1},'T'); % {yyyy-mm-dd, hh:mm:ss.000Z}
% 	sDate = strsplit(sTimes{1},'-'); % {yyyy, mm, dd}
% 	y = str2num(sDate{1})
% 	m = str2num(sDate{2})
% 	d = str2num(sDate{3})
% 	temp = strsplit(sTimes{2},'.'); % {hh:mm:ss, 000Z}
% 	sTime = strsplit(temp{1},':');	% {hh, mm, ss}
% 	h = str2num(sTime{1})
% 	mi = str2num(sTime{2})
% 	s = str2num(sTime{3});
% 	ss = datenum(y,m,d,h,mi,s)
% end

dataInit = formatData('llldata.csv'); % [time,lat,lon]
[values,idx] = sort(dataInit(:,1));
dataInit = dataInit(idx,:);
save dataInit.mat dataInit
epsilon = 10;
MinPts = 10;
locId = DBSCAN(dataInit(:,2:3),epsilon,MinPts);

% % rearrange data in the form of [locationID, dayID, lat, lon, abstime] excluding noisy points
% nonNoiseIdx = find(locId~=0);
% nonNoiseData = dataInit(nonNoiseIdx,:);
% dataWithSeq = [locId(nonNoiseIdx), floor(nonNoiseData(:,1)), ...
% 			   nonNoiseData(:,2:3),nonNoiseData(:,1)];

% dayOffSet = dataWithSeq(1,2)-1;
% dataWithSeq(:,2) = dataWithSeq(:,2)-dayOffSet;

% nDataWithSeq = size(dataWithSeq,1);
% idxWOSeq = zeros(nDataWithSeq);
% idxWOSeq(1) = 1;
% preLoc = dataWithSeq(1,1);
% for i=2:nDataWithSeq
% 	if dataWithSeq(i,2)~=dataWithSeq(i-1,2)
% 		preLoc = dataWithSeq(i,1);
% 		idxWOSeq(i) = 1;
% 		continue;
% 	end
% 	if dataWithSeq(i,1)==preLoc
% 		continue;
% 	else
% 		preLoc = dataWithSeq(i,1);
% 		idxWOSeq(i) = 1;
% 	end
% end

% dataWOSeqIdx = find(idxWOSeq==1);
% dataWOSeq = dataWithSeq(dataWOSeqIdx,:);


[dataWithSeq,dataWOSeq] = filterData(dataInit, locId);

% construct networks/adjacency matrix
% nfDays <-- number of daily data
[dailyNetWork, correspDayID] = formAdjMat(dataWOSeq);

% dailyNetWork = {};
% nDays = length(unique(fData(:,2))); % number of feasbile daily networks
% correspDayID = zeros(nDays,1);
% nEntry = size(fData,1);
% count = 0;
% st = 1;
% for i=2:nEntry
% 	if fData(i,2)~=fData(i-1,2)
% 		count = count + 1;
% 		tempNodes = unique(fData(st:i-1,1));
% 		numNodes = length(tempNodes);
% 		ntw = zeros(numNodes,numNodes);
% 		if numNodes>1
% 			for j=st+1:i-1
% 				locid = fData(j,1);
% 				preLocid = fData(j-1,1);
% 				if locid~=preLocid
% 					idx1 = find(tempNodes==preLocid);
% 					idx2 = find(tempNodes==locid);
% 					ntw(idx1,idx2) = 1;
% 				end
% 			end
% 		end
% 		dailyNetWork{count} = ntw;
% 		correspDayID(count) = fData(i-1,2);
% 		st = i;
% 	end
% end

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
% correspDayID(count) = fData(i-1,2);

% size of graph nodes
count = length(unique(dataWOSeq(:,2)));
disNodes = zeros(count,1);
for i=1:count
	disNodes(i)=size(dailyNetWork{i},2);
end

h2 = histogram(disNodes);

[motifs,motifsFreq,pct,cpct] = calculateMotifi(dataWOSeq);
[paths,pathFreq,pct2,cpct2] = pathAnalysis(dataWOSeq);