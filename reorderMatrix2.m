% reorder the adjacency matrix

% test
% a = [0,1,1,0,0;...
% 	 1,0,0,0,0;...
% 	 0,0,0,1,0;...
% 	 0,0,1,0,1;...
% 	 1,0,0,0,0]
% b = [0,1,0,0,0;...
% 	 1,0,1,0,0;...
% 	 0,0,0,0,1;...
% 	 0,0,0,0,1;...
% 	 1,0,0,1,0]
% ===========================================
% INPUT: oriLoc (numNodes * 1) location id for each node
function [n,reorderedLoc] = reorderMatrix2(m,oriLoc)
	nNodes = size(m,2);
	sortedIdx = (1:nNodes)';
	for i=2:nNodes
		p = i;
		% sortedIdx;
		while p>1
			if compareNodes(m,sortedIdx(p-1),sortedIdx(p))>=0
				break;
			else
				sortedIdx = swapNodes(sortedIdx,p,p-1);
			end
			p = p-1;
		end
	end
	n = zeros(nNodes,nNodes);
	for i=1:nNodes
		for j=1:nNodes
			n(i,j)=m(sortedIdx(i),sortedIdx(j));
		end
	end
	reorderedLoc = oriLoc(sortedIdx);
end