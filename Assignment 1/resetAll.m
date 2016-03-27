function [handles] = resetAll (handles)
	handles = resetKeys(handles, @(who) 1);