function [handles] = resetCamera (handles)
	handles = resetKeys(handles, @(who) strfind(who, 'Cam'));
