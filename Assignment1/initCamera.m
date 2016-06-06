function [handles] = initCamera (handles)
	path = 'reflex_camera.obj';
	[V, F] = loadObj(path);
	V = [V'; ones(1,length(V))];

	handles.camera.V = Rz(180)*S(15)*V;
	handles.camera.V(2,:) = -handles.camera.V(2,:); 
	handles.camera.F = F;