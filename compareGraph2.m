% Compare whether two graphs are isomophical
% test
% a = [0,0,1; 0,0,0; 1,0,0];
% b = [0,1,0; 1,0,0;,0,0,0];

function [isISM, locIds] = compareGraph2(a,b)
	% if numer of nodes are different,return false
	isISM = 0;
	locIds = -1;
	nodesA = size(a,2);	
	nodesB = size(b,2);
	sumDegA = sum(a(:));
	sumDegB = sum(b(:));
	if (nodesA ~= nodesB) || (sumDegA ~= sumDegB)
		isISM = 0;
		return;
	end
	compA = zeros(nodesA,1);
	compB = zeros(nodesB,1);
	for i=1:nodesA
		compA(i) = sum(a(i,:));
		compB(i) = sum(b(i,:));
	end
	compA = sort(compA);
	compB = sort(compB);
	if issame(compA,compB)==0
		isISM = 0;
		return;
	end


	b = reorderMatrix(b);
	% assume the target motif has already been reordered
	trgOut = sum(b,2);
	trgIn = sum(b,1)';
	srcOut = sum(a,2);
	srcIn = sum(a,1)';
	to = trgOut(1);
	ti = trgIn(1);
	nt = 1;
	matrixToCompare = zeros(0,1);
	for i=2:nodesB
		if trgOut(i)==to(nt) && trgIn(i)==ti(nt)
			continue;
		else
			nt = nt+1;
			to(nt) = trgOut(i);
			ti(nt) = trgIn(i);
		end
	end
	to = to';
	ti = ti';
	for i=1:nt
		[idx, nv] = findSameDegree(srcOut, srcIn, to(i), ti(i));
		if nv==0
			isISM = 0;
			return;
		else
			pmtIdx = findPmtIdx(idx);
			oldN = size(matrixToCompare,2);
			oldEnd = size(matrixToCompare,1);
			nPmt = size(pmtIdx,2);
			matrixToCompare = repmat(matrixToCompare,1,nPmt);
			matrixToCompare = [matrixToCompare;zeros(nv,oldN*nPmt)];
			w = size(matrixToCompare,2);
			if oldN==0
				matrixToCompare = pmtIdx;
			else
				v = 0;
				v2 = 1;
				for j=1:w
					v = v+1;
					if v>oldN
						v = 1;
						v2 = v2 + 1;
					end
					matrixToCompare(oldEnd+1:end,j) = pmtIdx(:,v2);
				end
			end
		end
	end

	if size(matrixToCompare,1)~=nodesB
		isISM = 0;
		return;
	end

	l = size(matrixToCompare,2);
	for i=1:l
		currGraph = rearrangeMatrix(a, matrixToCompare(:,i));
		if issame(currGraph,b)
			isISM = 1;
			locIds = matrixToCompare(:,i);
			return;
		end
	end

	% -----------------------------------------
	% reorder
	% a = reorderMatrix(a)
	% b = reorderMatrix(b)
	% compare nodes pare wise/row by row
	% isISM = cmpRowByRow(a,b,1);

end