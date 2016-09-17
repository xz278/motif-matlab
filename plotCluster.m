%% plotCluster: function description
function f = plotCluster(X,idx)
	hasNoise = ismember(0,idx) || ismember(-1,idx);
	numCluster = length(unique(idx))-hasNoise;

	colors = rand(numCluster,3);



	f = figure;
	hold on

	if hasNoise
		if ismember(0,idx)==1
			noiseIdx = find(idx==0);
		else
			noiseIdx = find(idx==-1);
		end
		scatter(X(noiseIdx,1),X(noiseIdx,2));
	end


	for c=1:numCluster
		currCluster = find(idx==c);
		scatter(X(currCluster,1),X(currCluster,2),'MarkerFaceColor',colors(c,:),'MarkerEdgeColor','none')
	end

end
