% compare two nodes (M, a, b) based on outdegree and then indgree
% return 1 if a has higher degrees, 0 same, -1 lower degree
% Input: M the adjacency matrix; a,b are two nodes
function cmp=compareNodes(M,a,b)
	cmp = 0;
	% outdegree and indegree
	ao = sum(M(a,:));
	bo = sum(M(b,:));
	ai = sum(M(:,a));
	bi = sum(M(:,b));
	if ao > bo
		cmp = 1;
	elseif ao == bo
		if ai > bi
			cmp = 1;
		elseif ai == bi
			cmp = 0;
		else
			cmp = -1;
		end
	else
		cmp = -1;
	end
end