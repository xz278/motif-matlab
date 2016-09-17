%% drawMotif: function description
function [h,endX,endY] = drawMotif(x,y,motif)

	numNodes = size(motif,2);
	switch numNodes
		case 1
			% margin-left: 1.5
			% margin-buttom: 3
			hold on
			h = drawCircle(x+2.5,y+1.5,0.5,'k','none',1);
			endX = x+5;
			endY = y;
		case 2	
			% margin-left,right: 1.5
			xs = [x+2.5,x+2.5];
			ys = [y,y+3];
			hold on
			h1 = drawCircle(xs(1),ys(1),0.5,'k','none',1);
			h2 = drawCircle(xs(2),ys(2),0.5,'k','none',1);
			h = [h1, h2];
			endX = x+5;
			endY = y;
		case 3
			hold on
			xs = [x+2.5,x+1,x+4];
			ys = [y+3,y,y];
			h1 = drawCircle(x+5/2,y+3,0.5,'k','none',1);
			h2 = drawCircle(x+1,y,0.5,'k','none',1);
			h3 = drawCircle(x+4,y,0.5,'k','none',1);
			h = [h1, h2, h3];
			endX = x+5;
			endY = y;
		case 4
			hold on
			xs = [x+1,x+1,x+4,x+4];
			ys = [y+3,y,y,y+3];
			h1 = drawCircle(x+1,y+3,0.5,'k','none',1);
			h2 = drawCircle(x+1,y,0.5,'k','none',1);
			h3 = drawCircle(x+4,y,0.5,'k','none',1);
			h4 = drawCircle(x+4,y+3,0.5,'k','none',1);
			h = [h1, h2, h3, h4];
			endX = x+5;
			endY = y;
		case 5
			hold on
			xs = [x+1,x+1,x+4,x+4,x+2.5];
			ys = [y+3,y+0.5,y+0.5,y+3,y+5.5];
			h1 = drawCircle(x+1,y+3,0.5,'k','none',1);
			h2 = drawCircle(x+1,y,0.5,'k','none',1);
			h3 = drawCircle(x+4,y,0.5,'k','none',1);
			h4 = drawCircle(x+4,y+3,0.5,'k','none',1);
			h5 = drawCircle(x+2.5,y+5.5,0.5,'k','none',1);
			h = [h1, h2, h3, h4, h5];
			endX = x+5;
			endY = y;
		case 6
			hold on
			xs = [x+1,x+1,x+4,x+4,x+2.5,x+2.5];
			ys = [y+3,y+0.5,y+0.5,y+3,y+5.5,y-2.5];
			h1 = drawCircle(x+1,y+3,0.5,'k','none',1);
			h2 = drawCircle(x+1,y,0.5,'k','none',1);
			h3 = drawCircle(x+4,y,0.5,'k','none',1);
			h4 = drawCircle(x+4,y+3,0.5,'k','none',1);
			h5 = drawCircle(x+2.5,y+5.5,0.5,'k','none',1);
			h6 = drawCircle(x+2.5,y-2.5,0.5,'k','none',1);
			h = [h1, h2, h3, h4, h5, h6];
			endX = x+5;
			endY = y;
		case 7
			hold on
			xs = [x+1,x+1,x+4,x+4,x+2.5,x+1,x+4];
			ys = [y+3,y+0.5,y+0.5,y+3,y+5.5,y-3,y-3];
			h1 = drawCircle(x+1,y+3,0.5,'k','none',1);
			h2 = drawCircle(x+1,y,0.5,'k','none',1);
			h3 = drawCircle(x+4,y,0.5,'k','none',1);
			h4 = drawCircle(x+4,y+3,0.5,'k','none',1);
			h5 = drawCircle(x+2.5,y+5.5,0.5,'k','none',1);
			h6 = drawCircle(x+1,y-3,0.5,'k','none',1);
			h7 = drawCircle(x+4,y-3,0.5,'k','none',1);
			h = [h1, h2, h3, h4, h5, h6, h7];
			endX = x+5;
			endY = y;
		case 8
			hold on
			xs = [x+1,x+1,x+1,x+4,x+4,x+4,x+4,x+1];
			ys = [y+3,y,y-3,y-3,y,y+3,y+6,y+6];
			h1 = drawCircle(x+1,y+3,0.5,'k','none',1);
			h2 = drawCircle(x+1,y,0.5,'k','none',1);
			h3 = drawCircle(x+1,y-3,0.5,'k','none',1);
			h4 = drawCircle(x+4,y-3,0.5,'k','none',1);
			h5 = drawCircle(x+4,y,0.5,'k','none',1);
			h6 = drawCircle(x+4,y+3,0.5,'k','none',1);
			h7 = drawCircle(x+4,y+6,0.5,'k','none',1);
			h8 = drawCircle(x+1,y+6,0.5,'k','none',1);
			h = [h1, h2, h3, h4, h5, h6, h7,h8];
			endX = x+5;
			endY = y;
		otherwise
			disp('figure not available.')
	end


	hline = [];
	for n=1:numNodes
		for m=1:numNodes
			if (n==m) || (motif(n,m)==0) || ((n>m) && (motif(m,n)==1))
				continue;
			end
			if (n>m) || ((n<m) && (motif(m,n)==0))
				lon = sqrt((xs(n)-xs(m))^2 + (ys(n)-ys(m))^2);
				sinalpha = (ys(m)-ys(n)) / lon;
				cosalpha = (xs(m)-xs(n)) / lon;
				r = 0.5;
				dx = (r+0.05) * cosalpha;
				dy = (r+0.05) * sinalpha;
				% dy = 0
				l = lineWithArrow(xs(n)+dx,ys(n)+dy,xs(m)-dx,ys(m)-dy);
				hline = [hline,l];
			else
				lon = sqrt((xs(n)-xs(m))^2 + (ys(n)-ys(m))^2);
				sinalpha = (ys(m)-ys(n)) / lon;
				cosalpha = (xs(m)-xs(n)) / lon;
				r = 0.5;
				dx = (r+0.05) * cosalpha;
				dy = (r+0.05) * sinalpha;
				
				alphaDegree = asin(sinalpha);
				beta = alphaDegree + pi / 2;
				sinbeta = sin(beta);
				cosbeta = cos(beta);
				t = 0.15;
				dx2 = t * cosbeta;
				dy2 = t * sinbeta;

				l1 = lineWithArrow(xs(n)+dx+dx2,ys(n)+dy+dy2,xs(m)-dx+dx2,ys(m)-dy+dy2);
				l2 = lineWithArrow(xs(m)-dx-dx2,ys(m)-dy-dy2,xs(n)+dx-dx2,ys(n)+dy-dy2);

				hline = [hline,l1,l2];
			end
		end
	end
	h = [h, hline];




end
