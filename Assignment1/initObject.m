function [handles] = initObject (handles)
	path = 'scarlet-witch.obj';
	[V, F] = loadObj(path);
	V = [V'; ones(1,length(V))];
	
	handles.object.V = Rx(90)*V;
	handles.object.F = F;