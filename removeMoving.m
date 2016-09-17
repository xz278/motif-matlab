%% removeMoving: function description
%% Input: X = [id,time,lat,lon,speed,acc]
% OUTPUT: Y, filtered data; idx,0 for stationary points, 1 for moving points
function [Y,idx] = removeMoving(X)

	SPEEDLIMIT = 1; % speed limit: one meter/second

	n = size(X,1); % number of locations

	idx = zeros(n,1);
	for i=1:n
		if X(i,5)<=SPEEDLIMIT
			idx(i) = 1;
		end
	end

	idxToKeep = find(idx==1);
	Y = X(idxToKeep,:);

end