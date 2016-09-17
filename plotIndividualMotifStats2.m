% plotIndividualMotifStats2.m

u = 3;
tempCurr = UM{u};
tempCurrFreq = UMF{u};

n = length(tempCurr);

epss = [3,5,8,10,15,20,30,50];
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
	% if i==6
	% 	break;
	% end
	overAllMotifFreq = tempCurrFreq{i};
	overAllMotifs = tempCurr{i};
	numOverAllMotif = length(overAllMotifs);
	[~,si] = sort(overAllMotifFreq,'descend');
	overAllMotifs = overAllMotifs(si);
	overAllMotifFreq = overAllMotifFreq(si);
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

	if numOverAllMotif==0
		text(2,y,'no data','HorizontalAlignment','right','FontSize',8);
		text(-2,y,tempText,'HorizontalAlignment','right','FontSize',8);
	else
		endIdx = find(overAllCumPercentage>0.9,1);
		tempText = ['eps = ',num2str(labels(i,1)),', minpts = ',num2str(labels(i,2))];
		text(-2,y,tempText,'HorizontalAlignment','right','FontSize',8);
		for i=1:endIdx
			[~,nx,ny] = drawMotif(x,y,overAllMotifs{i});
			text((x+nx)/2,ny-4,num2str(i),'HorizontalAlignment','center','FontSize',8)
			x = nx;
			y = ny;
			[~,~,~] = drawRect(x2,y2,1,[0.4,0.4,0.4]);
			[~,x2,y2] = drawRect(x2,y2,overAllPercentage(i));
			
		end
	end
end