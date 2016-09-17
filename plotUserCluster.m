%% plotUserCluster: function description
function X = plotUserCluster(usr,i,MinPts,EPS)
close all
X = scatterUser(usr,i);
[IDX, ~]=DBSCAN(X,EPS,MinPts);
[class,~]=DBSCAN2(X,MinPts,EPS);
plotCluster(X,IDX);
title('DBSCAN-1');
plotCluster(X,class);
title('DBSCAN-2');