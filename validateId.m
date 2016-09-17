%% validateId: function description
function isValid = validateId(id)
	isValid = 0;
	if strcmp(id(1),'u')==0
		return;
	end

	if ismember('_',id)==0
		return;
	end

	splits = strsplit(id,'_');
	if length(splits)~=2	
		return;
	end

	a = splits{1};
	b = splits{2};
	if length(b)<3
		return;
	end
	if (strcmp(a(1),'u')==1) && (strcmp(b(1:3),'rct')==1)
		isValid=1;
	end
end
