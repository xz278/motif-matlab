%% formatData2: transform raw data into numerical metrix
function [] = formatData2(filename)


fid = fopen(filename);
fl = fgetl(fid);
% fl = fgetl(fid); % skip title
usrID = {}; % a cell array of usr id/string
usrData = {}; % a cell array of matrix 
currUserId = 'nothisuserwkjwfijwoeifjwe089';
lineCnt = 1;
usrCnt = 0;
while ischar(fl)
	fields = strsplit(fl,',');

	% calculate date num
	sTimes = strsplit(fields{2},'T'); % {yyyy-mm-dd, hh:mm:ss.000Z}
	sDate = strsplit(sTimes{1},'-'); % {yyyy, mm, dd}
	y = str2num(sDate{1});
	m = str2num(sDate{2});
	d = str2num(sDate{3});
	temp = strsplit(sTimes{2},'.'); % {hh:mm:ss, 000Z}
	sTime = strsplit(temp{1},':');	% {hh, mm, ss}
	h = str2num(sTime{1});
	mi = str2num(sTime{2});
	s = str2num(sTime{3});
	serializedTime = datenum(y,m,d,h,mi,s);
	newEntry = [0,serializedTime,str2num(fields{3}),str2num(fields{4}),...
				str2num(fields{5}),str2num(fields{6})];

	% identify user
	usr = fields{1};
	if strcmp(usr,currUserId)==1
		newEntry(1) = usrCnt;
		currUser = usrData{usrCnt};
		currUser = [currUser;newEntry];
		usrData{usrCnt} = currUser;
	else
		currUserId = usr;
		fprintf('Done.\n');
		fprintf('current user: %s\n',usr);
		usrCnt = usrCnt+1;
		newEntry(1) = usrCnt;
		currUser = newEntry;
		usrData{usrCnt} = currUser;
		usrID{usrCnt} = usr;
	end

	fl = fgetl(fid);
	lineCnt = lineCnt+1;
end

% sort data according to time user by user
for u=1:usrCnt
	currData = usrData{u};
	[v,si] = sort(currData(:,1));
	usrData{u} = currData(si,:);
end


fclose(fid);

end