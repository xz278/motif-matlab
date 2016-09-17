%% getOverAllMotifDistribution: function description
% INPUT: motifs from all user in the form of cell arrays
function [motifs,motifDistribution] = getOverAllMotifDistribution(motifsFromUser)

numUser = length(motifsFromUser);
motifs = {};
motifDistribution = [];
for u=1:numUser
	currUserMotifs = motifsFromUser{u};
	if ~strcmp('cell',class(currUserMotifs))
		continue;
	end
	numMotif = length(csuburrUserMotifs);
	for m=1:numMotif
		currUserMotif = currUserMotifs{m};
		numDiffMotif = length(motifs);
		motifExist = 0;
		for i=1:numDiffMotif
			if compareGraph(currUserMotif,motifs{i})==1
				motifDistribution(i) = motifDistribution(i) + 1;
				motifExist = 1;
				break;
			end
		end
		if motifExist==0
			motifs{numDiffMotif+1} = currUserMotif;
			motifDistribution(numDiffMotif+1) = 1;
		end
	end
end

end
