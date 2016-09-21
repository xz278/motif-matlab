function [motifs,motiffreq] = motifread(filename)
	motifs = {};
	motiffreq = [];
	fid = fopen(filename,'r');
	line = fgetl(fid);
	while line ~= -1
		cells = strsplit(line,',');
		numOfVertices = str2num(cells{1});
		isInterch = str2num(cells{2});
		freq = str2num(cells{3});
		currmotif = zeros(numOfVertices,numOfVertices);
		for i = 1:numOfVertices
			line = fgetl(fid);
			cells = strsplit(line,',');
			for j=1:numOfVertices
				v = str2num(cells{j});
				if v == 1
					currmotif(i,j) = 1;
				end
			end
		end
		nmotif = length(motifs)+1;
		motifs{nmotif} = currmotif;
		motiffreq(nmotif) = freq;
		line = fgetl(fid);
	end
	fclose(fid)
end