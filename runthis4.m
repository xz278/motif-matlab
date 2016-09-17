% generate motif statistics
n = 87; % 87 users

overAllMotifs = {};
overAllMotifFreq = [];
cnt = 0;
for u=1:n
	currUserMotifs = motifAll{u};
	currUserMotifFreq = motifFreqAll{u};
	for s=1:4
		currSeasonMotif = currUserMotifs{s};
		currSeasonMotifFreq = currUserMotifFreq{s};
		numMotifs = length(currSeasonMotif);
		for i=1:numMotifs
			if cnt==0
				cnt = 1;
				overAllMotifs{1} = currSeasonMotif{i};
				overAllMotifFreq(1) = currSeasonMotifFreq(i);
				continue;
			end
			motifExist = 0;
			for j=1:cnt
				if compareGraph(overAllMotifs{j},currSeasonMotif{i})==1
					overAllMotifFreq(j) = overAllMotifFreq(j) + currSeasonMotifFreq(i);
					motifExist = 1;
					break;
				end
			end
			if motifExist==0
				cnt = cnt + 1;
				overAllMotifs{cnt} = currSeasonMotif{i};
				overAllMotifFreq(cnt) = currSeasonMotifFreq(i);
			end
		end		
	end
end

% sort motifs according to frequency
[v,i] = sort(overAllMotifFreq,'descend');
overAllMotifs = overAllMotifs(i);
overAllMotifFreq = overAllMotifFreq(i);

overAllPercentage = overAllMotifFreq / sum(overAllMotifFreq);
overAllCumPercentage = cumsum(overAllPercentage);

% draw motifs
x = 0;
y = 0;
figure
hold on
axis equal
numOverAllMotif = length(overAllMotifs);
for i=1:20
	[~,nx,ny] = drawMotif(x,y,overAllMotifs{i});
	text((x+nx)/2,(ny-2)/2,num2str(i),'HorizontalAlignment','center','FontSize',8)
	x = nx;
	y = ny;
end

% plot individual motifs cumulative 

hold on
for u=1:n
	% currUserMotifs = motifAll{u};
	% currUserMotifFreq = motifFreqAll{u};
	currUserCpct = cpctSAll{u};
	for s=1:4
		% currSeasonMotif = currUserMotifs{s};
		% currSeasonMotifFreq = currUserMotifFreq{s};
		currSeasonCpct = currUserCpct{s};
		% numMotifs = length(currSeasonMotif);
		l = length(currSeasonCpct);
		for i=1:l
			x = [1:l];
			y = currSeasonCpct;
			plot(x,y)
		end		
	end
end