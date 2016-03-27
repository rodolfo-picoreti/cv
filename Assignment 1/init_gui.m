function [handles] = init_gui(handles)
	handles = initHandles(handles);
	handles = init_object(handles);
	handles = init_camera(handles);

	handles.world.axis = [-100, 100, -100, 100, -20, 130];
	plot_world(handles);

function [handles] = init_object(handles)
	obj_path = 'scarlet-witch.obj';
	[V, F] = load_obj(obj_path);
	V = [V'; ones(1,length(V))];
	
	handles.object.V = Rx(pi/2)*V;
	handles.object.F = F;

function [handles] = init_camera(handles)
	camera_path = 'reflex_camera.obj';
	[V, F] = load_obj(camera_path);
	V = [V'; ones(1,length(V))];

	handles.camera.V = S(15)*V;
	handles.camera.F = F;




