function [] = initializeState()
	global state;
	state.camera.focalLength = 50;
	state.camera.resolution = [640 480]; 
	state.camera.scales = [10 10]; 
