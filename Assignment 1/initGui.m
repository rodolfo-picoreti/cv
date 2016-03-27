function [handles] = initGui (handles)
	handles = initHandles(handles);
	handles = initObject(handles);
	handles = initCamera(handles);

	plotWorld(handles);
