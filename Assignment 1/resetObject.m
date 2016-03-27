function [handles] = resetObject (handles)
	handles = resetKeys(handles, @(who) strfind(who, 'Obj'));
