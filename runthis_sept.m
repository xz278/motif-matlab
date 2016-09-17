idxtc = find(numEntry>100);
numEntry2 = numEntry(idxtc);
tempdata = data3(idxtc);
tempuserid = v
nn = length(numEntry2);
[sortedNumEntry,sneindex] = sort(numEntry2);
testUser = {};
cnt = 0;
stepsize = floor(nn/10 - 1);
for i=1:stepsize:nn
	cnt = cnt + 1;
	testUser{cnt} = tempdata{sneindex(i)};
end