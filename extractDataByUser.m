%% extractDataByUser: function description
function [usrID,usrData,usrCnt] = extractDataByUser(filename)

fid = fopen(filename);
fl = fgetl(fid);
% fl = fgetl(fid); % skip title
usrID = {}; % a cell array of usr id/string
usrData = {}; % a cell array of matrix 
usrCnt = 0;
while ischar(fl)
	fields = strsplit(fl,',');

	% identify user
	usr = fields{1};
	usrExist = 0;
	currUsrCnt = 0;
	for u=1:usrCnt
		if strcmp(usr,usrID{u})==1
			usrExist = 1;
			currUsrCnt = u;
			break;
		end
	end
	if usrExist==0
		usrCnt = usrCnt+1;
		currUsrCnt = usrCnt;
		usrData{currUsrCnt} = zeros(0,5); % [time,lat,lon,speed,acc]
		usrID{usrCnt} = usr;
	end

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
	newEntry = [serializedTime,str2num(fields{3}),str2num(fields{4}),...
				str2num(fields{5}),str2num(fields{6})];
	currData = usrData{currUsrCnt};
	currData = [currData;newEntry];
	usrData{currUsrCnt} = currData;
	fl = fgetl(fid);
end

% sort data according to time user by user
for u=1:usrCnt
	currData = usrData{u};
	[v,si] = sort(currData(:,1));
	usrData{u} = currData(si,:);
end


fclose(fid);

end
