function [handles] = initCamera (handles)
	path = 'reflex_camera.obj';
	[V, F] = loadObj(path);
	V = [V'; ones(1,length(V))];

	handles.camera.V = S(15)*V;
	handles.camera.F = F;