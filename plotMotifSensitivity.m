% load testUser
epss = [5,8,10,15,20,30,3,50];
minptss = [5,8,10,15,20];
figure
hold on
y = -24;

overAllSens = {};
overAllSensF = {};

for ii=1:length(epss)
	for jj=1:length(minptss)
		cnt2 = length(overAllSens) + 1;
		tempText = ['EPS = ', num2str(epss(ii)), ', MinPts = ', num2str(minptss(jj))];

		motifAll = MA{cnt2};
		motifFreqAll = MAF{cnt2};
		% MAS{ccnt} = motifSAll;
		% MAFS{ccnt} = motifFreqSAll;

		% generate motif statistics
		n = length(motifAll); % 87 users

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

		overAllSens{cnt2} = overAllMotifs;
		overAllSensF{cnt2} = overAllMotifFreq;


		overAllPercentage = overAllMotifFreq / sum(overAllMotifFreq);
		overAllCumPercentage = cumsum(overAllPercentage);

		% draw motifs
		x = 0;
		y = y + 24;
		x2 = 0;
		y2 = y -12;
		% figure
		% hold on
		% axis equal
		numOverAllMotif = length(overAllMotifs);
		endIdx = find(overAllCumPercentage>0.9,1);
		for i=1:endIdx
			[~,nx,ny] = drawMotif(x,y,overAllMotifs{i});
			text((x+nx)/2,ny-4,num2str(i),'HorizontalAlignment','center','FontSize',8)
			x = nx;
			y = ny;
			[~,x2,y2] = drawRect(x2,y2,overAllPercentage(i));
		end
	end
end