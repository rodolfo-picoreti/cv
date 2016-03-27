function [handles] = updateEdit(handles, who)
	%% Read and validate input 
	string = handles.(handles.edits(who)).String;
	value = str2double(string);
	range = handles.ranges(who);
	value = saturate(range, value);

	ratio = map(range, [0,1], value);
	
	%% Update depedent objects
	handles.(handles.edits(who)).String = num2str(value);
  	handles.(handles.sliders(who)).Value = ratio;

