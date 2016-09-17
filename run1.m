nUser = length(data3);
datasize = zeros(nUser,1);
for u=1:nUser
	datasize(u) = size(data3{u},1);
end

[sortdatasize, idx] = sort(datasize,'descend');

for u = 1:10
	filename = ['u',num2str(u),'.csv'];
	cu = data3{idx(u)};
	csvwrite(filename,cu(:,2:5));
end