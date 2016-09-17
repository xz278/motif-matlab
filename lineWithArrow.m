%% lineWithArrow: function description
function h = lineWithArrow(startX,startY,endX,endY)
	dX = endX - startX;
	dY = endY - startY;
	h = quiver(startX,startY,dX,dY,1,'linewidth',2,'color','k','MaxHeadSize',0.5);
end