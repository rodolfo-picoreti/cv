function [handles] = initGui (handles)
	handles = initHandles(handles);
	handles = initObject(handles);
	handles = initCamera(handles);
	
	handles = resetAll(handles);

	plotWorld(handles);
