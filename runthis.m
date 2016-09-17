% convert raw data into an array of structs
% struct includes:



% add year, month, day, hour, minute, second, season attribute to selected data
timeformat = 'yyyy/mm/dd/HH/MM/SS';
n = length(validID);
a = vData{1};
w = size(a,2);
data2 = {};
for i=1:n
	currData = vData{i};
	m = size(currData,1);
	newData = [currData,zeros(m,7)];
	for j=1:m
		st = currData(j,2);
		timestring = datestr(st,timeformat);
		tspt = strsplit(timestring,'/');
		for p=1:6
			newData(j,w+p) = str2num(tspt{p});
		end
		mt = str2num(tspt{2}); % month
		% add season: 1-spring, 2-summer, 3-fall, 4-winter
		if (mt>=3) && (mt<=5)
			newData(j,end) = 1;
		elseif (mt>=6) && (mt<=8)
			newData(j,end) = 2;
		elseif (mt>=9) && (mt<=11)
			newData(j,end) = 3;
		else
			newData(j,end) = 4;
		end	
	end
	newData(:,1) = floor(newData(:,1));
	data2{i} = newData;
end

% data2 format: day, serialtime, lat,lon, speed, acc, y,m,d,h,m,s,season

for i=1:n
	currdata = data2{i};
	currdata(:,1) = floor(currdata(:,2));
	data2{i} = currdata;
end

% filterout days that do not have data for at least 8 hours

% threshold = 24 * 60 / 15 * 2 / 3;
% td = 12/24;
% data3 = {};
% for i=1:n
% 	currUser = data2{i};
% 	days = unique(currUser(:,1));
% 	m = length(days);
% 	chosen = [];
% 	for j=1:m
% 		currdayIdx = find(currUser(:,1)==days(j));
% 		z = length(currdayIdx); % number of logs for the present day
% 		if z >= threshold
% 			chosen = [chosen;currdayIdx];
% 		end
% 	end
% 	u = currUser(chosen,:);
% 	data3{i} = u;
% end


% numEntry = zeros(n,1);
% for i=1:n
% 	numEntry(i) = size(data3{i},1);
% end

threshold = 24 * 60 / 15 * 2 / 3;
td = 16/24;
data3 = {};

% second column is time
for i=1:n
	currUser = data2{i};
	days = unique(currUser(:,1));
	m = length(days);
	chosen = [];
	for j=1:m
		currdayIdx = find(currUser(:,1)==days(j));
		z = length(currdayIdx); % number of logs for the present day
		currTimeSpan = currUser(currdayIdx(end),2) - currUser(currdayIdx(1),2);
		if currTimeSpan >= td
			chosen = [chosen;currdayIdx];
		end
	end
	u = currUser(chosen,:);
	data3{i} = u;
end


numEntry = zeros(n,1);
for i=1:n
	numEntry(i) = size(data3{i},1);
end




numEntry2 = zeros(n,1);
for i=1:n
	numEntry2(i) = size(vData{i},1);
end

