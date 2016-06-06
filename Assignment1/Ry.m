%rotation matrix y-axis
function [R] = Ry (theta)
  R = [cosd(theta), 	0.0, 	sind(theta), 	0.0;
       0.0, 		1.0, 	0.0, 			0.0;
       -sind(theta), 0.0, 	cosd(theta),  	0.0; 
       0.0, 		0.0, 	0.0,	 		1.0];
