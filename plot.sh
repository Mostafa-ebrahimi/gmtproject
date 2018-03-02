
psfile2=plot.ps
	

#!/bin/bash
#		GMT EXAMPLE 06
#
# Purpose:	Make standard and polar histograms
# GMT modules:	pshistogram, psrose
# Unix progs:	rm
#

gmt pshistogram -Bxa2000f1000+l"Topography (m)" -Bya10f5+l"Frequency"+u" %" \
	-BWSne+t"Histograms"+glightblue v3206.t -R-6000/0/0/30 -JX4.8i/2.4i -Gorange -O \
	-Y5.0i -X-0.5i -L1p -Z1 -W250 >>  $psfile2
	
ps2pdf $psfile2
