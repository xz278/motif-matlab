% x, y is the lower left conner coordinate
function h = drawFreq(x,y,freq)
	hold on
	freqSum = sum(freq);
	freqPercentage = freq / freqSum;
	n = length(freq);
	for i=1:n
		[temph,x,y] = drawRect(x,y,freqPercentage(i));
	end
end