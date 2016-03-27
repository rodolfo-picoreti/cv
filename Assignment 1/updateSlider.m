function [handles] = updateSlider(handles, who)
  	ratio = get(handles.(handles.sliders(who)), 'Value');
	range = handles.ranges(who);
  	value = map([0, 1], range, ratio);

	%% Update depedent objects
	set(handles.(handles.edits(who)), 'String', num2str(value));

