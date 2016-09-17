function array = swapNodes(array,a,b)
	% function swaped = swap(array,a,b)
	temp = array(a,1);
	array(a,1) = array(b,1);
	array(b,1) = temp;
end
