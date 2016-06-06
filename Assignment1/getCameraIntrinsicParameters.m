function [parameters] = getCameraIntrinsicParameters()
	global state;
	parameters.focalLength = state.camera.focalLength;
	parameters.resolution = state.camera.resolution; 
	parameters.scales = state.camera.scales; 
