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


epss = [5,10,15];
minptss = [5,10,15];
mss = {};
mssf = {};
cnt = 0;
for i=1:3
	e = epss(i);
	for j=1:3
		m = minptss(j);
		fn = [num2str(e),num2str(m),'.csv'];
		[motifs,motiffreq] = motifread(fn);
		cnt = cnt+1;
		mss{cnt} = motifs;
		mssf{cnt} = motiffreq;
	end
end

cnt = 0;
for i=1:3
	e = epss(i);
	figure
	hold on
	y = -24;
	% y = y + 24;
	% y2 = y -14;
	for i2=1:3
			x = 0;
		y = y + 24;
		x2 = 0;
		y2 = y -12;
		m = minptss(i2);
		cnt = cnt + 1;


		overAllMotifs = mss{cnt};
		overAllMotifFreq = mssf{cnt};

		% [v,i] = sort(overAllMotifFreq,'descend');
		% overAllMotifs = overAllMotifs(i);
		% overAllMotifFreq = overAllMotifFreq(i);
		numOverAllMotif = length(overAllMotifs);
		overAllPercentage = overAllMotifFreq / sum(overAllMotifFreq);
		overAllCumPercentage = cumsum(overAllPercentage);
		endIdx = find(overAllCumPercentage>0.9,1);
		tempText = ['eps = ',num2str(e),', minpts = ',num2str(m)];
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
end