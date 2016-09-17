%% scatterUser: function description
function X = scatterUser(users,i)
	usr = users{i};
	X = usr(:,3:4);
	f = scatter(usr(:,3),usr(:,4),'filled');
	title('Original');
end
