%% formatData: function description
function [outPutData] = formatData(fileName)

	entryCnt = 0;
	dataSize = 10000;
	outPutData = zeros(dataSize,3); % [serializedTime, latitude, longtitude]

	fid = fopen(fileName);
	fline = fgetl(fid);
	while ischar(fline)
		entryCnt = entryCnt+1;
		if entryCnt>dataSize
			dataSize = dataSize+10000;
			outPutData = [outPutData;zeros(10000,3)];
		end
		fields = strsplit(fline,','); % {time, latitude, longtitude}
		sTimes = strsplit(fields{1},'T'); % {yyyy-mm-dd, hh:mm:ss.000Z}
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
		outPutData(entryCnt,1) = serializedTime;
		outPutData(entryCnt,2) = str2num(fields{2});
		outPutData(entryCnt,3) = str2num(fields{3});
		fline = fgetl(fid);
	end
	fclose(fid);
	outPutData = outPutData(1:entryCnt,:);
	[vl,idx] = sort(outPutData(1:end,1));
	outPutData = outPutData(idx,:);
end