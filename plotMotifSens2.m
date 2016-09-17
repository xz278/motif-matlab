n = length(overAllSens);

epss = [5,8,10,15,20,30,3,50];
minptss = [5,8,10,15,20];
labels = zeros(length(epss)*length(minptss),2);
cnt = 0;
for i=1:length(epss)
	for j=1:length(minptss)
		cnt = cnt + 1;
		labels(cnt,1) = epss(i);
		labels(cnt,2) = minptss(j);
	end
end



for i=1:n
	overAllMotifFreq = overAllSensF{i};
	overAllMotifs = overAllSens{i};
	numOverAllMotif = length(overAllMotifs);
	overAllPercentage = overAllMotifFreq / sum(overAllMotifFreq);
	overAllCumPercentage = cumsum(overAllPercentage);

	% draw motifs
	if rem(i,5)==1
		figure
		hold on
		axis off
		axis equal
		y = -24;
	end
	x = 0;
	y = y + 24;
	x2 = 0;
	y2 = y -12;
	% figure
	% hold on
	% axis equal
	endIdx = find(overAllCumPercentage>0.9,1);
	tempText = ['eps = ',num2str(labels(i,1)),', minpts = ',num2str(labels(i,2))];
	text(-2,y,tempText,'HorizontalAlignment','right','FontSize',8);
	for j=1:endIdx
		[~,nx,ny] = drawMotif(x,y,overAllMotifs{j});
		text((x+nx)/2,ny-4,num2str(j),'HorizontalAlignment','center','FontSize',8)
		x = nx;
		y = ny;
		[~,~,~] = drawRect(x2,y2,1,[0.4,0.4,0.4]);
		[~,x2,y2] = drawRect(x2,y2,overAllPercentage(j));
	end
end