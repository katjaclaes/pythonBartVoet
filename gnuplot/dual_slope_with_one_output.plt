set terminal pngcairo dashed
set output 'dual_slope_with_one_output.png'

set xrange [0:1100];
set yrange [0:8];

scale = 256

#unset ytics;

set grid xtics lt 0 lw 1 lc rgb "#880000"
set ytics ("0" 1, "1" 2, "0" 3, "127" 4, "255" 5 )
set xtics 256

set label "50/2%" center at 128-64,1 offset 0, 0.8
set label "50/2%" center at 256+128+64,1 offset 0, 0.8
set arrow from 256+128,1 to 256+128+128,1 heads
set arrow from 0,1 to 128,1 heads

set arrow from 0,4 to 256 * 8 - 128,4 nohead ls 3

plot '-' using ($1*scale):(($2*1)) title "Square 1" with lines, \
     '-' using ($1*scale):($2*1) title "Single slope" with lines lt 1 lc 2, \
     '-' using ($1*scale):($2*1) title "Compare 1" with impulses
	0 2
	0.5 2
	0.5 1
	1.5 1
	1.5 2
	2 2
	2.5 2
	2.5 1
	3.5 1
	3.5 2
	4 2
	4.5 2
	4.5 1
	5.5 1
	5.5 2
	6 2
	6.5 2
	6.5 1
	7.5 1
	7.5 2
	8 2
EOF
	0 3
	1 5
	2 3
	3 5
	4 3
	5 5
	6 3
	7 5
	8 3
EOF
	0.5 4	
	1.5 4
	2.5 4	
	3.5 4
	4.5 4	
	5.5 4
	6.5 4
	7.5 4
EOF

show grid;
#pause -1;
