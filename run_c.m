overAllMotifs = motifs;
overAllMotifFreq = motiffreq;

[v,i] = sort(overAllMotifFreq,'descend');
overAllMotifs = overAllMotifs(i);
overAllMotifFreq = overAllMotifFreq(i);

overAllPercentage = overAllMotifFreq / sum(overAllMotifFreq);
overAllCumPercentage = cumsum(overAllPercentage);


x = 0;
y = -24;
y = y + 24;
x2 = 0;
y2 = y -14;
hold on

for i=1:length(overAllMotifs)
	[~,nx,ny] = drawMotif(x,y,overAllMotifs{i});
	text((x+nx)/2,ny-3,num2str(i),'HorizontalAlignment','center','FontSize',8)
	x = nx;
	y = ny;
	[~,~,~] = drawRect(x2,y2,1,[0.7 0.7 0.7]);
	[~,x2,y2] = drawRect(x2,y2,overAllPercentage(i));
end
