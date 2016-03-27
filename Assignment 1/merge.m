function [x] = merge(x, y)

	fields = fieldnames(y);

	for i = 1:size(fields,1)
    	x.(fields{i}) = y.(fields{i})
	end
