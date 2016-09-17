%% drawCircle: function description
function h = drawCircle(centerX,centerY,r,facecolor,edgecolor,linewidth)
	pos = [centerX-r, centerY-r, 2*r, 2*r];
	h = rectangle('Position',pos,'Curvature',[1 1],'facecolor',facecolor,'edgecolor',edgecolor,'linewidth',linewidth);
end