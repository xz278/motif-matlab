% This function calculators the meter distance between two gps coordinates
% INPUT: two locations g1 = [lat1,lon1], g2 = [lat2,lon2]
function d=gpsDist(g1,g2)
	% constant
	R = 6371000;
	dLat = abs(g1(1) - g2(1)) * pi / 180;
	dLon = abs(g1(2) - g2(2)) * pi / 180;
	lat1 = g1(1) * pi / 180;
	lat2 = g2(1) * pi / 180;
	a = sin(dLat/2)^2 + ...
		sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
	c = 2 * atan2(sqrt(a) , sqrt(1-a));
	d = R * c;
end