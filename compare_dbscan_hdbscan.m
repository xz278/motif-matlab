% compare_dbscan_hdbscan

% [locId,~] = DBSCAN2(seasons(:,3:4),MINPTS,EPSILON);
% locId = locId';
% % locId = DBSCAN(seasons(:,3:4),EPSILON,MINPTS);
% disp('DBSCAN done.');
% % uniqueIds = unique(locId)
% dataWOSeq = filterData(seasons,locId);






dataWOSeq = filterData2(u1,hdbr);
[dailyNetWork, correspDayID,locIds] = formAdjMat2(dataWOSeq);
[motifs,motifsFreq,pct,cpct,motifsS,motifFreqS,pctS,cpctS] = calculateMotifi2(dataWOSeq,dailyNetWork, correspDayID,locIds);

% plot motifs

x = 0;
y = 0;
x2 = 0;
y2 = y -15;
figure
hold on
axis equal
numOverAllMotif = length(motifs);
for i=1:numOverAllMotif
	[~,nx,ny] = drawMotif(x,y,motifs{i});
	text((x+nx)/2,(ny-2)/2,num2str(i),'HorizontalAlignment','center','FontSize',8)
	x = nx;
	y = ny;
	[~,~,~] = drawRect(x2,y2,1,[0.4,0.4,0.4]);
	[~,x2,y2] = drawRect(x2,y2,pct(i));
end



[locId,~] = DBSCAN2(x,10,10);
locId = locId';
% locId = DBSCAN(seasons(:,3:4),EPSILON,MINPTS);
% disp('DBSCAN done.');
% uniqueIds = unique(locId)
dataWOSeq = filterData(u1,locId);
[dailyNetWork, correspDayID,locIds] = formAdjMat2(dataWOSeq);
[motifs,motifsFreq,pct,cpct,motifsS,motifFreqS,pctS,cpctS] = calculateMotifi2(dataWOSeq,dailyNetWork, correspDayID,locIds);
