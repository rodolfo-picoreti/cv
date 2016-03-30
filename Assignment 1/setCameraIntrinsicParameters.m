function setCameraIntrinsicParameters(f, r, s)
	global state;
	state.camera.focalLength = f;
  	state.camera.resolution = r;
  	state.camera.scales = s;
