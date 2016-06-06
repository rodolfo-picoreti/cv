reset

# Axes
set style line 101 lc rgb '#808080' lt 1
set border 3 back ls 101
set tics nomirror out scale 0.75

# Grid
set style line 102 lc rgb'#808080' lt 0 lw 1
set grid back ls 102
set nokey
set grid

Line(x) = x*2.5 + 3

set style circle radius 0.05

plot 'data.mat' using 1:2 with circles lc rgb "blue", \
	  Line(x) lt 2 lc rgb "green" dt 1 lw 2, \
     'inliers.mat' using 1:2 with points pt 4 ps 2 lc rgb "red", \
     'inliers.mat' using 1:2 with line lt 2 lc rgb "orange" dt 3 lw 2 \
	  
