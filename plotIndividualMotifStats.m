n = length(testUser);

u1 = 1;
u3 = n;
u2 = floor(n / 2);

testUser2 = testUser([u1,u2,u3]);

UM = {};
UMF = {};
UMS = {};
UMSF = {};

for u=1:3
fprintf('user #%d...\n',u);
fprintf('\n');
umotif = {};
umotiffreq = {};
umotifS = {};
umotiffreqS = {};

epss = [3,5,8,10,15,20,30,50];
minptss = [5,8,10,15,20];
for epsi=1:length(epss)
EPSILON = epss(epsi);
	for mpsi=1:length(minptss)
MINPTS = minptss(mpsi);

fprintf('parameters: eps = %d, minpts = %d...\n',EPSILON,MINPTS);
fprintf('\n');


tcnt = length(umotif);
tcnt = tcnt + 1;

tempum = {};
tempumf = [];
tempumS = {};
tempumfS = [];


currData = testUser2{u};
% remove moving points
[X,~] = removeMoving(currData);
for s=1:4
	% fprintf('season %d... \n',s)
	sIdx = find(X(:,end)==s);
	if length(sIdx)==0
		continue;
	end
	seasons = currData(sIdx,:);
	% disp('DBSCAN running...')
	[locId,~] = DBSCAN2(seasons(:,3:4),MINPTS,EPSILON);
	locId = locId';
	dataWOSeq = filterData(seasons,locId);
	if size(dataWOSeq,1)==0
		continue;
	end

	[dailyNetWork, correspDayID,locIds] = formAdjMat2(dataWOSeq);
	% -------------------------------------------------------

	[motifs,motifsFreq,pct,cpct,motifsS,motifFreqS,pctS,cpctS] = calculateMotifi2(dataWOSeq,dailyNetWork, correspDayID,locIds);

	l1 = length(motifs);
	for ml=1:l1
		l2 = length(tempum);
		if l2==0
			tempum{1} = motifs{ml};
			tempumf(1) = motifsFreq(ml);
		else
			motifExist = 0;
			for nl=1:l2
				if compareGraph(tempum{nl},motifs{ml})==1
					tempumf(nl) = tempumf(nl) + motifsFreq(ml);
					motifExist = 1;
					break;
				end
			end
			if motifExist==0
				tempum{l2+1} = motifs{ml};
				tempumf(l2+1) = motifsFreq(ml);
			end
		end
	end

	l1 = length(motifsS);
	for ml=1:l1
		l2 = length(tempumS);
		if l2==0
			tempumS{1} = motifsS{ml};
			tempumfS(1) = motifFreqS(ml);
		else
			motifExist = 0;
			for nl=1:l2
				[isISM, ~] = compareGraph2(tempumS{nl},motifsS{ml});
				if isISM==1
					tempumfS(nl) = tempumfS(nl) + motifFreqS(ml);
					motifExist = 1;
					break;
				end
			end
			if motifExist==0
				tempumS{l2+1} = motifsS{ml};
				tempumfS(l2+1) = motifFreqS(ml);
			end
		end
	end
end % for s=1:4

umotif{tcnt} = tempum;
umotiffreq{tcnt} = tempumf;
umotifS{tcnt} = tempumS;
umotiffreqS{tcnt} = tempumfS;

end
end % for parameters in eps x minpts

UM{u} = umotif;
UMF{u} = umotiffreq;
UMS{u} = umotifS;
UMSF{u} = umotiffreqS;


end % for u=1:3