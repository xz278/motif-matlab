% generate the list of combinations
function list = findPmtIdx(srcIdx)
	list = helper(srcIdx,[],[]);

	function gList = helper(idx,gList,currList)
		m = size(idx,1);
		if m==0
			% gList
			% currList
			gList = [gList,currList];
			return;
		else
			for i=1:m
				v = idx(i);
				currList = [currList;v];
				newIdx = [idx(1:i-1,1);idx(i+1:end,1)];
				gList = helper(newIdx,gList,currList);
				currList = currList(1:end-1,1);
			end
		end
	end

end