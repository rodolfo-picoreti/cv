%% reprojerror: function description

function [e] = reprojerror(u1, u2, H)
	e12 = normscale(H*u1) - u2;
	e12 = sqrt(sum(e12.*e12, 1));
	
	e21 = normscale(inv(H)*u2) - u1;
	e21 = sqrt(sum(e21.*e21, 1));
	
  e = e12 + e21;