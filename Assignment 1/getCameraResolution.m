function r = getCameraResolution()
	global state;
	r = [0 state.camera.resolution(1) 0 state.camera.resolution(2)];