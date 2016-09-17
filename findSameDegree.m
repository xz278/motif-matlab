% find the vertex with the same in/out degree
% Input: out/in degree for source (where to look at)
%        out/in degree for target (what to look for)
% Output: idx for vertex if any
%         number of vertex found
function [idx, nv] = findSameDegree(srcOut, srcIn, trgOut, trgIn)
	idx = zeros(0,1);
	nv = 0;
	nNodes = size(srcOut,1);
	for i=1:nNodes
		if srcOut(i)==trgOut && srcIn(i)==trgIn
			nv = nv+1;
			idx(nv,1) = i;
		end
	end
end