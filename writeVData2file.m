function writeVData2file(filename,validData,ids)
	fid  = fopen(filename,'w');
	numUser = length(validData);
	TIMEFORMAT = 'yyyy/mm/dd/HH/MM/SS';
	% output file format: id,time,lat,lon,speed
	fid = fopen(filename,'w');
	for u = 1:numUser
		currUser = validData{u};
		currId = ids{u};
		numEntry = length(currUser);
		for i = 1:numEntry
			fprintf(fid,'%s,%s,%.6f,%.6f,%.4f\n',currId,datestr(currUser(i,2),TIMEFORMAT),...
					currUser(i,3),currUser(i,4),currUser(i,5));
		end
	end
	fclose(fid)
end