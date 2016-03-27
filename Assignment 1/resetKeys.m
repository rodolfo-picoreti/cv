function [handles] = resetKeys (handles, filter)

	for who = keys(handles.ranges)
		who = cell2mat(who);
		
		if filter(who)
			value = handles.initialValues(who);
			range = handles.ranges(who);
			ratio = map(range, [0,1], value);

			set(handles.(handles.edits(who)), 'String', num2str(value));
		  	set(handles.(handles.sliders(who)), 'Value', ratio);
		end
	end

	plotWorld(handles);