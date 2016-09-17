function [h,x,y] = drawRect(x,y,percentage,clr)
	if nargin==3
		clr = 'c';
	end
	h = fill([x+1.7, x+3.3, x+3.3, x+1.7],...
		 [y,y,y+10*percentage,y+10*percentage],...
		 clr,...
		 'EdgeColor','None');
	x = x+5;
	y = y;
end