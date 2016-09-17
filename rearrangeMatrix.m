% rearrange matrix with give index
function n = rearrangeMatrix(m, idx)
	d = size(m,1);
	n = zeros(d,d);
	for i=1:d
		for j=1:d
			% idx
			% n
			% m
			% i
			% j
			n(i,j) = m(idx(i),idx(j));
		end
	end
end