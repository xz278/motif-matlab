%% pathAnalysis: 
%% INPUT: data = [locationID, dayID, lat, lon, abstime]
%% OUTPUT: paths, pathFreq, percentages, cumulated percentages in sorted order
function [paths,pathFreq,pctp,cpctp] = pathAnalysis(data)

	paths = {};
	pathFreq = [];
	cntPath = 0;
	currPath = data(1,1);
	n = size(data,1);
	for i=2:n
		if data(i,2)==data(i-1,2)
			currPath = [currPath,data(i,1)];
		else
			pathExist = 0;
			for j=1:cntPath
				if issame(paths{j},currPath)==0
					continue;
				else
					pathExist = 1;
					break;
				end
			end
			if pathExist==1
				pathFreq(j) = pathFreq(j)+1;
			else
				cntPath = cntPath+1;
				paths{cntPath} = currPath;
				pathFreq(cntPath) = 1;
			end
			currPath = data(i,1);
		end
	end

	[sortedValues,sortedIdx] = sort(pathFreq,'descend');
	numPath = sum(pathFreq);
	pctp = sortedValues/numPath;
	paths = paths(sortedIdx);
	pathFreq = pathFreq(sortedIdx);
	cpctp = cumsum(pctp);

end
